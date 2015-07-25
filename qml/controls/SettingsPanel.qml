/****************************************************************************
**
** Copyright (C) 2013-2015 Oleg Yadrov
**
** Licensed under the Apache License, Version 2.0 (the "License");
** you may not use this file except in compliance with the License.
** You may obtain a copy of the License at
**
** http://www.apache.org/licenses/LICENSE-2.0
**
** Unless required by applicable law or agreed to in writing, software
** distributed under the License is distributed on an "AS IS" BASIS,
** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
** See the License for the specific language governing permissions and
** limitations under the License.
**
****************************************************************************/

import QtQuick 2.4
import QtQuick.Controls 1.2

Item {
    id: settingsPanel

    property alias settingsComponent: loader.sourceComponent

    ScrollView {
        id: scrollView
        anchors.fill: parent
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

        Item {
            width: scrollView.width * 2
            height: loader.status === Loader.Ready ? loader.item.height + loader.margin * 2 : 0

            Loader {
                id: loader
                x: margin
                y: margin
                width: scrollView.viewport.width - margin * 2
                property int margin: 10
            }
        }
    }
}
