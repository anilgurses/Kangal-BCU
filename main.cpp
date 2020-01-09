#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtDebug>
#include <QSerialPort>
#include <QQmlContext>



int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/splashscreen.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);



    engine.load(url);


    QSerialPort serial;

    serial.setPortName("tty.usbmodem14303");
    if(!serial.setBaudRate(QSerialPort::Baud115200))
        qDebug() << serial.errorString();
    if(!serial.setDataBits(QSerialPort::Data7))
        qDebug() << serial.errorString();
    if(!serial.setParity(QSerialPort::OddParity))
        qDebug() << serial.errorString();
    if(!serial.setFlowControl(QSerialPort::HardwareControl))
        qDebug() << serial.errorString();
    if(!serial.setStopBits(QSerialPort::OneStop))
        qDebug() << serial.errorString();
    if(!serial.open(QIODevice::ReadOnly))
        qDebug() << serial.errorString();



    QObject::connect(&serial, &QSerialPort::readyRead, [&]
        {
            //this is called when readyRead() is emitted
            qDebug() << "New data available: " << serial.bytesAvailable();
            QByteArray datas = serial.readLine();

            QString Value = QString::fromStdString(datas.toStdString());
            QStringList pieces = Value.split( "\r" );
            QString neededWord = pieces.value(0);
            if (neededWord.toInt())
                qDebug() << "Error on Converting Int";

            float measure = neededWord.toFloat();

            if(measure < 30){
                engine.rootContext()->setContextProperty("temperature",QVariant(QString::number(measure)));
                qDebug() << "Arrived here";
            }else if(measure < 1000){
                engine.rootContext()->setContextProperty("speed",QVariant(QString::number(measure/1000)));
            }else{

            }

            qDebug() << neededWord;
        });

    QObject::connect(&serial,
                         static_cast<void(QSerialPort::*)(QSerialPort::SerialPortError)>
                         (&QSerialPort::error),
                         [&](QSerialPort::SerialPortError error)
        {
            //this is called when a serial communication error occurs
            qDebug() << "An error occured: " << error;
            app.quit();
        });

    return app.exec();
}
