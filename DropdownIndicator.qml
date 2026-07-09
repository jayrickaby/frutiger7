import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import "."

T.Button {
    id: control

    readonly property url imgButton: Theme.dirItemAssets + "combobox/dropdownbutton.ico"
    readonly property url imgButtonLeft: Theme.dirItemAssets + "combobox/dropdownbutton_left.ico"
    readonly property url imgButtonRight: Theme.dirItemAssets + "combobox/dropdownbutton_right.ico"
    readonly property url imgArrow: Theme.dirItemAssets + "combobox/dropdownbutton_arrow.ico"

    property int buttonType: DropdownIndicator.ButtonTypes.Normal

    enum ButtonTypes { Normal, Left, Right }
    enum States { Normal, Hot, Pressed, Disabled }

    width: 17

    contentItem: Image {
        anchors.centerIn: parent

        source: imgArrow
        fillMode: Image.Pad

        currentFrame: {
            if (!control.enabled) return DropdownIndicator.States.Disabled
            if (control.pressed) return DropdownIndicator.States.Pressed
            if (control.hovered) return DropdownIndicator.States.Hot
            return DropdownIndicator.States.Normal
        }
    }

    background: BorderImage {
        anchors.fill: parent
        // TODO: Make this change based on states
        border.left: 2; border.top: 7; border.right: 2;  border.bottom: 8
        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Stretch

        source: {
            if (buttonType === DropdownIndicator.ButtonTypes.Left) return imgButtonLeft
            if (buttonType === DropdownIndicator.ButtonTypes.Right) return imgButtonRight
            return imgButton
        }

        currentFrame: {
            if (control.down && background.opacity === 1) return DropdownIndicator.States.Pressed
            return DropdownIndicator.States.Hot
        }

        opacity: control.hovered ? 1 : 0

        Behavior on opacity {
            NumberAnimation {
                duration: background.opacity === 0 ? 200 : 700
                easing.type: Easing.Linear
            }
        }
    }
}