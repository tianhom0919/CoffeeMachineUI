import QtQuick 2.0

Item {
    property string name
    property string image
    property int coffeeStrength
    property int coffeeVolume

    // Displays coffee name
    Text {
        id: coffeeName
        text: name
        font.family: "Helvetica"
        font.pixelSize: parent.height /12
        anchors { top: parent.top; topMargin: 10; horizontalCenter: parent.horizontalCenter }
    }

    Image {
        id: coffeeImage
        width: parent.width / 2.5 // Calculated based on an aspect ratio of 4:3, images widths are set to 470px
        height: parent.height / 1.875
        fillMode: Image.PreserveAspectFit // Preserve the aspect ratio when resizing
        source: "qrc:/images/americano.png"
        anchors { centerIn: parent; horizontalCenterOffset: -200 }
    }

}
