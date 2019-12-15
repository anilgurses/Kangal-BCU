// Copyright (c) Microsoft. All rights reserved.
// Licensed under the MIT license.
// To get started please visit https://microsoft.github.io/azure-iot-developer-kit/docs/projects/remote-monitoring/?utm_source=ArduinoExtension&utm_medium=ReleaseNote&utm_campaign=VSCode
// https://stackoverflow.com/questions/40246601/double-way-serial-communication-between-arduino-and-qt-5-7
#include "Arduino.h"
#include "Sensor.h"
#include "AzureIotHub.h"
#include "AZ3166WiFi.h"
#include "DevKitMQTTClient.h"
#include "Telemetry.h"
#include "SystemTime.h"
#include "SystemTickCounter.h"


#define RGB_LED_BRIGHTNESS 32
#define INTERVAL 1000

static bool isConnected = false;

DevI2C *ext_i2c;
HTS221Sensor *ht_sensor;
LPS22HBSensor *lp_sensor;

char wifiBuff[128];

int r = 0;
int g = 0;
int b = 0;

float temperature = 50;
char temperatureUnit = 'C';
float humidity = 50;
char humidityUnit = '%';
float pressure = 55;
const char *pressureUnit = "psig";

const char *roomSchema = "chiller-sensors;v1";
const char *interval = "00:00:05";
const char *deviceType = "Chiller";
const char *deviceFirmware = "1.0.0";
const char *deviceFirmwareUpdateStatus = "";
const char *deviceLocation = "Madrid";
const double deviceLatitude = 40.418371;
const double deviceLongitude =-3.797997;

#define RECONNECT_THRESHOLD 3

const char *twinProperties="{\"Protocol\": \"MQTT\", \"SupportedMethods\": \"Reboot,FirmwareUpdate,LedColor\", \"Telemetry\": { \"%s\": {\"Interval\": \"%s\",\"MessageTemplate\": \"{\\\"temperature\\\":${temperature},\\\"temperature_unit\\\":\\\"${temperature_unit}\\\", \\\"humidity\\\":${humidity},\\\"humidity_unit\\\":\\\"${humidity_unit}\\\",\\\"pressure\\\":${pressure},\\\"pressure_unit\\\":\\\"${pressure_unit}\\\"}\",\"MessageSchema\": {\"Name\": \"%s\",\"Format\": \"JSON\",\"Fields\": {\"temperature\": \"Double\", \"temperature_unit\": \"Text\",\"humidity\": \"Double\",\"humidity_unit\": \"Text\",\"pressure\": \"Double\",\"pressure_unit\": \"Text\" } } } },\"Type\": \"%s\",\"Firmware\": \"%s\",\"Model\":\"AZ3166\",\"FirmwareUpdateStatus\": \"%s\",\"Location\": \"%s\",\"Latitude\": %f,\"Longitude\": %f}";

bool sendDeviceInfo()
{
  char reportedProperties[2048];
  snprintf(reportedProperties,2048, twinProperties,roomSchema, interval ,roomSchema,deviceType,deviceFirmware,deviceFirmwareUpdateStatus,deviceLocation,deviceLatitude,deviceLongitude);
  return DevKitMQTTClient_ReportState(reportedProperties);
}

void twinCallback(DEVICE_TWIN_UPDATE_STATE updateState, const unsigned char *payLoad, int length){
  LogInfo("*** Twin State: %s",updateState?"Complete":"Partial");
}

RGB_LED rgbLed;
uint8_t colors[][3] = {
        {255, 0, 0},                // red
        {0, 255, 0},                // green
        {0, 0, 255},                // blue
        {0, 0, 0},
        {255, 255, 0},
        {0, 255, 255},
        {255, 0, 255},
        {255, 255, 255}
    };
uint8_t colorindex;
bool doReset=false;

int device_method_callback(const char *methodName, const unsigned char *payload, int length, unsigned char **response, int *responseLength){

  LogInfo("*** Remote method: %s",methodName);  

  if(strcmp(methodName,"LedColor")==0){
    int n=sizeof(colors)/sizeof(colors[0]);
    uint8_t *color=colors[(colorindex++)%n];
    rgbLed.setColor(color[0],color[1],color[2]);

    const char *ok="{\"result\":\"OK\"}";
    *responseLength=strlen(ok);
    *response = (unsigned char*)malloc(*responseLength);
    strncpy((char *)(*response), ok, *responseLength);
    return 200;
  }

  if(strcmp(methodName,"Reboot")==0){
    doReset=true;
    
    const char *reset="{\"result\":\"RESET\"}";    
    *responseLength=strlen(reset);
    *response = (unsigned char*)malloc(*responseLength);
    strncpy((char *)(*response), reset, *responseLength);
    return 201;
  }

  LogError("*** Remote method: %s not found",methodName);
  return 500;
}

