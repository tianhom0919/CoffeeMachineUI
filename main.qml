import QtQuick 2.0
import QtQuick.Controls 1.4

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Coffee Machine")

    // Top background colour
    Rectangle {
        id: topRect
        anchors.top: parent.top
        height: 100
        width: parent.width
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#ffffff"}
            GradientStop { position: 1.0; color: "#d3d3d3"}
        }
    }

    // Bottom background color and mainview
    Rectangle {
        id: bottomRect
        anchors.top: topRect.bottom
        height: parent.height - 100
        width: parent.width
        color: "#d3d3d3"

        StackView {
            id: stackview
            anchors.fill: parent
            initialItem: HomePage {}
        }
    }

    // Settings and home icons
    Rectangle {
        id: topIcons
        width: parent.width
        height: 100
        anchors.fill: topRect
        color: "transparent"

        Image {
            id: homeIcon
            source: "qrc:/images/homeLogo.png"
            width: 50
            height: 50
            anchors { left: parent.left; top: parent.top ; leftMargin: 25; topMargin: 15 }
            opacity: stackview.depth === 1 ? 0.5 : 1.0

            MouseArea {
                anchors.fill: parent
                enabled: stackview.depth > 1
                onClicked: {
                    scaleAnimHome.start()
                }
            }
        }

        Image {
            id: settingsIcon
            source: "qrc:/images/settingsLogo.png"
            width: 50
            height: 50
            anchors { right: parent.right; top: parent.top; rightMargin: 25; topMargin: 15 }
            opacity: {
                if ( stackview.currentItem.objectName === "settingsPage" ) return 0.5
                else if ( stackview.currentItem.objectName === "brewingAnimation" ) return 0.5
                else return 1.0
            }

            MouseArea {
                anchors.fill: parent
                enabled: {
                    if ( stackview.currentItem.objectName === "settingsPage" ) return false
                    else if ( stackview.currentItem.objectName === "brewingAnimation" ) return false
                    else return true
                }
                onClicked: {
                    scaleAnimSettings.start()
                }
            }
        }
    }

    // Shows the time
    Item {
        id: tempTime
        width: 200
        height: 80
        anchors { top: parent.top; horizontalCenter: parent. horizontalCenter }

        Text {
            id: timeDisplay
            text: Qt.formatDateTime(new Date(), "hh:mm:ss AP")
            font.family: "Helvetica"
            font.pixelSize: 25
            font.letterSpacing: 2
            color: "black"
            anchors.centerIn: parent
        }

        // Display stackview depth for debugging
        // Text { text: stackview.currentItem.objectName }

        Rectangle {
            id: separator
            width: parent.width
            height : 5
            color: "black"
            anchors { top: parent.bottom }
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: timeDisplay.text = Qt.formatDateTime(new Date(), "hh:mm:ss AP")
        }
    }

    // Scale up and scale down animation sequence for home icon
    SequentialAnimation {
        id: scaleAnimHome
        PropertyAnimation { target: homeIcon; property: "scale"; to: 1.2; duration: 150; easing.type: Easing.OutQuad }
        PropertyAnimation { target: homeIcon; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.InQuad }

        ScriptAction {
            script: {
                stackview.pop(null)
            }
        }
    }

    // Scale up and scale down animation sequence for settings icon
    SequentialAnimation {
        id: scaleAnimSettings
        PropertyAnimation { target: settingsIcon; property: "scale"; to: 1.2; duration: 150; easing.type: Easing.OutQuad }
        PropertyAnimation { target: settingsIcon; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.InQuad }

        ScriptAction {
            script: {
                stackview.push("qrc:SettingsPage.qml")
            }
        }
    }

}
