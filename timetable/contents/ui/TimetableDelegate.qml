/********************************************************************
Copyright (C) 2016 R. Harish Navnit <harishnavnit@gmail.com>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*********************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.1

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.components 2.0 as PlasmaComponents

PlasmaComponents.ListItem {
    id: timetableItem

    width: parent.width
    //height: parent.height
    anchors.fill: parent
    enabled: ListView.isCurrentItem

    readonly property var routeStops:   getModelData(timetableSource.data, "RouteStops", "")
    readonly property var stopDateTime: getModelData(timetableSource.data, "DepartureDateTime", "00:00")
    readonly property string startStop: getModelData(timetableSource.data, "StartStop", "Oslo Bussterminal")
    readonly property string targetStop:getModelData(timetableSource.data, "Target", "Unknown")
    readonly property string transportLine: getModelData(timetableSource.data, "TransportLine", "Unknown")

    function getModelData(data, key, defaultValue) {
        var source = model.name

        return data[source] ? (
            data[source]["departures"][timetableList.currentIndex][key] ?
                data[source]["departures"][timetableList.currentIndex][key] : defaultValue
        ) : defaultValue
    }

    PlasmaComponents.Label {
        id: transportLineLabel
        anchors {
            left: parent.left
            margins: 20
        }
        text: transportLine
        elide: Text.ElideRight
        wrapMode: Text.Wrap
        textFormat: Text.StyledText
    }

    PlasmaComponents.Label {
        id: targetStopLabel
        anchors {
            left: transportLineLabel.right
            right: dateTimeLabel.left
            margins: 50
        }
        text: targetStop
        elide: Text.ElideRight
        wrapMode: Text.Wrap
        textFormat: Text.StyledText
    }

    PlasmaComponents.Label {
        id: dateTimeLabel
        anchors {
            right: parent.right
            margins: 20
        }
        text: stopDateTime
        elide: Text.ElideRight
        wrapMode: Text.Wrap
        textFormat: Text.StyledText
    }
}
