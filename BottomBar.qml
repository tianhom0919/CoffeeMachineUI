import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    Rectangle {
        id: rect1
        width: 640
        height: 5
        color: "gray"
        anchors { left: parent.left; bottom: parent.bottom }
        anchors.bottomMargin: -445
    }

    Rectangle {
        id: rect2
        width: 535
        height: 35
        color: "black"
        anchors { left: parent.left; bottom: parent.bottom }
        anchors.bottomMargin: -480
    }

    Rectangle {
        id: rect3
        width: 5
        height: 35
        color: "gray"
        anchors { left: rect2.right; bottom: parent.bottom }
        anchors.bottomMargin: -480
    }

    Rectangle {
        id: settingsBtn
        width: 100
        height: 35
        color: "black"
        anchors { left: rect3.right; bottom: parent.bottom }
        anchors.bottomMargin: -480

        Button {
            text: "Settings"
            anchors.centerIn: parent
        }
    }
}
