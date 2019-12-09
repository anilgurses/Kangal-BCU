import QtQuick 2.0

Item {
    id: id_dashboard

    //to creating data for demonstration purpose
    property int count: 0
    property int randNum: 0
    Timer {
        id: id_timer
        repeat: true
        interval: 1000
        running: true

        onTriggered: {
            if(id_gear.value == 6) id_gear.value = 0;
            else id_gear.value++;

            if(count % 5 == 0){
                if(id_speed.value == 0) id_speed.value = 140
                else id_speed.value = 0

                if(id_info.fuelValue == 0) id_info.fuelValue = 4
                else id_info.fuelValue = 0
            }
            count++;
        }
    }

    Rectangle {
        id: id_speedArea

        anchors {
            horizontalCenter: parent.horizontalCenter
        }
        width: parent.width * 0.4
        height: width
        color: "#020202"
        radius: width/2
        z: 1

        Speed {
            id: id_speed
            anchors.fill: id_speedArea
            anchors.margins: id_speedArea.width * 0.025
        }
    }

    Rectangle {
        id: id_gearArea

        anchors {
            bottom: id_speedArea.bottom
        }
        x: parent.width / 20
        width: parent.width * 0.35
        height: width
        color: "black"
        radius: width/2

        Gear {
            id: id_gear
            anchors.fill: id_gearArea
            anchors.margins: id_gearArea.width * 0.025
        }
    }

    Rectangle {
        id: id_infoArea

        anchors {
            bottom: id_speedArea.bottom
        }
        x: parent.width - parent.width / 2.5
        width: parent.width * 0.35
        height: width
        color: "black"
        radius: width/2

        Info {
            id: id_info
            anchors.fill: id_infoArea
            anchors.margins: id_infoArea.width * 0.025
        }
    }

    Rectangle {
        anchors {
            bottom: id_speedArea.bottom
            left: id_gearArea.horizontalCenter
            right: id_infoArea.horizontalCenter
        }
        height: id_gearArea.width / 2
        color: "black"
        z: -1
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
