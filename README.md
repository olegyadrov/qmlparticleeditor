QML Particle Editor
=========

![QMLParticleEditor](http://i.imgur.com/LD653Mc.png)

This tool allows you to easily create dynamic particle scenes and then translate them into QML code.

Designed to be used with QtQuick.Particles 2.0 module.

## HOW TO USE

1. Create image particles ("Particles" -> "Manage particles" -> "Create new" or "Edit")
2. Add emmiters to scene and set appropriate groups ("Particles" -> "New emitter")
3. Add affectors ("Particles" -> "New affector" -> Select affector from the list)
4. Export the code ("File" -> "Export QML code")

## LIMITATIONS

Below you can see the list of the features provided by QtQuick 2.4 and/or QtQuick.Particles 2.0 modules which are NOT supported by this tool:
* Multiple particle systems
* QML properties bindings
* TargetDirection: targetItem property
* ImageParticle: colorTable, sizeTable, sprites, spritesInterpolate, xVector, yVector proprties
* Group Goal component
* Sprite Goal component

## LICENSE

Copyright (C) 2013-2015 [Oleg Yadrov](https://linkedin.com/in/olegyadrov)

Distributed under the Apache Software License, Version 2.
