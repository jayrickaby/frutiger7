// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only
// Qt-Security score:significant reason:default

import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T

T.Button {
    id: control

    readonly property url dirAssets: Qt.resolvedUrl("assets/items/button/")

    readonly property string img: "background.png"
    readonly property string imgHot: "background_hot.png"
    readonly property string imgPressed: "background_pressed.png"
    readonly property string imgDisabled: "background_disabled.png"
    readonly property string imgDefault: "background_default.png"
    readonly property string imgDefaultAnimated: "background_default_animated.png"

    readonly property string colText: "#000000"
    readonly property string colTextDisabled: "#838383"

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

    contentItem: Text {
        text: control.text

        // Frutiger7 Overrides
        color: control.enabled ? colText : colTextDisabled
        font.pointSize: 9
        renderType: Text.NativeRendering

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        leftPadding: control.textHCenterOffset
        topPadding: control.textVCenterOffset
    }

    background: BorderImage {
        border.left: 3
        border.right: 3
        border.top: 3
        border.bottom: 3

        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Stretch

        // Swap the image asset depending on whether the button is hovered or pressed
        source: {
            if (control.pressed) {
                return dirAssets + imgPressed
            }
            if (control.hovered) {
                return dirAssets + imgHot
            }
            if (control.highlighted) {
                return dirAssets + imgDefault
            }
            return dirAssets + img
        }
    }
}
