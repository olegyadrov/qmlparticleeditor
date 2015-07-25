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
import QtQuick.Particles 2.0
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import "../scripts/ObjectManager.js" as ObjectManager
import "../controls"

ImageParticle {
    id: peImageParticle

    system: ObjectManager.getDefaultSystem()
    color: "#000000"

    property string type: "ImageParticle"
    property bool isParticle: true
    property int uniqueID: ObjectManager.getNewParticleID()

    function getListProperty(propertyName) {
        var listPropertyValues = []

        for (var key in peImageParticle[propertyName])
            listPropertyValues.push(peImageParticle[propertyName][key])

        return listPropertyValues
    }

    function getEntryEffect() {
        var entryEffectString = ""

        switch (entryEffect) {
        case ImageParticle.None:
            entryEffectString = "ImageParticle.None"
            break
        case ImageParticle.Fade:
            entryEffectString = "ImageParticle.Fade"
            break
        case ImageParticle.Scale:
            entryEffectString = "ImageParticle.Scale"
            break
        }

        return entryEffectString
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

                    text: peImageParticle.type
                    enabled: false
                }

                PropertyNameLabel {
                    text: "Object name"
                }
                TextField {
                    Layout.fillWidth: true

                    maximumLength: 50

                    text: peImageParticle.objectName
                    onTextChanged:
                        peImageParticle.objectName = text
                }

                PropertyNameLabel {
                    text: "Groups"
                }
                TextField {
                    Layout.fillWidth: true

                    text: peImageParticle.groups.join(",")
                    onTextChanged: {
                        // here [] !== [""], what is ~right~ for emitter's property "group" which equals to an empty string ("") by default
                        if (text === "")
                            peImageParticle.groups = []
                        else
                            peImageParticle.groups = text.split(",")
                    }
                }

                PropertyNameLabel {
                    text: "Source"
                }
                ImageSelector {
                    Layout.fillWidth: true

                    path: peImageParticle.source
                    onPathChanged:
                        peImageParticle.source = path
                }

                PropertyNameLabel {
                    text: "Color"
                }
                ColorSelector {
                    color: peImageParticle.color
                    onColorChanged:
                        peImageParticle.color = color
                }

                PropertyNameLabel {
                    text: "Color variation"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: 1
                    decimals: 2
                    stepSize: 0.1

                    value: peImageParticle.colorVariation
                    onValueChanged:
                        peImageParticle.colorVariation = value
                }

                PropertyNameLabel {
                    text: "Alpha"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: 1
                    decimals: 2
                    stepSize: 0.1

                    value: peImageParticle.alpha
                    onValueChanged:
                        peImageParticle.alpha = value
                }

                PropertyNameLabel {
                    text: "Alpha variation"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: 1
                    decimals: 2
                    stepSize: 0.1

                    value: peImageParticle.alphaVariation
                    onValueChanged:
                        peImageParticle.alphaVariation = value
                }

                PropertyNameLabel {
                    text: "Red variation"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: 1
                    decimals: 2
                    stepSize: 0.1

                    value: peImageParticle.redVariation
                    onValueChanged:
                        peImageParticle.redVariation = value
                }

                PropertyNameLabel {
                    text: "Green variation"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: 1
                    decimals: 2
                    stepSize: 0.1

                    value: peImageParticle.greenVariation
                    onValueChanged:
                        peImageParticle.greenVariation = value
                }

                PropertyNameLabel {
                    text: "Blue variation"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: 1
                    decimals: 2
                    stepSize: 0.1

                    value: peImageParticle.blueVariation
                    onValueChanged:
                        peImageParticle.blueVariation = value
                }

                PropertyNameLabel {
                    text: "Rotation"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: -360
                    maximumValue: 360
                    decimals: 2

                    value: peImageParticle.rotation
                    onValueChanged:
                        peImageParticle.rotation = value
                }

                PropertyNameLabel {
                    text: "Rotation variation"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: -360
                    maximumValue: 360
                    decimals: 2

                    value: peImageParticle.rotationVariation
                    onValueChanged:
                        peImageParticle.rotationVariation = value
                }

                PropertyNameLabel {
                    text: "Auto rotation"
                }
                CheckBox {
                    Layout.fillWidth: true

                    checked: peImageParticle.autoRotation
                    onCheckedChanged:
                        peImageParticle.autoRotation = checked
                }

                PropertyNameLabel {
                    text: "Rotation velocity"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: consts.maxInt
                    decimals: 2

                    value: peImageParticle.rotationVelocity
                    onValueChanged:
                        peImageParticle.rotationVelocity = value
                }

                PropertyNameLabel {
                    text: "Rotation velocity variation"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: consts.maxInt
                    decimals: 2

                    value: peImageParticle.rotationVelocityVariation
                    onValueChanged:
                        peImageParticle.rotationVelocityVariation = value
                }

                PropertyNameLabel {
                    text: "Entry effect"
                }
                ComboBox {
                    Layout.fillWidth: true
                    model: ["None", "Fade", "Scale"]
                    currentIndex:
                        switch (peImageParticle.entryEffect) {
                        case ImageParticle.None:
                            0; break
                        case ImageParticle.Fade:
                            1; break
                        case ImageParticle.Scale:
                            2; break
                        }

                    onActivated: {
                        switch (index) {
                        case 0:
                            peImageParticle.entryEffect = ImageParticle.None
                            break
                        case 1:
                            peImageParticle.entryEffect = ImageParticle.Fade
                            break
                        case 2:
                            peImageParticle.entryEffect = ImageParticle.Scale
                            break
                        }
                    }
                }

                Item {
                    Layout.fillHeight: true
                }
            }
        }

    function toQML() {
        var properties = ["objectName", "groups", "source", "color", "colorVariation", "alpha", "alphaVariation", "redVariation",
                          "greenVariation", "blueVariation", "rotation", "rotationVariation", "autoRotation", "rotationVelocity",
                          "rotationVelocityVariation", "entryEffect", "system"]

        var data = "    " + peImageParticle.type + " {"

        for (var i = 0; i < properties.length; i++)
            if (properties[i] === "system")
                data += "\n        %1: %2".arg(properties[i]).arg(peImageParticle.system.objectName)
            else if (properties[i] === "groups")
                data += "\n        %1: %2".arg(properties[i]).arg(JSON.stringify(peImageParticle.getListProperty(properties[i])))
            else if (properties[i] === "source" || properties[i] === "color")
                data += "\n        %1: %2".arg(properties[i]).arg(JSON.stringify(peImageParticle[properties[i]].toString()))
            else if (properties[i] === "entryEffect")
                data += "\n        %1: %2".arg(properties[i]).arg(peImageParticle.getEntryEffect())
            else
                data += "\n        %1: %2".arg(properties[i]).arg(JSON.stringify(peImageParticle[properties[i]]))

        data += "\n    }"

        return data
    }
}
