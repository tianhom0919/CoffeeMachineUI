import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: brewingAnimation
    objectName: "brewingAnimation"

    property string name
    property string image

    // Displays "coffee preparing text"
    Text {
        id: coffeeName
        text: "Your "+ name + " is being prepared..."
        font.family: "Helvetica"
        font.pixelSize: parent.height /12
        anchors { top: parent.top; topMargin: 10; horizontalCenter: parent.horizontalCenter }
    }

    // Rectangle container for image
    Rectangle {
        id: rect
        color: "transparent"
        width: parent.width / 2.5
        height: parent.height / 1.875
        anchors { centerIn: parent; verticalCenterOffset: -15 }

        // Original image of coffee
        Image {
            id: coffeeImage
            width: parent.width
            height: parent.height
            fillMode: Image.PreserveAspectFit
            source: image
            anchors.fill: parent
        }
    }

    // Rectangle laid on top of the original image for fill animation
    Rectangle {
        id: fillRect
        color: "#d3d3d3"
        width: parent.width / 2.5
        height: parent.height / 1.875
        anchors { top: rect.top; horizontalCenter: rect.horizontalCenter }

        // Fill animation
        SequentialAnimation {
            id: fillAnimation
            running: stackview.currentItem.objectName === "brewingAnimation" ? true : false
            PropertyAnimation { target: fillRect; property: "height"; from: rect.height; to: 0; duration: 5000; easing.type: Easing.InOutQuad }

            ScriptAction {
                script: {
                    coffeeName.text = "Your " + name + " is ready!";
                    cancelBtnText.text = "Return to Home";
                    cancelBtn.width = parent.width / 2.15;
                }
            }
        }
    }

    // Cancel brewing and return to brew selection
    Rectangle {
        id: cancelBtn
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
            id: cancelBtnText
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
        PropertyAnimation { target: cancelBtn; property: "scale"; to: 1.2; duration: 150; easing.type: Easing.OutQuad }
        PropertyAnimation { target: cancelBtn; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.InQuad }

        ScriptAction {
            script: fillRect.height === 0 ? stackview.pop(null) : stackview.pop()
        }
    }
}
