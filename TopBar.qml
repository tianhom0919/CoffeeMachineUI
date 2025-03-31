import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: topBar
    width: 640
    height: 40
    anchors { top: parent.top; left: parent.left; right: parent.right }

    Rectangle {
        id: homeBtn
        width: 100
        height: 35
        color: "black"
        anchors { left: parent.left; top: parent.top }

        Button{
            text: "Home"
            anchors.centerIn: parent
            onClicked: stackview.pop(null)
        }
    }

    Rectangle {
        id: rect2
        width: 5
        height: 35
        color: "gray"
        anchors { left: homeBtn.right; top: parent.top }
    }

    Rectangle {
        id: settingsBtn
        width: 100
        height: 35
        color: "black"
        anchors { left: rect2.right; top: parent.top }

        Button{
            text: "Settings"
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: rect3
        width: 5
        height: 35
        color: "gray"
        anchors { left: settingsBtn.right; top: parent.top }
    }

    Rectangle {
        height: 35
        color: "black"
        anchors { left: rect3.right; right: rect5.left }
    }


    Rectangle {
        id: rect5
        width: 5
        height: 35
        color: "gray"
        anchors.right: tempTime.left
    }

    Rectangle {
        id: tempTime
        width: 200
        height: 35
        color: "black"
        anchors { right: parent.right; top: parent.top }
        Text {
                id: timeDisplay
                text: Qt.formatDateTime(new Date(), "hh:mm:ss AP - yyyy/MM/dd")
                color: "white"
                anchors.centerIn: parent
            }

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: timeDisplay.text = Qt.formatDateTime(new Date(), "hh:mm:ss AP - yyyy/MM/dd")
            }
    }

    Rectangle {
        height: 5
        color: "gray"
        anchors { left: parent.left; right: parent.right; top: homeBtn.bottom }
    }
}
