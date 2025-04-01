import QtQuick 2.0

Item {
    id: settingsPage
    objectName: "settingsPage"

    // Power off button
    Rectangle {
        id: powerBtn
        width: parent.height / 3
        height: parent.height / 3
        radius: parent.height / 48
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#d3d3d3"}
            GradientStop { position: 0.5; color: "#ffffff"}
            GradientStop { position: 1.0; color: "#d3d3d3"}
        }
        border.color: "black"
        border.width: parent.height / 240
        anchors { centerIn: parent; verticalCenterOffset: -parent.height / 30; horizontalCenterOffset: parent.height / 3 }

        Text {
            id: powerBtnText
            text: "Power Off"
            font.family: "Helvetica"
            color: "black"
            font.pixelSize: parent.height / 10
            anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter; bottomMargin: 10 }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                scaleAnimPowerBtn.start()
            }
        }
    }

    // Rinse button
    Rectangle {
        id: rinseBtn
        width: parent.height / 3
        height: parent.height / 3
        radius: parent.height / 48
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#d3d3d3"}
            GradientStop { position: 0.5; color: "#ffffff"}
            GradientStop { position: 1.0; color: "#d3d3d3"}
        }
        border.color: "black"
        border.width: parent.height / 240
        anchors { centerIn: parent; verticalCenterOffset: -parent.height / 30; horizontalCenterOffset: -parent.height / 3 }

        Text {
            id: rinseBtnText
            text: "Rinse"
            font.family: "Helvetica"
            color: "black"
            font.pixelSize: parent.height / 10
            anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter; bottomMargin: 10 }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                scaleAnimRinseBtn.start()
            }
        }
    }

    // Scale up and scale down animation sequence for power button
    SequentialAnimation {
        id: scaleAnimPowerBtn
        PropertyAnimation { target: powerBtn; property: "scale"; to: 1.2; duration: 150; easing.type: Easing.OutQuad }
        PropertyAnimation { target: powerBtn; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.InQuad }

        ScriptAction {
            script: {
            }
        }
    }

    // Scale up and scale down animation sequence for rinse button
    SequentialAnimation {
        id: scaleAnimRinseBtn
        PropertyAnimation { target: rinseBtn; property: "scale"; to: 1.2; duration: 150; easing.type: Easing.OutQuad }
        PropertyAnimation { target: rinseBtn; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.InQuad }

        ScriptAction {
            script: {
            }
        }
    }
}
