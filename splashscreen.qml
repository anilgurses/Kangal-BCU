import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 2.13
import Qt.labs.qmlmodels 1.0
import QtQuick.Shapes 1.11
import Qt.labs.location 1.0

Window{
    id: splash
    width: 480; height: 320
    flags: Qt.SplashScreen  | Qt.WindowFullscreen
    visible: true
    property int timeoutInterval: 2000
    signal timeout
    Loader{
        id: pageLoader
    }

    Timer {
        interval: timeoutInterval; running: true; repeat: false
        onTriggered: {
            splash.timeout()
            pageLoader.source = "main.qml"
            visible = false
        }
    }

    Rectangle {
        id: rectangle
        color: "#f5f5f5"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        Image {
            id: image1
            x: 265
            y: 167
            width: 215
            height: 153
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            fillMode: Image.PreserveAspectFit
            source: "images/background1.png"
        }

        Text {
            id: vers_id
            width: 83
            height: 37
            text: qsTr("V5.8")
            anchors.left: image.right
            anchors.leftMargin: 185
            anchors.top: soft_title.bottom
            anchors.topMargin: 1
            font.pixelSize: 19
        }

        Text {
            id: soft_title
            y: 155
            width: 238
            height: 30
            text: qsTr("KANGAL BCU")
            anchors.left: image.right
            anchors.leftMargin: -19
            font.bold: true
            font.family: "Times New Roman"
            font.pixelSize: 31
        }

        Image {
            id: image
            y: 129
            width: 177
            height: 140
            anchors.verticalCenterOffset: 10
            anchors.left: parent.left
            anchors.leftMargin: 17
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            source: "images/logo.png"
        }



    }


}

/*##^##
Designer {
    D{i:1;anchors_height:296;anchors_width:536;anchors_x:44;anchors_y:129}D{i:4;anchors_x:257}
D{i:5;anchors_x:0}D{i:3;anchors_x:396;anchors_y:216}
}
##^##*/
