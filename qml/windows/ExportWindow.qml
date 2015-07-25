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
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2

Window {
    title: "Export QML code"
    width: 640
    height: 480
    minimumWidth: 640
    minimumHeight: 480
    modality: Qt.ApplicationModal
    color: systemPalette.window

    function refresh() {
        var importModules = "import QtQuick 2.4\nimport QtQuick.Particles 2.0\n\n"

        textArea.cursorPosition = 0
        textArea.text = importModules + sceneArea.scene.toQML()
    }

    onVisibleChanged: {
        if (visible)
            refresh()
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: spacing

        TextArea {
            id: textArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.family: "Liberation Mono"
        }

        RowLayout {
            Button {
                text: "Refresh"
                onClicked:
                    refresh()
            }

            Button {
                text: "Copy all"
                onClicked: {
                    textArea.selectAll()
                    textArea.copy()
                    textArea.deselect()
                }
            }
        }
    }
}
