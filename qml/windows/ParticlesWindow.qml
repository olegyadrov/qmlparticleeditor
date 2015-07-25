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
import "../scripts/ObjectManager.js" as ObjectManager
import "../controls"

Window {
    title: "Manage particles"
    width: 360
    height: 500
    minimumWidth: 360
    minimumHeight: 500
    modality: Qt.ApplicationModal
    color: systemPalette.window

    property Item selectedParticle: null

    ListModel {
        id: particlesModel
    }

    function refresh() {
        particlesModel.clear()

        var particle

        for (var k in ObjectManager.particles) {
            particle = ObjectManager.particles[k]
            particlesModel.append({
                "objectName" : particle.objectName,
                "groups" : particle.getListProperty("groups").join(","),
                "source" : particle.source.toString(),
                "particle" : particle
            })
        }
    }

    onVisibleChanged: {
        if (visible)
            refresh()
    }

    Item {
        id: allParticlesLayout
        anchors.fill: parent
        visible: selectedParticle === null

        ScrollView {
            id: scrollView
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: newParticleButton.top
            anchors.bottomMargin: 8

            ListView {
                model: particlesModel
                delegate: Item {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 100

                    Rectangle {
                        id: previewArea
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.topMargin: 8
                        width: height
                        color: "lightgray"
                        border.width: 1
                        border.color: "gray"

                        Image {
                            anchors.centerIn: parent
                            width: Math.min(parent.width - parent.border.width * 2, sourceSize.width)
                            height: Math.min(parent.height  - parent.border.width * 2, sourceSize.height)
                            source: model.source
                        }
                    }

                    ColumnLayout {
                        anchors.left: previewArea.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 8
                        anchors.topMargin: 8

                        Label {
                            text: "Object name: " + model.objectName
                        }

                        Label {
                            text: "Groups: " + model.groups
                        }

                        Item {
                            Layout.fillHeight: true
                        }

                        RowLayout {
                            Button {
                                text: "Edit"
                                onClicked: selectedParticle = model.particle
                            }

                            Button {
                                text: "Delete"
                                onClicked: {
                                    sceneArea.scene.deleteObject(model.particle)
                                    refresh()
                                }
                            }
                        }
                    }
                }
            }
        }

        Button {
            id: newParticleButton

            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: 8

            text: "Create new"

            onClicked: {
                sceneArea.scene.createObject("ImageParticle")
                refresh()
            }
        }
    }

    Item {
        id: editParticleLayout
        anchors.fill: parent
        visible: selectedParticle !== null

        SettingsPanel {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: backButton.top
            anchors.bottomMargin: 8

            settingsComponent: selectedParticle ? selectedParticle.settingsComponent : null
        }

        Button {
            id: backButton

            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 8

            text: "OK"
            onClicked: {
                selectedParticle = null
                refresh()
            }
        }
    }
}
