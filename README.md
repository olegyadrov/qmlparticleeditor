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

## KNOWN ISSUES

1. QtQuick.Particles 2.0 module contains many bugs, and some of them lead to the app crash (for example, it will happen if you delete a particle of a group that is currently on the scene by going into Manage Particles). So it's strongly recommended to read the "How to use" section first and use this tool in the way described there.
2. Because of bugs in Flickable and FileDialog in Qt 5.5.0, QML Particle Editor may work sluggish with this version. Use it with 5.4.2 or even 5.4.1 for better experience.

## LICENSE

Copyright (C) 2013-2015 [Oleg Yadrov](https://linkedin.com/in/olegyadrov)

Distributed under the Apache Software License, Version 2.
