pragma Singleton
import QtQuick

QtObject {
    readonly property color colText: "#000000"
    readonly property color colTextDisabled: "#838383"

    readonly property color colWindowBackground: "#FFFFFF"
    readonly property color colWindowSecondaryBackground: "#F0F0F0"

    readonly property color colTextHighlight: "#3399ff"

    readonly property url dirItemAssets: Qt.resolvedUrl("assets/items/button/")
}
