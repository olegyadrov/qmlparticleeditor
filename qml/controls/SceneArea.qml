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
import QtQuick.Controls 1.3

Item {
    id: sceneArea

    property alias scene: scene
    property Component settingsComponent: scene.selectedItem ?
                                              scene.selectedItem.settingsComponent :
                                              scene.settingsComponent

    ScrollView {
        anchors.centerIn: parent

        width: Math.min(scene.width, parent.width)
        height: Math.min(scene.height, parent.height)

        horizontalScrollBarPolicy: scene.width > parent.width ?
                                       Qt.ScrollBarAlwaysOn :
                                       Qt.ScrollBarAlwaysOff
        verticalScrollBarPolicy: scene.height > parent.height ?
                                     Qt.ScrollBarAlwaysOn :
                                     Qt.ScrollBarAlwaysOff

        Scene {
            id: scene
        }
    }
}
