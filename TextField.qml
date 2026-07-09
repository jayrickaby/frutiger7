// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only
// Qt-Security score:significant reason:default

import QtQuick
import QtQuick.Controls.impl
import QtQuick.Controls.Basic.impl
import QtQuick.Templates as T

T.TextField {
    id: control

    property int borderType: TextField.BorderTypes.Default
    property url imgBorder_noScroll: Theme.dirItemAssets + "textedit/border_noscroll.ico"
    property url imgBorder_hScroll: Theme.dirItemAssets + "textedit/border_hscroll.ico"
    property url imgBorder_vScroll: Theme.dirItemAssets + "textedit/border_vscroll.ico"
    property url imgBorder_hvScroll: Theme.dirItemAssets + "textedit/border_hvscroll.ico"

    enum BorderTypes { Default, Horizontal, Vertical, HorizontalVertical }
    enum States { Normal, Hot, Focused, Disabled }

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                             contentWidth + leftPadding + rightPadding,
                             leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding,
                             topPadding + bottomPadding)

    padding: 6
    topPadding: 3
    bottomPadding: padding - 1

    verticalAlignment: TextInput.AlignVCenter

    selectionColor: Theme.colTextHighlight

    font.pointSize: 9
    // font.letterSpacing: 0.05
    renderType: Text.NativeRendering

    background: BorderImage {
        border.left: 2
        border.right: 2
        border.top: 2
        border.bottom: 2

        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Repeat

        source: {
            if (borderType === TextField.BorderTypes.Horizontal) return imgBorder_hScroll
            if (borderType === TextField.BorderTypes.Vertical) return imgBorder_vScroll
            if (borderType === TextField.BorderTypes.HorizontalVertical) return imgBorder_hvScroll
            return imgBorder_noScroll
        }

        currentFrame: {
            if (!control.enabled) return TextField.States.Disabled
            if (control.pressed || control.focus) return TextField.States.Focused
            if (!control.hovered) return TextField.States.Hot
            return TextField.States.Normal
        }
    }
}
