#!/bin/bash

# Check $QT_PATH environment variable
if [ -z "${QT_PATH}" ]; then
    echo "QT_PATH environment variable must be set to the Qt installation folder (eg: /path/to/Qt-6.5.3)."
    exit 1
fi

mkdir -p build && cd build
$QT_PATH/bin/qmake .. && make -j

echo "Creating package folder..."
mkdir -p package
cp ./GrootcamControl package/GrootcamControl

echo "Copying shared libraries to lib folder..."
mkdir -p package/lib
cp $QT_PATH/lib/libQt6Core.so.6.5.3 package/lib/libQt6Core.so.6
cp $QT_PATH/lib/libQt6Gui.so.6.5.3 package/lib/libQt6Gui.so.6
cp $QT_PATH/lib/libQt6Network.so.6.5.3 package/lib/libQt6Network.so.6
cp $QT_PATH/lib/libQt6OpenGL.so.6.5.3 package/lib/libQt6OpenGL.so.6
cp $QT_PATH/lib/libQt6Qml.so.6.5.3 package/lib/libQt6Qml.so.6
cp $QT_PATH/lib/libQt6QmlModels.so.6.5.3 package/lib/libQt6QmlModels.so.6
cp $QT_PATH/lib/libQt6QmlWorkerScript.so.6.5.3 package/lib/libQt6QmlWorkerScript.so.6
cp $QT_PATH/lib/libQt6Quick.so.6.5.3 package/lib/libQt6Quick.so.6
cp $QT_PATH/lib/libQt6QuickControls2.so.6.5.3 package/lib/libQt6QuickControls2.so.6
cp $QT_PATH/lib/libQt6QuickControls2Impl.so.6.5.3 package/lib/libQt6QuickControls2Impl.so.6
cp $QT_PATH/lib/libQt6QuickTemplates2.so.6.5.3 package/lib/libQt6QuickTemplates2.so.6
cp $QT_PATH/lib/libQt6XcbQpa.so.6.5.3 package/lib/libQt6XcbQpa.so.6

echo "Copying plugins libraries to plugins folder..."
mkdir -p package/plugins/platforms
cp $QT_PATH/plugins/platforms/libqxcb.so package/plugins/platforms
mkdir -p package/plugins/xcbglintegrations
cp $QT_PATH/plugins/xcbglintegrations/libqxcb-egl-integration.so package/plugins/xcbglintegrations

echo "Copying qml files to qml folder..."
mkdir -p package/qml/QtQml
cp -r $QT_PATH/qml/QtQml/WorkerScript package/qml/QtQml
cp $QT_PATH/qml/QtQml/libqmlmetaplugin.so package/qml/QtQml
mkdir -p package/qml/QtQuick
cp -r $QT_PATH/qml/QtQuick/Controls package/qml/QtQuick
rm -r package/qml/QtQuick/Controls/designer
rm -r package/qml/QtQuick/Controls/Imagine
rm -r package/qml/QtQuick/Controls/Universal
cp -r $QT_PATH/qml/QtQuick/Templates package/qml/QtQuick
cp $QT_PATH/qml/QtQuick/libqtquick2plugin.so package/qml/QtQuick
cp $QT_PATH/qml/QtQuick/plugins.qmltypes package/qml/QtQuick
cp $QT_PATH/qml/QtQuick/qmldir package/qml/QtQuick

find package -name "*.debug" -type f -delete

echo "Changing runtime path to ./lib"
chrpath -r ./lib/ package/GrootcamControl

mv package Grootcam
echo "Compressing folder to GrootcamControl.tar.xz"
XZ_OPT='-9' tar -cJf Grootcam.tar.xz Grootcam
mv Grootcam.tar.xz ..

cd ..

