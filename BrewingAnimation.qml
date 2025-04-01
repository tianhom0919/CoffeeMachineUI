import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: brewingAnimation

    property string name
    property string image

    // Displays "coffee preparing text"
    Text {
        id: coffeeName
        text: "Your "+ name + " Is Being Prepared..."
        font.family: "Helvetica"
        font.pixelSize: parent.height /12
        anchors { top: parent.top; topMargin: 10; horizontalCenter: parent.horizontalCenter }
    }

    // Original image of coffee
    Image {
        id: coffeeImage
        width: parent.width / 2.5
        height: parent.height / 1.875
        fillMode: Image.PreserveAspectFit
        source: image
        anchors { centerIn: parent; verticalCenterOffset: -15 }
    }

    // Rectangle lain on top of the original image for fill animation
    Rectangle {
        id: fillRect
        x: 192
        width: coffeeImage.width
        height: coffeeImage.height
        color: "blue"
        anchors.fill: coffeeImage

        // Animation
        NumberAnimation on height {
            id: fillAnimation
            from: fillRect.height
            to: 0
            duration: 2000
            easing.type: Easing.InOutQuad
        }

        MouseArea {
            anchors.fill: parent
            onClicked: fillAnimation.start()
        }
    }


    // Return to home button, only allow clicks when the animation is done
    Rectangle {
        id: returnBtn
        width: parent.width / 2.15
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
            id: returnBtnText
            text: "Return to Home"
            font.family: "Helvetica"
            color: "black"
            font.pixelSize: parent.height / 2
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                scaleAnimReturn.start()
            }
        }
    }

    // Scale up and scale down animation sequence for return to home button
    SequentialAnimation {
        id: scaleAnimReturn
        PropertyAnimation { target: returnBtn; property: "scale"; to: 1.2; duration: 150; easing.type: Easing.OutQuad }
        PropertyAnimation { target: returnBtn; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.InQuad }

        ScriptAction {
            script: {
                stackview.pop(null)
            }
        }
    }

    // Fill animation for coffee
    SequentialAnimation {
        id: fillAnim
        PropertyAnimation { target: returnBtn; property: "scale"; to: 1.2; duration: 150; easing.type: Easing.OutQuad }
        PropertyAnimation { target: returnBtn; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.InQuad }

        ScriptAction {
            script: {
                stackview.pop(null)
            }
        }
    }

}
