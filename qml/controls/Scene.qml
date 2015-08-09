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
import "../scripts/ObjectManager.js" as ObjectManager

Item {
    id: scene

    objectName: "Particle scene"
    width: 500
    height: 500

    clip: true

    property string type: "Scene"
    property SceneItem selectedItem: null

    property Component particleSystemComponent: Qt.createComponent("../components/PEParticleSystem.qml")
    property Component imageParticleComponent: Qt.createComponent("../components/PEImageParticle.qml")
    // scene items
    property Component emitterComponent: Qt.createComponent("../components/PEEmitter.qml")
    property Component ageComponent: Qt.createComponent("../components/PEAge.qml")
    property Component attractorComponent: Qt.createComponent("../components/PEAttractor.qml")
    property Component frictionComponent: Qt.createComponent("../components/PEFriction.qml")
    property Component gravityComponent: Qt.createComponent("../components/PEGravity.qml")
    property Component turbulenceComponent: Qt.createComponent("../components/PETurbulence.qml")
    property Component wanderComponent: Qt.createComponent("../components/PEWander.qml")
    // directions
    property Component angleDirectionComponent: Qt.createComponent("../components/PEAngleDirection.qml")
    property Component cumulativeDirectionComponent: Qt.createComponent("../components/PECumulativeDirection.qml")
    property Component pointDirectionComponent: Qt.createComponent("../components/PEPointDirection.qml")
    property Component targetDirection: Qt.createComponent("../components/PETargetDirection.qml")
    // shapes
    property Component ellipseShapeComponent: Qt.createComponent("../components/PEEllipseShape.qml")
    property Component lineShapeComponent: Qt.createComponent("../components/PELineShape.qml")
    property Component maskShapeComponent: Qt.createComponent("../components/PEMaskShape.qml")
    property Component rectangleShapeComponent: Qt.createComponent("../components/PERectangleShape.qml")

    Component.onCompleted: {
        var defaultSystemParams = {
            "objectName" : "particleSystem"
        }
        ObjectManager.system = particleSystemComponent.createObject(scene, defaultSystemParams)
    }

    MouseArea {
        anchors.fill: parent
        onPressed:
            selectedItem = null
    }

    Rectangle {
        id: backgroundRect
        anchors.fill: parent
        color: "#ffffff"
    }

    Item {
        id: sceneItemsContainer
        anchors.fill: parent
    }

    property Component settingsComponent:
        Component {
            GridLayout {
                columns: 2

                PropertyNameLabel {
                    text: "Type"
                }
                TextField {
                    Layout.fillWidth: true

                    text: scene.type
                    enabled: false
                }

                PropertyNameLabel {
                    text: "Object name"
                }
                TextField {
                    Layout.fillWidth: true

                    maximumLength: 50

                    text: scene.objectName
                    onTextChanged:
                        scene.objectName = text
                }

                PropertyNameLabel {
                    text: "Width"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: sceneItemsContainer.childrenRect.x + sceneItemsContainer.childrenRect.width
                    maximumValue: consts.maxInt

                    value: scene.width
                    onValueChanged:
                        scene.width = value
                }

                PropertyNameLabel {
                    text: "Height"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: sceneItemsContainer.childrenRect.y + sceneItemsContainer.childrenRect.height
                    maximumValue: consts.maxInt

                    value: scene.height
                    onValueChanged:
                        scene.height = value
                }

                PropertyNameLabel {
                    text: "Color"
                }
                ColorSelector {
                    color: backgroundRect.color
                    onColorChanged:
                        backgroundRect.color = color
                }

                PropertyNameLabel {
                    text: "Items frames visible"
                }

                CheckBox {
                    Layout.fillWidth: true

                    checked: settings.framesVisible
                    onCheckedChanged:
                        settings.framesVisible = checked
                }

                Item {
                    Layout.fillHeight: true
                }
            }
        }

    function createObject(type, params) {
        var component

        switch (type) {
        case "ImageParticle":
            component = imageParticleComponent
            break
        case "Emitter":
            component = emitterComponent
            break
        case "Age":
            component = ageComponent
            break
        case "Attractor":
            component = attractorComponent
            break
        case "Friction":
            component = frictionComponent
            break
        case "Gravity":
            component = gravityComponent
            break
        case "Turbulence":
            component = turbulenceComponent
            break
        case "Wander":
            component = wanderComponent
            break
        }
        if (params === undefined)
            params = {}

        var object = component.createObject(sceneItemsContainer, params)

        if (object.isEmitter || object.isAffector)
            selectedItem = object

        if (object.isParticle)
            ObjectManager.particles[object.uniqueID] = object
        else if (object.isEmitter)
            ObjectManager.emitters[object.uniqueID] = object
        else if (object.isAffector)
            ObjectManager.affectors[object.uniqueID] = object

        return object
    }

    function deleteObject(object) {
        var container

        if (object.isParticle)
            delete ObjectManager.particles[object.uniqueID]
        else if (object.isEmitter)
            delete ObjectManager.emitters[object.uniqueID]
        else if (object.isAffector)
            delete ObjectManager.affectors[object.uniqueID]

        if (object === selectedItem)
            selectedItem = null

        object.destroy()
    }

    function deleteSelectedItem() {
        if (selectedItem !== null)
            deleteObject(selectedItem)
    }

    function toQML() {
        var genericProperties = ["objectName", "width", "height" ]

        var data = "Item {"

        for (var i = 0; i < genericProperties.length; i++)
            data += "\n    %1: %2".arg(genericProperties[i]).arg(JSON.stringify(scene[genericProperties[i]]))

        data += "\n\n" + ObjectManager.getDefaultSystem().toQML()

        for (var k in ObjectManager.particles)
            data += "\n\n" + ObjectManager.particles[k].toQML()

        for (k in ObjectManager.emitters)
            data += "\n\n" + ObjectManager.emitters[k].toQML()

        for (k in ObjectManager.affectors)
            data += "\n\n" + ObjectManager.affectors[k].toQML()

        data += "\n}"

        return data
    }
}
