import QtQuick 2.0

Item {
    id: rinsingAnimation
    objectName: "rinsingAnimation"

    // Displays "Rinsing.." text
    Text {
        id: rinsingText
        text: "Rinsing..."
        font.family: "Helvetica"
        font.pixelSize: parent.height /12
        anchors { top: parent.top; topMargin: 10; horizontalCenter: parent.horizontalCenter }
    }

    // Display rinse icon
    Image {
        id: rinseIcon
        width: parent.height / 3.84
        height: parent.height / 3.84
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/rinse.png"
        anchors { centerIn: parent; verticalCenterOffset: -parent.height / 9 }
    }

    // Rectangle bar for loading animation
    Rectangle {
        id: rect
        color: "#f1f1f1"
        width: parent.width / 1.5
        height: parent.height / 16
        radius: parent.height / 48
        anchors { centerIn: parent; verticalCenterOffset: parent.height / 8 }
    }

    // Rectangle laid on top of the original image for fill animation
    Rectangle {
        id: fillRect
        color: "#a7a7a7"
        width: parent.width / 1.5
        height: parent.height / 16
        radius: parent.height / 48
        anchors { left: rect.left; verticalCenter: parent.verticalCenter; verticalCenterOffset: parent.height / 8 }

        // Fill animation
        SequentialAnimation {
            id: fillAnimation
            running: stackview.currentItem.objectName === "rinsingAnimation" ? true : false
            PropertyAnimation { target: fillRect; property: "width"; from: 0; to: rect.width; duration: 5000; easing.type: Easing.InOutQuad }

            ScriptAction {
                script: {
                    rinsingText.text = "Rinse Complete!";
                    cancelRinseBtnText.text = "Return to Settings";
                    cancelRinseBtn.width = parent.width / 2.15;
                }
            }
        }
    }

    // Cancel rinsing and return to settings
    Rectangle {
        id: cancelRinseBtn
        width: parent.width / 4.3
        height: parent.height / 10
        radius: parent.height / 48
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#ffffff"}
            GradientStop { position: 0.5; color: "#ffffff"}
            GradientStop { position: 1.0; color: "#d3d3d3"}
        }
        border.color: "black"
        border.width: parent.height / 240
        anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter; bottomMargin: parent.height / 20 }

        Text {
            id: cancelRinseBtnText
            text: "Cancel"
            font.family: "Helvetica"
            color: "black"
            font.pixelSize: parent.height / 2
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                scaleAnimCancel.start()
            }
        }
    }

    // Scale up and scale down animation sequence for cancel button
    SequentialAnimation {
        id: scaleAnimCancel
        PropertyAnimation { target: cancelRinseBtn; property: "scale"; to: 1.2; duration: 150; easing.type: Easing.OutQuad }
        PropertyAnimation { target: cancelRinseBtn; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.InQuad }

        ScriptAction {
            script: {
                stackview.pop()
            }
        }
    }
}
