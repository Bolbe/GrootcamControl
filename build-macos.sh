
# Check $QT_PATH environment variable
if [ -z "${QT_PATH}" ]; then
    echo "QT_PATH environment variable must be set to the Qt installation folder (eg: /path/to/Qt-6.5.3)."
    exit 1
fi

mkdir -p build && cd build
$QT_PATH/bin/qmake ..
make -j

$QT_PATH/bin/macdeployqt ./GrootcamControl.app -qmldir=$QT_PATH/qml
rm -rf GrootcamControl.app/Contents/Frameworks/QtConcurrent.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtLabsFolderListModel.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtLabsQmlModels.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQmlCore.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQmlLocalStorage.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQmlXmlListModel.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuick3D.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuick3DAssetImport.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuick3DAssetUtils.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuick3DEffects.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuick3DHelpers.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuick3DHelpersImpl.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuick3DParticleEffects.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuick3DParticles.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuick3DPhysics.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuick3DPhysicsHelpers.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuick3DRuntimeRender.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuick3DUtils.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuickDialogs2.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuickDialogs2QuickImpl.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuickDialogs2Utils.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuickEffects.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuickLayouts.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuickParticles.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuickShapes.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuickTest.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtQuickTimeline.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtShaderTools.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtSql.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtSvg.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtTest.framework
rm -rf GrootcamControl.app/Contents/Frameworks/QtWidgets.framework
rm -rf GrootcamControl.app/Contents/PlugIns/iconengines
rm -rf GrootcamControl.app/Contents/PlugIns/imageformats
rm -rf GrootcamControl.app/Contents/PlugIns/networkinformation
rm -rf GrootcamControl.app/Contents/PlugIns/sqldrivers
rm -rf GrootcamControl.app/Contents/PlugIns/styles
rm -rf GrootcamControl.app/Contents/PlugIns/tls
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libeffectsplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/liblabsmodelsplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libmodelsplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libparticlesplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqmlfolderlistmodelplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqmllocalstorageplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqmlmetaplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqmlplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqmlshapesplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqmlxmllistmodelplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqquick3dphysicsplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqquick3dplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqquicklayoutsplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqtqmlcoreplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqtquick3dassetutilsplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqtquick3deffectplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqtquick3dhelpersimplplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqtquick3dhelpersplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqtquick3dparticleeffectsplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqtquick3dparticles3dplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqtquick3dphysicshelpersplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqtquickcontrols2imaginestyleimplplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqtquickcontrols2imaginestyleplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqtquickcontrols2iosstyleimplplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqtquickcontrols2iosstyleplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqtquickcontrols2nativestyleplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqtquickcontrols2universalstyleimplplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqtquickcontrols2universalstyleplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqtquickdialogs2quickimplplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqtquickdialogsplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libqtquicktimelineplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libquicktestplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libquicktoolingplugin.dylib
rm -rf GrootcamControl.app/Contents/PlugIns/quick/libquickwindowplugin.dylib
rm -rf GrootcamControl.app/Contents/Resources/qml/Qt
rm -rf GrootcamControl.app/Contents/Resources/qml/QtCore
rm -rf GrootcamControl.app/Contents/Resources/qml/QtQuick3D
rm -rf GrootcamControl.app/Contents/Resources/qml/QtTest
rm -rf GrootcamControl.app/Contents/Resources/qml/QtQml/Base
rm -rf GrootcamControl.app/Contents/Resources/qml/QtQml/Models
rm -rf GrootcamControl.app/Contents/Resources/qml/QtQml/XmlListModel
rm -rf GrootcamControl.app/Contents/Resources/qml/QtQuick/Dialogs
rm -rf GrootcamControl.app/Contents/Resources/qml/QtQuick/Effects
rm -rf GrootcamControl.app/Contents/Resources/qml/QtQuick/Layouts
rm -rf GrootcamControl.app/Contents/Resources/qml/QtQuick/LocalStorage
rm -rf GrootcamControl.app/Contents/Resources/qml/QtQuick/NativeStyle
rm -rf GrootcamControl.app/Contents/Resources/qml/QtQuick/Particles
rm -rf GrootcamControl.app/Contents/Resources/qml/QtQuick/Shapes
rm -rf GrootcamControl.app/Contents/Resources/qml/QtQuick/Timeline
rm -rf GrootcamControl.app/Contents/Resources/qml/QtQuick/Window
rm -rf GrootcamControl.app/Contents/Resources/qml/QtQuick/tooling
rm -rf GrootcamControl.app/Contents/Resources/qml/QtQuick/Controls/Imagine
rm -rf GrootcamControl.app/Contents/Resources/qml/QtQuick/Controls/Universal
rm -rf GrootcamControl.app/Contents/Resources/qml/QtQuick/Controls/designer
rm -rf GrootcamControl.app/Contents/Resources/qml/QtQuick/Controls/iOS
rm -rf GrootcamControl.app/Contents/Resources/qml/QtQuick/Controls/impl

ditto -c -k --sequesterRsrc --keepParent GrootcamControl.app GrootcamControl.app.zip
mv GrootcamControl.app.zip ..
cd ..
