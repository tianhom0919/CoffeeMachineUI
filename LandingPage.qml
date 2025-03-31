import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    width: 640
    height: 400

    Text {
        id: text1
        anchors.centerIn: parent
        text: "Welcome!"
        color: "white"
        font.pointSize: 50
    }

    Button {
        id: startBtn
        anchors{ top:text1.bottom; horizontalCenter: text1.horizontalCenter }
        anchors.topMargin: 10
        text: "Start Making Coffee"
        onClicked: stackview.push()
    }

}
