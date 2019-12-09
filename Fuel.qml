import QtQuick 2.0

Item {
    id: id_root

    property int value: 0

    Rectangle {
        id: id_fuel

        property int numberIndexs: 5

        anchors.centerIn: parent
        height: Math.min(id_root.width, id_root.height)
        width: height
        radius: width/2
        color: "black"
        border.color: "light green"
        border.width: id_fuel.height * 0.02

        Canvas {
            id:canvas
            anchors.fill: parent
            contextType: "2d"
            antialiasing: true

            onPaint: {
                var context = canvas.getContext('2d');

                context.strokeStyle = "red";
                context.lineWidth = id_fuel.height * 0.05;
                context.beginPath();
                context.arc(id_fuel.height / 2, id_fuel.height / 2, id_fuel.height / 2 - id_fuel.height * 0.07, Math.PI, Math.PI * 1.25, false);
                context.stroke();

                context.strokeStyle = "blue";
                context.lineWidth = id_fuel.height * 0.05;
                context.beginPath();
                context.arc(id_fuel.height / 2, id_fuel.height / 2, id_fuel.height / 2 - id_fuel.height * 0.07, Math.PI * 1.25, Math.PI * 2.0, false);
                context.stroke();
            }
        }

        Repeater {
            model: id_fuel.numberIndexs

            Item {
                height: id_fuel.height/2
                transformOrigin: Item.Bottom
                rotation: index * 45 + 270
                x: id_fuel.width/2

                Rectangle {
                    height: index % 2 == 0 ? id_fuel.height * 0.15 : id_fuel.height * 0.1
                    width: height / 2
                    color: index == 0 ? "red" : "light green"
                    antialiasing: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: id_fuel.height * 0.03
                }
            }
        }


        Text {
            anchors {
                top: parent.verticalCenter
                right: parent.right
                topMargin: id_fuel.height * 0.01
                rightMargin: id_fuel.height * 0.06
            }
            text: "HEDEF"
            font.bold: false
            color: "white"
            font.pixelSize: id_fuel.height * 0.1
            font.family: "Impact"
        }
        Text {
            anchors {
                top: parent.verticalCenter
                left: parent.left
                topMargin: id_fuel.height * 0.01
                leftMargin: id_fuel.height * 0.06
            }
            text: "0"
            color: "white"
            font.pixelSize: id_fuel.height * 0.1
            font.family: "Impact"
        }
    }


    Rectangle {
        id: id_center

        anchors.centerIn: parent
        height: id_fuel.height * 0.1
        width: height
        radius: width/2
        color: "light green"
    }

    FuelNeedle {
        id: id_fuelNeedle
        anchors {
            top: id_fuel.top
            bottom: id_fuel.bottom
            horizontalCenter: parent.horizontalCenter
        }
        value: id_root.value
        startAngle: 270
        angleLength: 45
    }

    Rectangle {
        id: id_fuelIcon1
        x: 287
        y: 276
        width: 146
        height: 98

        anchors {
            horizontalCenter: id_root.horizontalCenter
        }

        Text {
            id: element
            color: "#c6d2c6"
            text: qsTr("Katedilen \n Mesafe")
            anchors.rightMargin: -56
            anchors.bottomMargin: 215
            anchors.leftMargin: 56
            anchors.topMargin: -215
            anchors.fill: parent
            font.bold: true
            font.pixelSize: 9
        }
        color: "transparent"
        border.color: "light green"
        border.width: id_fuel.height * 0.01
    }

    Rectangle {
        id: id_fuelIcon3

        anchors {
            horizontalCenter: id_root.horizontalCenter
            top: id_fuelIcon2.bottom
            topMargin: id_fuel.height * 0.009
        }
        height: id_fuel.height * 0.02
        width: height * 5
        color: "light green"
        border.color: "light green"
        border.width: id_fuel.height * 0.01
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:11;anchors_height:74;anchors_width:80;anchors_x:-18.5;anchors_y:-20.5}
}
##^##*/
