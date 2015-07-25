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

SceneItem {
    id: peAttractor

    frameColor: "#ff0000"

    property string type: "Attractor"
    property bool isAffector: true
    property int uniqueID: ObjectManager.getNewAffectorID()

    Attractor {
        id: attractor
        anchors.fill: parent
        system: ObjectManager.getDefaultSystem()

        Component.onCompleted: {
            shape = scene.rectangleShapeComponent.createObject(attractor)
        }

        function getListProperty(propertyName) {
            var listPropertyValues = []

            for (var key in attractor[propertyName])
                listPropertyValues.push(attractor[propertyName][key])

            return listPropertyValues
        }

        function getAffectedParameter() {
            var affectedParameterString = ""

            switch (affectedParameter) {
            case Attractor.Position:
                affectedParameterString = "Attractor.Position"
                break
            case Attractor.Velocity:
                affectedParameterString = "Attractor.Velocity"
                break
            case Attractor.Acceleration:
                affectedParameterString = "Attractor.Acceleration"
                break
            }

            return affectedParameterString
        }

        function getProportionalToDistance() {
            var proportionalToDistanceString = ""

            switch (proportionalToDistance) {
            case Attractor.Constant:
                proportionalToDistanceString = "Attractor.Constant"
                break
            case Attractor.Linear:
                proportionalToDistanceString = "Attractor.Linear"
                break
            case Attractor.InverseLinear:
                proportionalToDistanceString = "Attractor.InverseLinear"
                break
            case Attractor.Quadratic:
                proportionalToDistanceString = "Attractor.Quadratic"
                break
            case Attractor.InverseQuadratic:
                proportionalToDistanceString = "Attractor.InverseQuadratic"
                break
            }

            return proportionalToDistanceString
        }
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

                    text: peAttractor.type
                    enabled: false
                }

                PropertyNameLabel {
                    text: "Object name"
                }
                TextField {
                    Layout.fillWidth: true

                    maximumLength: 50

                    text: peAttractor.objectName
                    onTextChanged:
                        peAttractor.objectName = text
                }

                PropertyNameLabel {
                    text: "Width"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 1
                    maximumValue: consts.maxInt

                    value: peAttractor.width
                    onValueChanged:
                        peAttractor.width = value
                }

                PropertyNameLabel {
                    text: "Height"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 1
                    maximumValue: consts.maxInt

                    value: peAttractor.height
                    onValueChanged:
                        peAttractor.height = value
                }

                PropertyNameLabel {
                    text: "Enabled"
                }
                CheckBox {
                    Layout.fillWidth: true

                    checked: attractor.enabled
                    onCheckedChanged:
                        attractor.enabled = checked
                }

                PropertyNameLabel {
                    text: "Groups"
                }
                TextField {
                    Layout.fillWidth: true

                    text: attractor.groups.join(",")
                    onTextChanged: {
                        // here [] !== [""], what is ~right~ for emitter's property "group" which equals to an empty string ("") by default
                        if (text === "")
                            attractor.groups = []
                        else
                            attractor.groups = text.split(",")
                    }
                }

                PropertyNameLabel {
                    text: "When colliding with"
                }
                TextField {
                    Layout.fillWidth: true

                    text: attractor.whenCollidingWith.join(",")
                    onTextChanged:
                        attractor.whenCollidingWith = text.split(",")
                }

                PropertyNameLabel {
                    text: "Once"
                }
                CheckBox {
                    Layout.fillWidth: true

                    checked: attractor.once
                    onCheckedChanged:
                        attractor.once = checked
                }

                PropertyNameLabel {
                    text: "Affected parameter"
                }
                ComboBox {
                    Layout.fillWidth: true
                    model: ["Position", "Velocity", "Acceleration"]
                    currentIndex:
                        switch (attractor.affectedParameter) {
                        case Attractor.Position:
                            0; break
                        case Attractor.Velocity:
                            1; break
                        case Attractor.Acceleration:
                            2; break
                        }

                    onActivated: {
                        switch (index) {
                        case 0:
                            attractor.affectedParameter = Attractor.Position
                            break
                        case 1:
                            attractor.affectedParameter = Attractor.Velocity
                            break
                        case 2:
                            attractor.affectedParameter = Attractor.Acceleration
                            break
                        }
                    }
                }

                PropertyNameLabel {
                    text: "Proportional to distance"
                }
                ComboBox {
                    Layout.fillWidth: true
                    model: ["Constant", "Linear", "InverseLinear", "Quadratic", "Inverse quadratic"]
                    currentIndex:
                        switch (attractor.proportionalToDistance) {
                        case Attractor.Constant:
                            0; break
                        case Attractor.Linear:
                            1; break
                        case Attractor.InverseLinear:
                            2; break
                        case Attractor.Quadratic:
                            3; break
                        case Attractor.InverseQuadratic:
                            4; break
                        }

                    onActivated: {
                        switch (index) {
                        case 0:
                            attractor.proportionalToDistance = Attractor.Constant
                            break
                        case 1:
                            attractor.proportionalToDistance = Attractor.Linear
                            break
                        case 2:
                            attractor.proportionalToDistance = Attractor.InverseLinear
                            break
                        case 3:
                            attractor.proportionalToDistance = Attractor.Quadratic
                            break
                        case 4:
                            attractor.proportionalToDistance = Attractor.InverseQuadratic
                            break
                        }
                    }
                }

                PropertyNameLabel {
                    text: "Shape"
                }
                ComboBox {
                    Layout.fillWidth: true
                    model: ["Ellipse", "Line", "Mask", "Rectangle"]
                    currentIndex:
                        switch (attractor.shape.type) {
                        case "EllipseShape":
                            0; break
                        case "LineShape":
                            1; break
                        case "MaskShape":
                            2; break
                        case "RectangleShape":
                            3; break
                        }

                    onActivated: {
                        var oldShape = attractor.shape

                        switch (index) {
                        case 0:
                            attractor.shape = scene.ellipseShapeComponent.createObject(attractor)
                            break
                        case 1:
                            attractor.shape = scene.lineShapeComponent.createObject(attractor)
                            break
                        case 2:
                            attractor.shape = scene.maskShapeComponent.createObject(attractor)
                            break
                        case 3:
                            attractor.shape = scene.rectangleShapeComponent.createObject(attractor)
                            break
                        }

                        oldShape.destroy()
                    }
                }

                PropertyNameLabel {
                    visible: attractor.shape.type === "EllipseShape"
                    text: "Fill"
                }
                CheckBox {
                    visible: attractor.shape.type === "EllipseShape"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            checked = attractor.shape.fill
                    }
                    onVisibleChanged: {
                        if (visible)
                            checked = attractor.shape.fill
                    }
                    onCheckedChanged:
                        attractor.shape.fill = checked
                }

                PropertyNameLabel {
                    visible: attractor.shape.type === "LineShape"
                    text: "Mirrored"
                }
                CheckBox {
                    visible: attractor.shape.type === "LineShape"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            checked = attractor.shape.mirrored
                    }
                    onVisibleChanged: {
                        if (visible)
                            checked = attractor.shape.mirrored
                    }
                    onCheckedChanged:
                        attractor.shape.mirrored = checked
                }

                PropertyNameLabel {
                    visible: attractor.shape.type === "MaskShape"
                    text: "Source"
                }
                ImageSelector {
                    visible: attractor.shape.type === "MaskShape"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            path = attractor.shape.source
                    }
                    onVisibleChanged: {
                        if (visible)
                            path = attractor.shape.source
                    }
                    onPathChanged:
                        attractor.shape.source = path
                }

                Item {
                    Layout.fillHeight: true
                }
            }
        }

    function toQML() {
        var genericProperties = ["objectName", "x", "y", "width", "height"]
        var properties = ["enabled", "groups", "whenCollidingWith", "once", "affectedParameter", "proportionalToDistance", "system"]
        var objectProperties = ["shape"]

        var data = "    " + peAttractor.type + " {"

        for (var i = 0; i < genericProperties.length; i++)
            data += "\n        %1: %2".arg(genericProperties[i]).arg(JSON.stringify(peAttractor[genericProperties[i]]))

        for (i = 0; i < properties.length; i++) {
            if (properties[i] === "system")
                data += "\n        %1: %2".arg(properties[i]).arg(attractor.system.objectName)
            else if (properties[i] === "groups" || properties[i] === "whenCollidingWith")
                data += "\n        %1: %2".arg(properties[i]).arg(JSON.stringify(attractor.getListProperty(properties[i])))
            else if (properties[i] === "affectedParameter")
                data += "\n        %1: %2".arg(properties[i]).arg(attractor.getAffectedParameter())
            else if (properties[i] === "proportionalToDistance")
                data += "\n        %1: %2".arg(properties[i]).arg(attractor.getProportionalToDistance())
            else
                data += "\n        %1: %2".arg(properties[i]).arg(JSON.stringify(attractor[properties[i]]))
        }

        for (i = 0; i < objectProperties.length; i++) {
            data += "\n        %1:\n%2".arg(objectProperties[i]).arg(attractor[objectProperties[i]].toQML())
        }

        data += "\n    }"

        return data
    }
}
