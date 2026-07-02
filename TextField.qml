// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only
// Qt-Security score:significant reason:default

import QtQuick
import QtQuick.Controls.impl
import QtQuick.Controls.Basic.impl
import QtQuick.Templates as T

T.TextField {
    id: control

    readonly property url dirAssets: Qt.resolvedUrl("assets/items/textedit/")

    readonly property string img: "background.png"
    readonly property string imgFocused: "background_focused.png"
    readonly property string imgHot: "background_hot.png"
    readonly property string imgDisabled: "background_disabled.png"

    readonly property string colText: "#000000"
    // TODO: Is this the same as Button.qml?
    readonly property string colTextDisabled: "#838383"

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                             contentWidth + leftPadding + rightPadding,
                             leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding,
                             topPadding + bottomPadding)

    padding: 6
    leftPadding: padding + 4
    verticalAlignment: TextInput.AlignVCenter

    color: control.enabled ? colText : colTextDisabled
    font.pointSize: 9
    renderType: Text.NativeRendering

    background: BorderImage {
        border.left: 2
        border.right: 2
        border.top: 2
        border.bottom: 2

        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Repeat

        // Swap the image asset depending on whether the button is hovered or pressed
        source: {
            if (!control.enabled) {
                return dirAssets + imgDisabled
            }
            if (control.focused) {
                return dirAssets + imgFocused
            }
            if (control.hovered) {
                return dirAssets + imgHot
            }
            return dirAssets + img
        }
    }
}
