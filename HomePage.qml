import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: homePage
    objectName: "homePage"

    // Replace with logo image after
    Text {
        id: logo
        text: "[Insert Logo Here]"
        font.pixelSize: parent.height / 12
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -parent.height / 6
    }

    Rectangle {
        id: startBtn
        width: parent.width / 2.3
        height: parent.height / 10
        radius: parent.height / 48
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#d3d3d3"}
            GradientStop { position: 0.5; color: "#ffffff"}
            GradientStop { position: 1.0; color: "#d3d3d3"}
        }
        border.color: "black"
        border.width: parent.height / 240
        anchors { centerIn: parent; verticalCenterOffset: 30 }

        Text {
            id: startBtnText
            text: "Start Making Coffee"
            font.family: "Helvetica"
            color: "black"
            font.pixelSize: parent.height / 2
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                fadeOutAnim.start()
            }
        }
    }

    // Animation for start button
    SequentialAnimation {
        id: fadeOutAnim
        ParallelAnimation {
            NumberAnimation { target: logo; property: "opacity"; to: 0; duration: 800 }
            NumberAnimation { target: startBtn; property: "opacity"; to: 0; duration: 800 }
            NumberAnimation { target: startBtn; property: "scale"; to: 1.5; duration: 800 }
        }

        ScriptAction {
            script: {
                logo.visible = false
                startBtn.visible = false
                stackview.push("qrc:/Page1.qml")
            }
        }
    }


    Connections {
        target: stackview
        onDepthChanged: {
            if (stackview.depth === 1) {
                logo.opacity = 1;
                logo.visible = true;
                startBtn.opacity = 1;
                startBtn.visible = true;
                startBtn.scale = 1;
            }
        }
    }
}
