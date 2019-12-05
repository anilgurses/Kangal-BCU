import QtQuick 2.11
import QtQuick.Window 2.12
import QtQuick.Templates 2.13
import QtQuick.Controls 2.13
import kadran



Window {
    id:main
    width: 480; height: 320
    color: "#df93969b"
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowFullscreen
    visible: true

    Image {
        id: image
        x: 186
        width: 91
        height: 45
        anchors.top: parent.top
        anchors.topMargin: 0
        fillMode: Image.PreserveAspectFit
        source: "images/logo.png"
    }

    SwipeView {
        id: swipeView
        x: 140
        y: 79
        width: 200
        height: 200
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 46
        currentIndex: 1
        anchors.fill:parent

        Page {
            id: page1
            Rectangle {
                id: rectangle
                x: 75
                y: 31
                width: 127
                height: 59
                color: "#a0d05555"
                radius: 15

                ProgressBar {
                    id: progressBar
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 34
                    anchors.top: parent.top
                    anchors.topMargin: 8
                    value: 0.5
                }

                Text {
                    id: element
                    text: qsTr("Batarya Seviyesi")
                    anchors.right: parent.right
                    anchors.rightMargin: 21
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 14
                    anchors.left: parent.left
                    anchors.leftMargin: 21
                    anchors.top: parent.top
                    anchors.topMargin: 31
                    font.pixelSize: 12
                }
            }
        }

        Page {
            id: page2
            enabled: false
            hoverEnabled: false
            Rectangle {
                id: rectangle1
                x: 168
                y: 84
                width: 145
                height: 106
                color: "#a0d05555"
                radius: 53

                Text {
                    id: element1
                    text: qsTr("AnlıkHız")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.topMargin: 31
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    anchors.right: parent.right
                    font.pixelSize: 12
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 14
                }

                Text {
                    id: speed
                    x: 8
                    y: 29
                    width: 129
                    height: 19
                    text: qsTr("10 Km/S")
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 20
                }
            }

            Rectangle {
                id: rectangle3
                x: 319
                y: 21
                width: 127
                height: 71
                color: "#a0d05555"
                radius: 15
                Text {
                    id: element5
                    text: qsTr("KatedlienMesafe")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.rightMargin: 0
                    anchors.bottom: parent.bottom
                    font.pixelSize: 12
                    anchors.top: parent.top
                    anchors.topMargin: 37
                    anchors.leftMargin: 0
                    anchors.left: parent.left
                    anchors.bottomMargin: 8
                    anchors.right: parent.right
                }

                Text {
                    id: distance
                    x: 0
                    y: 11
                    width: 127
                    height: 19
                    text: qsTr("10 Km")
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 20
                }
            }

            Rectangle {
                id: rectangle4
                x: 37
                y: 21
                width: 127
                height: 71
                color: "#a0d05555"
                radius: 15
                Text {
                    id: element6
                    text: qsTr("ToplamKatedilenMesafe")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.rightMargin: 0
                    anchors.bottom: parent.bottom
                    font.pixelSize: 12
                    anchors.top: parent.top
                    anchors.topMargin: 37
                    anchors.leftMargin: 0
                    anchors.left: parent.left
                    anchors.bottomMargin: 8
                    anchors.right: parent.right
                }

                Text {
                    id: tdistance
                    x: 0
                    y: 11
                    width: 127
                    height: 19
                    text: qsTr("10 Km")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 20
                }
            }

            Rectangle {
                id: rectangle5
                x: 319
                y: 166
                width: 127
                height: 71
                color: "#a0d05555"
                radius: 15
                Text {
                    id: element7
                    text: qsTr("OrtHız")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.rightMargin: 0
                    anchors.bottom: parent.bottom
                    font.pixelSize: 12
                    anchors.top: parent.top
                    anchors.topMargin: 37
                    anchors.leftMargin: 0
                    anchors.left: parent.left
                    anchors.bottomMargin: 8
                    anchors.right: parent.right
                }

                Text {
                    id: averagespeed
                    x: 0
                    y: 11
                    width: 127
                    height: 19
                    text: qsTr("10 Km/S")
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 20
                }
            }

            Rectangle {
                id: rectangle6
                x: 37
                y: 166
                width: 127
                height: 73
                color: "#a0d05555"
                radius: 15
                Text {
                    id: element8
                    text: qsTr("calori")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.rightMargin: 0
                    anchors.bottom: parent.bottom
                    font.pixelSize: 12
                    anchors.top: parent.top
                    anchors.topMargin: 37
                    anchors.leftMargin: 0
                    anchors.left: parent.left
                    anchors.bottomMargin: 8
                    anchors.right: parent.right
                }

                Text {
                    id: calori
                    x: 0
                    y: 11
                    width: 127
                    height: 19
                    text: qsTr("1000 calori")
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 20
                }
            }
        }

        Page {
            id: page3

        }

        Page {
            id: page4

            Text {
                id: element2
                x: 205
                y: 12
                width: 46
                height: 18
                text: qsTr("Ayarlar")
                font.pixelSize: 12
            }

        }


    }


    Rectangle {
        id: rectangle2
        x: 0
        y: 46
        width: 480
        height: 274
        color: "#4f904444"
    }


    Button {
        id: button
        x: 446
        y: 146
        width: 34
        height: 53
        text: qsTr(">")
        onClicked:{

            if(swipeView.currentIndex==2)
               swipeView.currentIndex=0
            else if(swipeView.currentIndex==3)
                swipeView.currentIndex=3

            else swipeView.currentIndex++;

        }

    }


    Button {
        id: button2
        x: 0
        y: 146
        width: 34
        height: 53
        text: qsTr("<")
        onClicked:{

            if(swipeView.currentIndex==0)
               swipeView.currentIndex=2
            else if(swipeView.currentIndex==3)
                swipeView.currentIndex=3
            else swipeView.currentIndex--;
        }
    }


    Button {
        id: button1
        x: 373
        y: 5
        text: qsTr("        Ayarlar")
        padding: 6

        onClicked:{
            if(swipeView.currentIndex==3)
               swipeView.currentIndex=0
            else  swipeView.currentIndex=3;
        }

        Image {
            id: image1
            width: 42
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.top: parent.top
            visible: true
            clip: true
            source: "images/settings icon.png"
            fillMode: Image.PreserveAspectFit
        }
    }


    PageIndicator {
        count: 3
        currentIndex: swipeView.currentIndex
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: element3
        x: 263
        y: 5
        width: 68
        height: 19
        text: qsTr("Kangal")
        font.pixelSize: 16
        font.underline: false
        font.italic: false
        font.bold: true
        font.family: "Verdana"
        horizontalAlignment: Text.AlignHCenter
        fontSizeMode: Text.FixedSize
        renderType: Text.QtRendering
        textFormat: Text.AutoText

        Text {
            id: element4
            x: 4
            y: 17
            width: 60
            height: 19
            text: qsTr("BCU  V5.8 ")
            font.pixelSize: 14
        }
    }





}



/*##^##
Designer {
    D{i:30;anchors_height:37;anchors_width:52;anchors_x:365;anchors_y:8}
}
##^##*/
