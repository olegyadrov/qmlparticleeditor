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
import QtQuick.Dialogs 1.2

RowLayout {
    id: colorSelector

    property color color: "#000000"

    Rectangle {
        Layout.fillWidth: true
        height: button.height * 0.8
        Layout.alignment: Qt.AlignHCenter
        color: colorSelector.color
        border.width: 1
        border.color: "#000000"
    }

    Button {
        id: button
        text: "Browse..."
        onClicked: {
            colorDialog.color = colorSelector.color
            colorDialog.open()
        }
    }

    ColorDialog {
        id: colorDialog
        modality: Qt.ApplicationModal
        title: "Please choose a color"
        onAccepted: colorSelector.color = currentColor
    }
}
