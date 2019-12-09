import QtQuick 2.0

Item {
    id: id_root
    property int value: 0
    property int startAngle : 0
    property double angleLength: 0
    property int maxSpeed: 0

    Rectangle {
        width: id_root.height * 0.02
        height: id_root.height * 0.45
        color: "#df380a"
        anchors {
            horizontalCenter: id_root.horizontalCenter
        }
        antialiasing: true
        y: id_root.height * 0.05
    }

    rotation: value * angleLength + startAngle

    antialiasing: true

    Behavior on rotation {
        SmoothedAnimation { velocity: 50 }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
