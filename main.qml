import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

Window {
    id: root
    width: 320
    height: _defaultHeight
    minimumHeight: 100
    minimumWidth: 200
    visible: true
    Material.theme: Material.Dark
    Material.accent: Material.Brown
    color: "black"
    title: qsTr("Grootcam control 2")

    property int _defaultHeight: statusCheckButton.height + slider.height + credentialButton.height
    property int _buttonHeight: 40
    property int _roundedSetpoint: Math.round(slider.value)

    Row {
        id: onlinePanel
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.topMargin: 5
        height: onlineLabel.height
        spacing: 5

        Rectangle {
            height: parent.height
            width: parent.height
            radius: width / 2
            color: viewcontroller.online === 1 ? "green" : viewcontroller.online === 0 ? "red" : "grey"
        }

        Label {
            id: onlineLabel
            text: viewcontroller.online === 1 ? "Turret ON" : viewcontroller.online === 0 ? "Turret OFF" : "Network error"

        }
    }

    Button {
        id: statusCheckButton
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 10
        height: _buttonHeight
        text: "Check status"
        onClicked: viewcontroller.requestAngle()
    }

    Label {
        id: leftLabel
        anchors.verticalCenter: slider.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.rightMargin: 5
        width: 20
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        font.pixelSize: 16
        text: _roundedSetpoint < 0 ? -_roundedSetpoint : ""
    }

    Label {
        id: rightLabel
        anchors.right: parent.right
        anchors.verticalCenter: slider.verticalCenter
        anchors.rightMargin: 10
        anchors.leftMargin: 5
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        width: 20
        font.pixelSize: 16
        text: _roundedSetpoint > 0 ? _roundedSetpoint : ""
    }

    Rectangle {
        color: "grey"
        anchors.top: slider.top
        anchors.horizontalCenter: slider.horizontalCenter
        anchors.bottom: slider.bottom
        width: 2
    }

    Slider {
        id: slider

        property int _pressedValue: 0

        anchors.top: statusCheckButton.bottom
        anchors.left: leftLabel.right
        anchors.right: rightLabel.left
        height: 40

        from: -90.0
        to: 90.0

        Component.onCompleted: viewcontroller.requestAngle()

        onPressedChanged: if (!pressed) viewcontroller.postAngle(_roundedSetpoint)

        Connections {
            target: viewcontroller
            function onAngleInit(angle) {
                slider.value = angle
            }
        }

    }

    Item {
        id: credentialPanel
        visible: false
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: credentialButton.bottom
        height: childrenRect.height + 10

        Label {
            id: userLabel
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 10
            text: "User"
        }

        Label {
            id: passwdLabel
            anchors.top: userLabel.bottom
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 10
            text: "Password"
        }

        Rectangle {
            id: passwdRectangleEdit
            anchors.top: passwdLabel.top
            anchors.left: passwdLabel.right
            anchors.right: parent.right
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            height: passwdEdit.height
            color: Material.backgroundDimColor

            TextEdit {
                id: passwdEdit
                anchors.fill: parent
                anchors.leftMargin: 5
                text: viewcontroller.passwd
            }
        }

        Rectangle {
            anchors.top: userLabel.top
            anchors.left: passwdRectangleEdit.left
            anchors.right: passwdRectangleEdit.right
            height: userEdit.height
            color: Material.backgroundDimColor

            TextEdit {
                id: userEdit
                anchors.fill: parent
                anchors.leftMargin: 5
                text: viewcontroller.user
            }
        }

        Button {
            anchors.top: passwdRectangleEdit.bottom
            anchors.right: parent.right
            anchors.rightMargin: 10
            height: _buttonHeight
            text: "Apply"

            onClicked: {
                viewcontroller.setCredentials(userEdit.text, passwdEdit.text)
                toggleCredentialPanel()
            }
        }
    }

    Rectangle {
        id: logPanel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: logButton.bottom
        anchors.bottom: parent.bottom

        visible: false
        color: "black"

        ScrollView {
            anchors.fill: parent

            ScrollBar.vertical : ScrollBar {
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                contentItem: Rectangle {
                            color: Material.accent
                        }
                policy: ScrollBar.AlwaysOn
            }

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

            TextArea {
                id: logArea
                readOnly: true
                selectByMouse: true
                selectByKeyboard: true
                color: "white"

                Connections {
                    target: viewcontroller
                    function onLog(logString) {
                        logArea.append(Qt.formatDateTime(new Date(),"hh:mm:ss")+": "+logString)
                    }
                }
            }
        }
    }

    Button {
        id: credentialButton
        anchors.top: slider.bottom
        anchors.left: parent.left
        anchors.leftMargin: 10
        visible: !logPanel.visible
        text: credentialPanel.visible ? "Hide credentials" : "Show credentials"
        height: _buttonHeight

        onClicked: toggleCredentialPanel()

    }

    Button {
        id: logButton
        anchors.top: slider.bottom
        anchors.left: credentialButton.visible ? credentialButton.right : parent.left
        anchors.leftMargin: 10
        visible: !credentialPanel.visible
        text: logPanel.visible ? "Hide logs" : "Show logs"
        height: _buttonHeight

        onClicked: {
            logPanel.visible = !logPanel.visible
            if (logPanel.visible) root.height = _defaultHeight + credentialPanel.height
            else root.height = _defaultHeight
        }
    }

    function toggleCredentialPanel() {
        credentialPanel.visible = !credentialPanel.visible
        if (credentialPanel.visible) root.height = _defaultHeight + credentialPanel.height
        else root.height = _defaultHeight
    }
}
