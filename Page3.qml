import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: page3

    // Displays coffee name
    Text {
        id: coffeeName
        text: "Espresso"
        font.family: "Helvetica"
        font.pixelSize: parent.height / 12
        anchors { top: parent.top; topMargin: 10; horizontalCenter: parent.horizontalCenter }
    }

    // Displays the image of coffee
    Image {
        id: coffeeImage
        width: parent.width / 3 // Calculated based on an aspect ratio of 4:3
        height: parent.height / 2.25
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/espresso.png"
        anchors { centerIn: parent; verticalCenterOffset: -15 }
    }

    // Select button
    Rectangle {
        id: selectBtn
        width: parent.width / 4.3
        height: parent.height / 10
        radius: 10
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#d3d3d3"}
            GradientStop { position: 0.5; color: "#ffffff"}
            GradientStop { position: 1.0; color: "#d3d3d3"}
        }
        border.color: "black"
        border.width: 2
        anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter; bottomMargin: 25 }

        Text {
            id: selectBtnText
            text: "Select"
            font.family: "Helvetica"
            color: "black"
            font.pixelSize: parent.height / 2
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                scaleAnimSelect.start()
            }
        }
    }

    // Left arrow key
    Image {
        id: leftArrowKey
        source: "qrc:/images/leftArrowKey.png"
        anchors { left: parent.left; verticalCenter: parent.verticalCenter; leftMargin: 25; verticalCenterOffset: -40 }

        MouseArea {
            anchors.fill: parent
            onClicked: scaleAnimLeft.start() // Back to Page 2
        }
    }

    // Right arrow key
    /*
    Image {
        id: rightArrowKey
        source: "qrc:/images/rightArrowKey.png"
        anchors { right: parent.right; verticalCenter: parent.verticalCenter; rightMargin: 25; verticalCenterOffset: -40 }

        MouseArea {
            anchors.fill: parent
            onClicked: scaleAnimRight.start() // Go to Page 3
        }
    }
    */

    // Scale up and scale down animation sequence for left arrow key
    SequentialAnimation {
        id: scaleAnimLeft
        PropertyAnimation { target: leftArrowKey; property: "scale"; to: 1.2; duration: 150; easing.type: Easing.OutQuad }
        PropertyAnimation { target: leftArrowKey; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.InQuad }

        ScriptAction {
            script: {
                stackview.pop()
            }
        }
    }

    // Scale up and scale down animation sequence for right arrow key
    SequentialAnimation {
        id: scaleAnimRight
        PropertyAnimation { target: rightArrowKey; property: "scale"; to: 1.2; duration: 150; easing.type: Easing.OutQuad }
        PropertyAnimation { target: rightArrowKey; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.InQuad }

        ScriptAction {
            script: {
                stackview.push("qrc:/Page3.qml")
            }
        }
    }

    // Scale up and scale down animation sequence for select button
    SequentialAnimation {
        id: scaleAnimSelect
        PropertyAnimation { target: selectBtn; property: "scale"; to: 1.2; duration: 150; easing.type: Easing.OutQuad }
        PropertyAnimation { target: selectBtn; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.InQuad }

        ScriptAction {
            script: {
                stackview.push({ item: Qt.resolvedUrl("qrc:/BrewSelection.qml"), properties: { name: "Espresso", image: "qrc:/images/espresso.png", coffeeStrength: 7, coffeeVolume: 50 } })
            }
        }
    }
}
