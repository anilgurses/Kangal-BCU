import QtQuick 2.0

Item {
    id: id_root
    property int value: 0

    Rectangle {
        id: id_speed

        property int numberIndexs: 15
        property int startAngle: 234
        property int angleLength: 18
        property int maxSpeed: 280

        anchors.centerIn: parent
        height: Math.min(id_root.width, id_root.height)
        width: height
        radius: width/2
        color: "black"
        border.color: "light green"
        border.width: id_speed.height * 0.02

        Canvas {
            id:canvas
            anchors.fill: parent
            contextType: "2d"
            rotation: 145
            antialiasing: true

            onPaint: {
                var context = canvas.getContext('2d');
                context.strokeStyle = "blue";
                context.lineWidth = id_speed.height * 0.05 / 2;
                context.beginPath();
                context.arc(id_speed.height / 2, id_speed.height / 2, id_speed.height / 2 - id_speed.height * 0.05, 0, Math.PI * 1.1, false);
                context.stroke();

                context.strokeStyle = "red";
                context.lineWidth = id_speed.height * 0.05 / 2;
                context.beginPath();
                context.arc(id_speed.height / 2, id_speed.height / 2, id_speed.height / 2 - id_speed.height * 0.05, Math.PI * 1.1, Math.PI * 1.4, false);
                context.stroke();
            }
        }

        Repeater {
            model: id_speed.numberIndexs

            Item { 
                height: id_speed.height/2
                transformOrigin: Item.Bottom
                rotation: index * id_speed.angleLength + id_speed.startAngle
                x: id_speed.width/2

                Rectangle {
                    height: id_speed.height * 0.05
                    width: height / 2
                    color: "light green"
                    border.color: "#f4f6f4"
                    antialiasing: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: id_speed.height * 0.03
                }

                Text {
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                    }
                    x: 0
                    y: id_speed.height * 0.09
                    color: "light green"
                    rotation: 360 - (index * id_speed.angleLength + id_speed.startAngle)
                    text: index * (id_speed.maxSpeed / (id_speed.numberIndexs - 1))
                    font.pixelSize: id_speed.height * 0.05
                    font.family: "Comic Sans MS"
                }
            }
        }
    }

    Rectangle {
        id: id_center

        anchors.centerIn: parent
        height: id_speed.height*0.1
        width: height
        radius: width/2
        color: "#ffffff"
    }

    Text {
        width: 142
        height: 173
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: id_speed.verticalCenter
        }
        text: "HIZ\n km/h"
        anchors.horizontalCenterOffset: 29
        anchors.topMargin: 30
        color: "#e7eee7"
        font.pixelSize: id_speed.height * 0.1
        font.family: "Comic Sans MS"
    }

    SpeedNeedle {
        id: id_speedNeedle
        anchors {
            top: id_speed.top
            bottom: id_speed.bottom
            horizontalCenter: parent.horizontalCenter
        }
        value: id_root.value
        startAngle: id_speed.startAngle
        angleLength: id_speed.angleLength / (id_speed.maxSpeed / (id_speed.numberIndexs - 1))
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