void InitWiFi()
{
  Screen.print("WiFi \r\n \r\nConnecting...\r\n             \r\n");
  
  if(WiFi.begin() == WL_CONNECTED)
  {
    IPAddress ip = WiFi.localIP();
    sprintf(wifiBuff, "WiFi \r\n %s\r\n %s \r\n \r\n",WiFi.SSID(),ip.get_address());
    Screen.print(wifiBuff);
    isConnected = true;
  }
  else
  {
    sprintf(wifiBuff, "WiFi  \r\n             \r\nNo connection\r\n                 \r\n");
    Screen.print(wifiBuff);
  }
}

void sendData(const char *data, const char *schema){
  time_t t = time(NULL);
  char buf[sizeof "2011-10-08T07:07:09Z"];
  strftime(buf, sizeof buf, "%FT%TZ", gmtime(&t));

  EVENT_INSTANCE* message = DevKitMQTTClient_Event_Generate(data, MESSAGE);

  DevKitMQTTClient_Event_AddProp(message, "$$CreationTimeUtc", buf);
  DevKitMQTTClient_Event_AddProp(message, "$$MessageSchema", schema);
  DevKitMQTTClient_Event_AddProp(message, "$$ContentType", "JSON");
  
  DevKitMQTTClient_SendEventInstance(message);
}

void showSensors()
{
  try
  {
    ht_sensor->reset();
    ht_sensor->getTemperature(&temperature);
    //convert from C to F
    //temperature = temperature*1.8 + 32;

    ht_sensor->getHumidity(&humidity);

    lp_sensor->getPressure(&pressure);

    Serial.println(temperature, 1);
    Serial.println(humidity, 1);
    Serial.println(pressure, 1);

    char buff[128];
    sprintf(buff, "Environment \r\n Temp:%s%c    \r\n Humidity:%s%c  \r\n Atm: %s%s",f2s(temperature, 1),temperatureUnit, f2s(humidity, 1), humidityUnit, f2s(pressure,1), pressureUnit);
    Screen.print(buff);
    
    char sensorData[200];
    sprintf_s(sensorData, sizeof(sensorData), "{\"temperature\":%s,\"temperature_unit\":\"%c\",\"humidity\":%s,\"humidity_unit\":\"%c\",\"pressure\":%s,\"pressure_unit\":\"%s\"}", f2s(temperature, 1), temperatureUnit,f2s(humidity, 1), humidityUnit,f2s(pressure, 1), pressureUnit);
    //sendData(sensorData,roomSchema);
  }
  catch(int error)
  {
    LogError("*** Read sensor failed: %d",error);
  }
}

void setup() {

  ext_i2c = new DevI2C(D14, D15);
  
  ht_sensor = new HTS221Sensor(*ext_i2c);
  ht_sensor->init(NULL);

  lp_sensor= new LPS22HBSensor(*ext_i2c);
  lp_sensor->init(NULL);
  
  
}



static uint64_t send_interval_ms;
static uint64_t reset_interval_ms;
int step = 0;

void loop() {

  



  
  
    if((int)(SystemTickCounterRead() - send_interval_ms)>INTERVAL)
    {

      
      showSensors();
      if (r != 255 && step == 0)
      {
        r++;
      }
      else if (r == 255 && step == 0)
      {
        step = 1;
      }
      else if (g != 255 && step == 1)
      {
        g++;
      }
      else if (g == 255 && step == 1)
      {
        step = 2;
      }
      else if (b != 255 && step == 2)
      {
        b++;
      }
      else if (b == 255 && step == 2)
      {
        step = 3;
      }
      else if (b != 0 && step == 3)
      {
        b--;
      }
      else if (r == 255 && g == 255 && b == 0 && step == 3)
      {
        step = 4;
      }
      else if (r != 80 && b != 80 && step == 4)
      {
        r--;
        b--;
      }
      else if (r == 80 && b == 80 && step == 4)
      {
        step = 0;
        r = 0;
        g = 0;
        b = 0;
      }
      else
      {
        step = 0;
        r = 0;
        g = 0;
        b = 0;
      }

      send_interval_ms = SystemTickCounterRead();
      rgbLed.setColor(r, g, b);
    

    if((int)(SystemTickCounterRead() - reset_interval_ms)>INTERVAL){
      if(doReset){
         NVIC_SystemReset();
      }
      reset_interval_ms = SystemTickCounterRead();
    }
  }
}
