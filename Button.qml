// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only
// Qt-Security score:significant reason:default

import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import "."

T.Button {
    id: control

    readonly property url imgBackground: Theme.dirItemAssets + "button/pushbutton.ico"

    // Allow manual adjustment of text as its usually offset incorrectly
    property int textHCenterOffset: 0
    property int textVCenterOffset: 0

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    verticalPadding: 4
    horizontalPadding: 20

    icon.width: 24
    icon.height: 24

    enum States {
        Normal, Hot, Pressed, Disabled, Defaulted, Defaulted_Animating
    }

    contentItem: Text {
        text: control.text

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        leftPadding: control.textHCenterOffset
        topPadding: control.textVCenterOffset

        color: control.enabled ? Theme.colText : Theme.colTextDisabled

        font.letterSpacing: 0.10
        font.pointSize: 9
        renderType: Text.NativeRendering
    }

    background: Item {
        BorderImage {
            id: baseBg
            anchors { fill: parent; margins: -1 }
            border { left: 4; right: 4; top: 4; bottom: 4; }

            z:0

            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Stretch

            source: imgBackground

            currentFrame: {
                if (!control.enabled) return Button.States.Disabled;
                if (control.highlighted) return Button.States.Defaulted;
                return Button.States.Normal;
            }
        }

        BorderImage {
            id: overlayBg
            anchors { fill: parent; margins: -1}
            border { left: 4; right: 4; top: 4; bottom: 4; }

            z:1

            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Stretch

            source: imgBackground

            // TODO: What is going on with highlight glow overlay??
            currentFrame: {
                if (control.pressed) return Button.States.Pressed;
                return Button.States.Hot;
            }

            opacity: control.pressed || control.hovered ? 1 : 0

            Behavior on opacity {
                NumberAnimation {
                    duration: overlayBg.opacity === 0 ? 300 : 1000
                    easing.type: Easing.Linear
                }
            }
        }
    }
}
