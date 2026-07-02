// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only
// Qt-Security score:significant reason:default

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Controls.Basic.impl
import QtQuick.Templates as T

T.ComboBox {
    id: control

    readonly property url dirEditableAssets: Qt.resolvedUrl("assets/items/textedit/")

    readonly property string imgEditableBackground: "background.png"
    readonly property string imgEditableBackgroundFocused: "background_focused.png"
    readonly property string imgEditableBackgroundHot: "background_hot.png"
    readonly property string imgEditableBackgroundDisabled: "background_disabled.png"

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)


    contentItem: T.TextField {
        padding: 6
        leftPadding: padding + 4
        verticalAlignment: TextInput.AlignVCenter

        font.pointSize: 9
        renderType: Text.NativeRendering

        background: BorderImage {
            visible: control.editable

            border.left: 2
            border.right: 2
            border.top: 2
            border.bottom: 2

            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Repeat

            // Swap the image asset depending on whether the button is hovered or pressed
            source: {
                if (!control.enabled) {
                    return dirEditableAssets + imgEditableBackgroundDisabled
                }
                if (control.focused) {
                    return dirEditableAssets + imgEditableBackgroundFocused
                }
                if (control.hovered) {
                    return dirEditableAssets + imgEditableBackgroundHot
                }
                return dirEditableAssets + imgEditableBackground
            }
        }
    }
}