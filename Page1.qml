import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: page1
    objectName: "page1"

    // Displays coffee name
    Text {
        id: coffeeName
        text: "Americano"
        font.family: "Helvetica"
        font.pixelSize: parent.height /12
        anchors { top: parent.top; topMargin: 10; horizontalCenter: parent.horizontalCenter }
    }

    // Displays the image of coffee
    Image {
        id: coffeeImage
        width: parent.width / 2.5 // Calculated based on an aspect ratio of 4:3, image heights are constant
        height: parent.height / 1.875
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/americano.png"
        anchors { centerIn: parent; verticalCenterOffset: -15 }
    }

    // Select button
    Rectangle {
        id: selectBtn
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

    // Left arrow key (removed as this is the first page)
    /*
    Image {
        id: leftArrowKey
        source: "qrc:/images/leftArrowKey.png"
        anchors { left: parent.left; verticalCenter: parent.verticalCenter; leftMargin: 25; verticalCenterOffset: -40 }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                playScaleAnimation(leftArrowKey)
            }
        }
    }
    */

    // Right arrow key
    Image {
        id: rightArrowKey
        source: "qrc:/images/rightArrowKey.png"
        width: parent.width / 12
        height: parent.height / 7.5
        fillMode: Image.PreserveAspectFit
        anchors { right: parent.right; verticalCenter: parent.verticalCenter; rightMargin: parent.height / 19.2; verticalCenterOffset: -parent.height / 12 }

        MouseArea {
            anchors.fill: parent
            onClicked: scaleAnimRight.start() // Go to Page 2
        }
    }

    // Scale up and scale down animation sequence for right arrow key
    SequentialAnimation {
        id: scaleAnimRight
        PropertyAnimation { target: rightArrowKey; property: "scale"; to: 1.2; duration: 150; easing.type: Easing.OutQuad }
        PropertyAnimation { target: rightArrowKey; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.InQuad }

        ScriptAction {
            script: {
                stackview.push("qrc:/Page2.qml")
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
                stackview.push({ item: Qt.resolvedUrl("qrc:/BrewSelection.qml"), properties: { name: "Americano", image: "qrc:/images/americano.png", coffeeStrength: 5, coffeeVolume: 100 } })
            }
        }
    }
}
