import QtQuick 2.0

Item {
    id: brewSelectionPage
    objectName: "brewSelectionPage"
    // Set properties to receive passed values
    property string name
    property string image
    property int coffeeStrength
    property int coffeeVolume
    property int milkVolume: 0

    // Displays coffee name
    Text {
        id: coffeeName
        text: name
        font.family: "Helvetica"
        font.pixelSize: parent.height /12
        anchors { top: parent.top; topMargin: 10; horizontalCenter: parent.horizontalCenter }
    }

    // Displays the image of coffee
    Image {
        id: coffeeImage
        width: parent.width / 2.5 // Calculated based on an aspect ratio of 4:3, images widths are set to 470px
        height: parent.height / 1.875
        fillMode: Image.PreserveAspectFit // Preserve the aspect ratio when resizing
        source: image
        anchors { left: parent.left; verticalCenter: parent.verticalCenter; verticalCenterOffset: -parent.height / 32 }
    }

    // Back button
    Rectangle {
        id: backBtn
        width: parent.width / 4.3
        height: parent.height / 10
        radius: parent.height / 48
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#d3d3d3"}
            GradientStop { position: 0.5; color: "#ffffff"}
            GradientStop { position: 1.0; color: "#d3d3d3"}
        }
        border.color: "black"
        border.width: parent.height / 240
        anchors { left: parent.left; bottom: parent.bottom; leftMargin: parent.height / 20; bottomMargin: parent.height / 20 }

        Text {
            id: backBtnText
            text: "Back"
            font.family: "Helvetica"
            color: "black"
            font.pixelSize: parent.height / 2
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                scaleAnimBack.start()
            }
        }
    }

    // Brew button
    Rectangle {
        id: brewBtn
        width: parent.width / 4.3
        height: parent.height / 10
        radius: parent.height / 48
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#d3d3d3"}
            GradientStop { position: 0.5; color: "#ffffff"}
            GradientStop { position: 1.0; color: "#d3d3d3"}
        }
        border.color: "black"
        border.width: parent.height / 240
        anchors { right: parent.right; bottom: parent.bottom; rightMargin: parent.height / 20; bottomMargin: parent.height / 20 }

        Text {
            id: brewBtnText
            text: "Brew"
            font.family: "Helvetica"
            color: "black"
            font.pixelSize: parent.height / 2
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                scaleAnimBrew.start()
            }
        }
    }

    // Coffee parameters selection
    Column {
        id: paramSelection
        width: parent.width / 2
        height: parent.height / 2
        anchors { verticalCenter: parent.verticalCenter; right: parent.right; verticalCenterOffset:  -parent.width / 32; rightMargin: parent.width / 8 }

        // Select coffee strength
        Item{
            width: parent.width
            height: (parent.height - 10)/3

            Row {
                anchors.centerIn: parent
                spacing: 5

                Repeater {
                    model: 9  // Bean Count

                    Image {
                        width: brewSelectionPage.width / 20
                        height: brewSelectionPage.width / 20
                        id: coffeeBean
                        source: index < coffeeStrength ? "qrc:/images/CoffeeBean.png" : "qrc:/images/NoCoffeeBean.png"

                        MouseArea {
                            anchors.fill: parent
                            onClicked: { coffeeStrength = index + 1; anim.restart() }
                        }

                        SequentialAnimation {
                            id: anim
                            running: false
                            PropertyAnimation { target: coffeeBean; property: "scale"; to: 1.2; duration: 150; easing.type: Easing.OutQuad }
                            PropertyAnimation { target: coffeeBean; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.InQuad }
                        }
                    }
                }
            }
        }

        // Separator
        Rectangle {
            width: parent.width
            height: 2
            color: "black"
        }

        // Select coffee volume
        Item{
            width: parent.width
            height: (parent.height - 10)/ 3
            anchors.horizontalCenterOffset: parent.width / 16

            Rectangle {
                width: parent.width
                height: parent.height
                anchors.centerIn: parent
                color: "transparent"

                // Label
                Text {
                    text: "Vol."
                    font.family: "Helvetica"
                    color: "black"
                    font.pixelSize: parent.width / 16
                    anchors { left: parent.left; verticalCenter: parent.verticalCenter; leftMargin: parent.width / 16 }
                }

                // Left arrow for coffee volume
                Image {
                    id: volLeft
                    width: parent.width / 8
                    height: parent.height / 2
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:/images/leftArrowKey.png"
                    anchors { left: parent.left; verticalCenter: parent.verticalCenter; leftMargin: parent.width / 5 }
                    opacity: coffeeVolume > 50 ? 1.0 : 0.5

                    MouseArea {
                        anchors.fill: parent
                        enabled: coffeeVolume > 50
                        onClicked: scaleAnimVolL.start()
                    }
                }

                // Right arrow for coffee volume
                Image {
                    id: volRight
                    width: parent.width / 8
                    height: parent.height / 2
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:/images/rightArrowKey.png"
                    anchors { right: parent.right; verticalCenter: parent.verticalCenter; rightMargin: parent.width / 10 }
                    opacity: coffeeVolume < 150 ? 1.0 : 0.5

                    MouseArea {
                        anchors.fill: parent
                        enabled: coffeeVolume < 150
                        onClicked: scaleAnimVolR.start()
                    }
                }

                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "transparent"
                    anchors { left: volLeft.right; right: volRight.left }

                    Text {
                        text: coffeeVolume + "ml"
                        font.family: "Helvetica"
                        color: "black"
                        font.pixelSize: volLeft.width / 2
                        anchors.centerIn: parent
                    }
                }


            }
        }

        // Separator
        Rectangle {
            width: parent.width
            height: 2
            color: "black"
        }

        // Select milk volume
        Item{
            width: parent.width
            height: (parent.height - 10)/ 3
            anchors.horizontalCenterOffset: parent.width / 16

            Rectangle {
                width: parent.width
                height: parent.height
                anchors.centerIn: parent
                color: "transparent"

                // Label
                Text {
                    text: "Milk"
                    font.family: "Helvetica"
                    color: "black"
                    font.pixelSize: parent.width / 16
                    anchors { left: parent.left; verticalCenter: parent.verticalCenter; leftMargin: parent.width / 16 }
                }

                // Left arrow for milk volume
                Image {
                    id: milkLeft
                    width: parent.width / 8
                    height: parent.height / 2
                    fillMode: Image.PreserveAspectFit
                    source: milkVolume === 0 ? "" : "qrc:/images/leftArrowKey.png"
                    anchors { left: parent.left; verticalCenter: parent.verticalCenter; leftMargin: parent.width / 5 }
                    opacity: milkVolume > 50 ? 1.0 : 0.5

                    MouseArea {
                        anchors.fill: parent
                        enabled: milkVolume > 50
                        onClicked: scaleAnimMilkL.start()
                    }
                }

                // Right arrow for milk volume
                Image {
                    id: milkRight
                    width: parent.width / 8
                    height: parent.height / 2
                    fillMode: Image.PreserveAspectFit
                    source: milkVolume === 0 ? "" : "qrc:/images/rightArrowKey.png"
                    anchors { right: parent.right; verticalCenter: parent.verticalCenter; rightMargin: parent.width / 10 }
                    opacity: milkVolume < 150 ? 1.0 : 0.5

                    MouseArea {
                        anchors.fill: parent
                        enabled: milkVolume > 0 && milkVolume < 150
                        onClicked: scaleAnimMilkR.start()
                    }
                }

                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "transparent"
                    anchors { left: milkLeft.right; right: milkRight.left }

                    Text {
                        text: milkVolume + "ml"
                        font.family: "Helvetica"
                        color: "black"
                        font.pixelSize: milkLeft.width / 2
                        anchors.centerIn: parent
                    }
                }


            }
        }
    }

    // Scale up and scale down animation sequence for back button
    SequentialAnimation {
        id: scaleAnimBack
        PropertyAnimation { target: backBtn; property: "scale"; to: 1.2; duration: 150; easing.type: Easing.OutQuad }
        PropertyAnimation { target: backBtn; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.InQuad }

        ScriptAction {
            script: {
                stackview.pop()
            }
        }
    }

    // Scale up and scale down animation sequence for brew button
    SequentialAnimation {
        id: scaleAnimBrew
        PropertyAnimation { target: brewBtn; property: "scale"; to: 1.2; duration: 150; easing.type: Easing.OutQuad }
        PropertyAnimation { target: brewBtn; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.InQuad }

        ScriptAction {
            script: {
                stackview.push({ item: Qt.resolvedUrl("qrc:/BrewingAnimation.qml"), properties: { name: name, image: image } })
            }
        }
    }

    // Scale up and scale down animation sequence for left coffee volume button
    SequentialAnimation {
        id: scaleAnimVolL
        PropertyAnimation { target: volLeft; property: "scale"; to: 1.2; duration: 150; easing.type: Easing.OutQuad }
        PropertyAnimation { target: volLeft; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.InQuad }

        ScriptAction {
            script: {
                coffeeVolume = coffeeVolume - 10
            }
        }
    }

    // Scale up and scale down animation sequence for right coffee volume button
    SequentialAnimation {
        id: scaleAnimVolR
        PropertyAnimation { target: volRight; property: "scale"; to: 1.2; duration: 150; easing.type: Easing.OutQuad }
        PropertyAnimation { target: volRight; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.InQuad }

        ScriptAction {
            script: {
                coffeeVolume = coffeeVolume + 10
            }
        }
    }

    // Scale up and scale down animation sequence for left milk volume button
    SequentialAnimation {
        id: scaleAnimMilkL
        PropertyAnimation { target: milkLeft; property: "scale"; to: 1.2; duration: 150; easing.type: Easing.OutQuad }
        PropertyAnimation { target: milkLeft; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.InQuad }

        ScriptAction {
            script: {
                milkVolume = milkVolume - 10
            }
        }
    }

    // Scale up and scale down animation sequence for right milk volume button
    SequentialAnimation {
        id: scaleAnimMilkR
        PropertyAnimation { target: milkRight; property: "scale"; to: 1.2; duration: 150; easing.type: Easing.OutQuad }
        PropertyAnimation { target: milkRight; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.InQuad }

        ScriptAction {
            script: {
                milkVolume = milkVolume + 10
            }
        }
    }

}
