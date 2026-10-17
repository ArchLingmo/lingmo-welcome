/*
 * Copyright (C) 2026 LingmoOS Team.
 *
 * Author:     devalexandre <alexandre@dev2learn.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick
import LingmoUI.CompatibleModule 3.0 as LingmoUI

// ActionButton without a resting background, for low-key actions ("Skip").
// LingmoUI.ActionButton has no flat variant yet.
LingmoUI.ActionButton {
    id: control

    background: Rectangle {
        implicitHeight: LingmoUI.Units.controlHeight
        implicitWidth: LingmoUI.Units.controlHeight * 2
        radius: LingmoUI.Theme.smallRadius
        color: control.down ? LingmoUI.Theme.pressedColor
             : control.hovered ? LingmoUI.Theme.hoverColor : "transparent"
        border.width: control.visualFocus ? 2 : 0
        border.color: LingmoUI.Theme.highlightColor

        Behavior on color { ColorAnimation { duration: LingmoUI.Units.veryShortDuration } }
    }
}
