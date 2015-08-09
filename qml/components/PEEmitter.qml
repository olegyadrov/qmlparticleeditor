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
    id: peEmitter

    frameColor: settings.emitterColor

    property string type: "Emitter"
    property bool isEmitter: true
    property int uniqueID: ObjectManager.getNewEmitterID()

    Emitter {
        id: emitter
        anchors.fill: parent
        system: ObjectManager.getDefaultSystem()

        Component.onCompleted: {
            velocity = scene.pointDirectionComponent.createObject(emitter)
            acceleration = scene.pointDirectionComponent.createObject(emitter)
            shape = scene.rectangleShapeComponent.createObject(emitter)
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

                    text: peEmitter.type
                    enabled: false
                }

                PropertyNameLabel {
                    text: "Object name"
                }
                TextField {
                    Layout.fillWidth: true

                    maximumLength: 50

                    text: peEmitter.objectName
                    onTextChanged:
                        peEmitter.objectName = text
                }

                PropertyNameLabel {
                    text: "Width"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 1
                    maximumValue: consts.maxInt

                    value: peEmitter.width
                    onValueChanged:
                        peEmitter.width = value
                }

                PropertyNameLabel {
                    text: "Height"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 1
                    maximumValue: consts.maxInt

                    value: peEmitter.height
                    onValueChanged:
                        peEmitter.height = value
                }

                PropertyNameLabel {
                    text: "Enabled"
                }
                CheckBox {
                    Layout.fillWidth: true

                    checked: emitter.enabled
                    onCheckedChanged:
                        emitter.enabled = checked
                }

                PropertyNameLabel {
                    text: "Group"
                }
                TextField {
                    Layout.fillWidth: true

                    text: emitter.group
                    onTextChanged:
                        emitter.group = text
                }

                PropertyNameLabel {
                    text: "Emit rate"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: consts.maxInt
                    decimals: 2

                    value: emitter.emitRate
                    onValueChanged:
                        emitter.emitRate = value
                }

                PropertyNameLabel {
                    text: "Maximum emitted"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: -1
                    maximumValue: consts.maxInt

                    value: emitter.maximumEmitted
                    onValueChanged:
                        emitter.maximumEmitted = value
                }

                PropertyNameLabel {
                    text: "Start time"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: consts.maxInt
                    stepSize: 1000

                    value: emitter.startTime
                    onValueChanged:
                        emitter.startTime = value
                }

                PropertyNameLabel {
                    text: "Life span"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: 600000
                    stepSize: 1000

                    value: emitter.lifeSpan
                    onValueChanged:
                        emitter.lifeSpan = value
                }

                PropertyNameLabel {
                    text: "Life span variation"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: 600000
                    stepSize: 1000

                    value: emitter.lifeSpanVariation
                    onValueChanged:
                        emitter.lifeSpanVariation = value
                }

                PropertyNameLabel {
                    text: "Size"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: consts.maxInt
                    decimals: 2

                    value: emitter.size
                    onValueChanged:
                        emitter.size = value
                }

                PropertyNameLabel {
                    text: "Size variation"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: consts.maxInt
                    decimals: 2

                    value: emitter.sizeVariation
                    onValueChanged:
                        emitter.sizeVariation = value
                }

                PropertyNameLabel {
                    text: "End size"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: -1
                    maximumValue: consts.maxInt
                    decimals: 2

                    value: emitter.endSize
                    onValueChanged:
                        emitter.endSize = value
                }

                PropertyNameLabel {
                    text: "Velocity"
                }
                ComboBox {
                    Layout.fillWidth: true
                    model: ["Angle", "Cumulative", "Point", "Target"]
                    currentIndex:
                        switch (emitter.velocity.type) {
                        case "AngleDirection":
                            0; break
                        case "CumulativeDirection":
                            1; break
                        case "PointDirection":
                            2; break
                        case "TargetDirection":
                            3; break
                        }

                    onActivated: {
                        var oldVelocity = emitter.velocity

                        switch (index) {
                        case 0:
                            emitter.velocity = scene.angleDirectionComponent.createObject(emitter)
                            break
                        case 1:
                            emitter.velocity = scene.cumulativeDirectionComponent.createObject(emitter)
                            break
                        case 2:
                            emitter.velocity = scene.pointDirectionComponent.createObject(emitter)
                            break
                        case 3:
                            emitter.velocity = scene.targetDirectionComponent.createObject(emitter)
                            break
                        }

                        oldVelocity.destroy()
                    }
                }

                PropertyNameLabel {
                    visible: emitter.velocity.type === "AngleDirection"
                    text: "Angle"
                }
                SpinBox {
                    visible: emitter.velocity.type === "AngleDirection"
                    Layout.fillWidth: true

                    minimumValue: -360
                    maximumValue: 360
                    decimals: 2

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.velocity.angle
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.velocity.angle
                    }
                    onValueChanged:
                        emitter.velocity.angle = value
                }

                PropertyNameLabel {
                    visible: emitter.velocity.type === "AngleDirection"
                    text: "Angle variation"
                }
                SpinBox {
                    visible: emitter.velocity.type === "AngleDirection"
                    Layout.fillWidth: true

                    minimumValue: -360
                    maximumValue: 360
                    decimals: 2

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.velocity.angleVariation
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.velocity.angleVariation
                    }
                    onValueChanged:
                        emitter.velocity.angleVariation = value
                }

                PropertyNameLabel {
                    visible: emitter.velocity.type === "AngleDirection"
                    text: "Magnitude"
                }
                SpinBox {
                    visible: emitter.velocity.type === "AngleDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt
                    decimals: 2

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.velocity.magnitude
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.velocity.magnitude
                    }
                    onValueChanged:
                        emitter.velocity.magnitude = value
                }

                PropertyNameLabel {
                    visible: emitter.velocity.type === "AngleDirection"
                    text: "Magnitude variation"
                }
                SpinBox {
                    visible: emitter.velocity.type === "AngleDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt
                    decimals: 2

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.velocity.magnitudeVariation
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.velocity.magnitudeVariation
                    }
                    onValueChanged:
                        emitter.velocity.magnitudeVariation = value
                }

                PropertyNameLabel {
                    visible: emitter.velocity.type === "PointDirection"
                    text: "X"
                }
                SpinBox {
                    visible: emitter.velocity.type === "PointDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.velocity.x
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.velocity.x
                    }
                    onValueChanged:
                        emitter.velocity.x = value
                }

                PropertyNameLabel {
                    visible: emitter.velocity.type === "PointDirection"
                    text: "X variation"
                }
                SpinBox {
                    visible: emitter.velocity.type === "PointDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.velocity.xVariation
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.velocity.xVariation
                    }
                    onValueChanged:
                        emitter.velocity.xVariation = value
                }

                PropertyNameLabel {
                    visible: emitter.velocity.type === "PointDirection"
                    text: "Y"
                }
                SpinBox {
                    visible: emitter.velocity.type === "PointDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.velocity.y
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.velocity.y
                    }
                    onValueChanged:
                        emitter.velocity.y = value
                }

                PropertyNameLabel {
                    visible: emitter.velocity.type === "PointDirection"
                    text: "Y variation"
                }
                SpinBox {
                    visible: emitter.velocity.type === "PointDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.velocity.yVariation
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.velocity.yVariation
                    }
                    onValueChanged:
                        emitter.velocity.yVariation = value
                }

                PropertyNameLabel {
                    visible: emitter.velocity.type === "TargetDirection"
                    text: "Magnitude"
                }
                SpinBox {
                    visible: emitter.velocity.type === "TargetDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt
                    decimals: 2

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.velocity.magnitude
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.velocity.magnitude
                    }
                    onValueChanged:
                        emitter.velocity.magnitude = value
                }

                PropertyNameLabel {
                    visible: emitter.velocity.type === "TargetDirection"
                    text: "Magnitude variation"
                }
                SpinBox {
                    visible: emitter.velocity.type === "TargetDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt
                    decimals: 2

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.velocity.magnitudeVariation
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.velocity.magnitudeVariation
                    }
                    onValueChanged:
                        emitter.velocity.magnitudeVariation = value
                }

                PropertyNameLabel {
                    visible: emitter.velocity.type === "TargetDirection"
                    text: "Proportional magnitude"
                }
                CheckBox {
                    visible: emitter.velocity.type === "TargetDirection"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            checked = emitter.velocity.proportionalMagnitude
                    }
                    onVisibleChanged: {
                        if (visible)
                            checked = emitter.velocity.proportionalMagnitude
                    }
                    onCheckedChanged:
                        emitter.velocity.proportionalMagnitude = checked
                }

                PropertyNameLabel {
                    visible: emitter.velocity.type === "TargetDirection"
                    text: "Target x"
                }
                SpinBox {
                    visible: emitter.velocity.type === "TargetDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt
                    decimals: 2

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.velocity.targetX
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.velocity.targetX
                    }
                    onValueChanged:
                        emitter.velocity.targetX = value
                }

                PropertyNameLabel {
                    visible: emitter.velocity.type === "TargetDirection"
                    text: "Target y"
                }
                SpinBox {
                    visible: emitter.velocity.type === "TargetDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt
                    decimals: 2

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.velocity.targetY
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.velocity.targetY
                    }
                    onValueChanged:
                        emitter.velocity.targetY = value
                }

                PropertyNameLabel {
                    visible: emitter.velocity.type === "TargetDirection"
                    text: "Target variation"
                }
                SpinBox {
                    visible: emitter.velocity.type === "TargetDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt
                    decimals: 2

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.velocity.targetVariation
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.velocity.targetVariation
                    }
                    onValueChanged:
                        emitter.velocity.targetVariation = value
                }

                PropertyNameLabel {
                    text: "Velocity from movement"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: consts.maxInt
                    decimals: 2

                    value: emitter.velocityFromMovement
                    onValueChanged:
                        emitter.velocityFromMovement = value
                }

                PropertyNameLabel {
                    text: "Acceleration"
                }
                ComboBox {
                    Layout.fillWidth: true
                    model: ["Angle", "Cumulative", "Point", "Target"]
                    currentIndex:
                        switch (emitter.acceleration.type) {
                        case "AngleDirection":
                            0; break
                        case "CumulativeDirection":
                            1; break
                        case "PointDirection":
                            2; break
                        case "TargetDirection":
                            3; break
                        }

                    onActivated: {
                        var oldAcceleration = emitter.acceleration

                        switch (index) {
                        case 0:
                            emitter.acceleration = scene.angleDirectionComponent.createObject(emitter)
                            break
                        case 1:
                            emitter.acceleration = scene.cumulativeDirectionComponent.createObject(emitter)
                            break
                        case 2:
                            emitter.acceleration = scene.pointDirectionComponent.createObject(emitter)
                            break
                        case 3:
                            emitter.acceleration = scene.targetDirectionComponent.createObject(emitter)
                            break
                        }

                        oldAcceleration.destroy()
                    }
                }

                PropertyNameLabel {
                    visible: emitter.acceleration.type === "AngleDirection"
                    text: "Angle"
                }
                SpinBox {
                    visible: emitter.acceleration.type === "AngleDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt
                    decimals: 2

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.acceleration.angle
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.acceleration.angle
                    }
                    onValueChanged:
                        emitter.acceleration.angle = value
                }

                PropertyNameLabel {
                    visible: emitter.acceleration.type === "AngleDirection"
                    text: "Angle variation"
                }
                SpinBox {
                    visible: emitter.acceleration.type === "AngleDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt
                    decimals: 2

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.acceleration.angleVariation
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.acceleration.angleVariation
                    }
                    onValueChanged:
                        emitter.acceleration.angleVariation = value
                }

                PropertyNameLabel {
                    visible: emitter.acceleration.type === "AngleDirection"
                    text: "Magnitude"
                }
                SpinBox {
                    visible: emitter.acceleration.type === "AngleDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt
                    decimals: 2

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.acceleration.magnitude
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.acceleration.magnitude
                    }
                    onValueChanged:
                        emitter.acceleration.magnitude = value
                }

                PropertyNameLabel {
                    visible: emitter.acceleration.type === "AngleDirection"
                    text: "Magnitude variation"
                }
                SpinBox {
                    visible: emitter.acceleration.type === "AngleDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt
                    decimals: 2

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.acceleration.magnitudeVariation
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.acceleration.magnitudeVariation
                    }
                    onValueChanged:
                        emitter.acceleration.magnitudeVariation = value
                }

                PropertyNameLabel {
                    visible: emitter.acceleration.type === "PointDirection"
                    text: "X"
                }
                SpinBox {
                    visible: emitter.acceleration.type === "PointDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.acceleration.x
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.acceleration.x
                    }
                    onValueChanged:
                        emitter.acceleration.x = value
                }

                PropertyNameLabel {
                    visible: emitter.acceleration.type === "PointDirection"
                    text: "X variation"
                }
                SpinBox {
                    visible: emitter.acceleration.type === "PointDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.acceleration.xVariation
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.acceleration.xVariation
                    }
                    onValueChanged:
                        emitter.acceleration.xVariation = value
                }

                PropertyNameLabel {
                    visible: emitter.acceleration.type === "PointDirection"
                    text: "Y"
                }
                SpinBox {
                    visible: emitter.acceleration.type === "PointDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.acceleration.y
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.acceleration.y
                    }
                    onValueChanged:
                        emitter.acceleration.y = value
                }

                PropertyNameLabel {
                    visible: emitter.acceleration.type === "PointDirection"
                    text: "Y variation"
                }
                SpinBox {
                    visible: emitter.acceleration.type === "PointDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.acceleration.yVariation
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.acceleration.yVariation
                    }
                    onValueChanged:
                        emitter.acceleration.yVariation = value
                }

                PropertyNameLabel {
                    visible: emitter.acceleration.type === "TargetDirection"
                    text: "Magnitude"
                }
                SpinBox {
                    visible: emitter.acceleration.type === "TargetDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt
                    decimals: 2

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.acceleration.magnitude
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.acceleration.magnitude
                    }
                    onValueChanged:
                        emitter.acceleration.magnitude = value
                }

                PropertyNameLabel {
                    visible: emitter.acceleration.type === "TargetDirection"
                    text: "Magnitude variation"
                }
                SpinBox {
                    visible: emitter.acceleration.type === "TargetDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt
                    decimals: 2

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.acceleration.magnitudeVariation
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.acceleration.magnitudeVariation
                    }
                    onValueChanged:
                        emitter.acceleration.magnitudeVariation = value
                }

                PropertyNameLabel {
                    visible: emitter.acceleration.type === "TargetDirection"
                    text: "Proportional magnitude"
                }
                CheckBox {
                    visible: emitter.acceleration.type === "TargetDirection"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            checked = emitter.acceleration.proportionalMagnitude
                    }
                    onVisibleChanged: {
                        if (visible)
                            checked = emitter.acceleration.proportionalMagnitude
                    }
                    onCheckedChanged:
                        emitter.acceleration.proportionalMagnitude = checked
                }

                PropertyNameLabel {
                    visible: emitter.acceleration.type === "TargetDirection"
                    text: "Target x"
                }
                SpinBox {
                    visible: emitter.acceleration.type === "TargetDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt
                    decimals: 2

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.acceleration.targetX
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.acceleration.targetX
                    }
                    onValueChanged:
                        emitter.acceleration.targetX = value
                }

                PropertyNameLabel {
                    visible: emitter.acceleration.type === "TargetDirection"
                    text: "Target y"
                }
                SpinBox {
                    visible: emitter.acceleration.type === "TargetDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt
                    decimals: 2

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.acceleration.targetY
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.acceleration.targetY
                    }
                    onValueChanged:
                        emitter.acceleration.targetY = value
                }

                PropertyNameLabel {
                    visible: emitter.acceleration.type === "TargetDirection"
                    text: "Target variation"
                }
                SpinBox {
                    visible: emitter.acceleration.type === "TargetDirection"
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt
                    decimals: 2

                    Component.onCompleted: {
                        if (visible)
                            value = emitter.acceleration.targetVariation
                    }
                    onVisibleChanged: {
                        if (visible)
                            value = emitter.acceleration.targetVariation
                    }
                    onValueChanged:
                        emitter.acceleration.targetVariation = value
                }

                PropertyNameLabel {
                    text: "Shape"
                }
                ComboBox {
                    Layout.fillWidth: true
                    model: ["Ellipse", "Line", "Mask", "Rectangle"]
                    currentIndex:
                        switch (emitter.shape.type) {
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
                        var oldShape = emitter.shape

                        switch (index) {
                        case 0:
                            emitter.shape = scene.ellipseShapeComponent.createObject(emitter)
                            break
                        case 1:
                            emitter.shape = scene.lineShapeComponent.createObject(emitter)
                            break
                        case 2:
                            emitter.shape = scene.maskShapeComponent.createObject(emitter)
                            break
                        case 3:
                            emitter.shape = scene.rectangleShapeComponent.createObject(emitter)
                            break
                        }

                        oldShape.destroy()
                    }
                }

                PropertyNameLabel {
                    visible: emitter.shape.type === "EllipseShape"
                    text: "Fill"
                }
                CheckBox {
                    visible: emitter.shape.type === "EllipseShape"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            checked = emitter.shape.fill
                    }
                    onVisibleChanged: {
                        if (visible)
                            checked = emitter.shape.fill
                    }
                    onCheckedChanged:
                        emitter.shape.fill = checked
                }

                PropertyNameLabel {
                    visible: emitter.shape.type === "LineShape"
                    text: "Mirrored"
                }
                CheckBox {
                    visible: emitter.shape.type === "LineShape"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            checked = emitter.shape.mirrored
                    }
                    onVisibleChanged: {
                        if (visible)
                            checked = emitter.shape.mirrored
                    }
                    onCheckedChanged:
                        emitter.shape.mirrored = checked
                }

                PropertyNameLabel {
                    visible: emitter.shape.type === "MaskShape"
                    text: "Source"
                }
                ImageSelector {
                    visible: emitter.shape.type === "MaskShape"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            path = emitter.shape.source
                    }
                    onVisibleChanged: {
                        if (visible)
                            path = emitter.shape.source
                    }
                    onPathChanged:
                        emitter.shape.source = path
                }

                Item {
                    Layout.fillHeight: true
                }
            }
        }

    function toQML() {
        var genericProperties = ["objectName", "x", "y", "width", "height" ]
        var properties = ["enabled", "group", "emitRate", "maximumEmitted", "startTime", "lifeSpan", "lifeSpanVariation",
                          "size", "sizeVariation", "endSize", "velocityFromMovement", "system"]
        var objectProperties = ["velocity", "acceleration", "shape"]

        var data = "    " + peEmitter.type + " {"

        for (var i = 0; i < genericProperties.length; i++)
            data += "\n        %1: %2".arg(genericProperties[i]).arg(JSON.stringify(peEmitter[genericProperties[i]]))

        for (i = 0; i < properties.length; i++)
            if (properties[i] === "system")
                data += "\n        %1: %2".arg(properties[i]).arg(emitter.system.objectName)
            else
                data += "\n        %1: %2".arg(properties[i]).arg(JSON.stringify(emitter[properties[i]]))

        for (i = 0; i < objectProperties.length; i++) {
            data += "\n        %1:\n%2".arg(objectProperties[i]).arg(emitter[objectProperties[i]].toQML())
        }

        data += "\n    }"

        return data
    }
}
