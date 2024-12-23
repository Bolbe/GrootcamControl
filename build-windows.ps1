if (-not [Environment]::GetEnvironmentVariable('Qt_path')) {
    "Environement variable Qt_path does not exist. It must be set to /path/to/QtMingw64  (folder containing bin/qmake.exe)"
    Exit 1
}

if (-not [Environment]::GetEnvironmentVariable('Mingw_path')) {
    "Environement variable Mingw_path does not exist. It must be set to /path/to/mingw64 (folder containing bin/mingw32-make.exe)"
    Exit 1
}

$env:Path = "$env:Qt_path\bin;$env:Mingw_path\bin"
$archive = "grootcamcontrol"
$exe = "GrootcamControl.exe"

mkdir -Force build
cd build
qmake ..
mingw32-make -j
mkdir $archive
cp ./release/$exe ./$archive
cp $env:Qt_path/bin/libgcc_s_seh-1.dll ./$archive
cp $env:Qt_path/bin/libstdc++-6.dll ./$archive
cp $env:Qt_path/bin/libwinpthread-1.dll ./$archive
cp $env:Qt_path/bin/Qt6Core.dll ./$archive
cp $env:Qt_path/bin/Qt6Gui.dll ./$archive
cp $env:Qt_path/bin/Qt6Network.dll ./$archive
cp $env:Qt_path/bin/Qt6OpenGL.dll ./$archive
cp $env:Qt_path/bin/Qt6Qml.dll ./$archive
cp $env:Qt_path/bin/Qt6QmlCore.dll ./$archive
cp $env:Qt_path/bin/Qt6QmlModels.dll ./$archive
cp $env:Qt_path/bin/Qt6QmlWorkerScript.dll ./$archive
cp $env:Qt_path/bin/Qt6Quick.dll ./$archive
cp $env:Qt_path/bin/Qt6QuickControls2.dll ./$archive
cp $env:Qt_path/bin/Qt6QuickControls2Impl.dll ./$archive
cp $env:Qt_path/bin/Qt6QuickTemplates2.dll ./$archive
mkdir ./$archive/plugins/platforms
cp $env:Qt_path/plugins/platforms/qwindows.dll ./$archive/plugins/platforms
mkdir ./$archive/qml
cp $env:Qt_path/qml/builtins.qmltypes ./$archive/qml
cp $env:Qt_path/qml/jsroot.qmltypes ./$archive/qml
cp -R $env:Qt_path/qml/QtQml ./$archive/qml
rm -R ./$archive/qml/QtQml/XmlListModel
rm -R ./$archive/qml/QtQml/Models
rm -R ./$archive/qml/QtQml/Base
cp -R $env:Qt_path/qml/QtQuick ./$archive/qml
rm -R ./$archive/qml/QtQuick/Dialogs
rm -R ./$archive/qml/QtQuick/Effects
rm -R ./$archive/qml/QtQuick/Layouts
rm -R ./$archive/qml/QtQuick/LocalStorage
rm -R ./$archive/qml/QtQuick/NativeStyle
rm -R ./$archive/qml/QtQuick/Particles
rm -R ./$archive/qml/QtQuick/Shapes
rm -R ./$archive/qml/QtQuick/tooling
rm -R ./$archive/qml/QtQuick/Window
New-Item ./$archive/qt.conf
Compress-Archive -Path ./$archive -DestinationPath ./grootcamcontrol.zip
cd ..
mv ./build/grootcamcontrol.zip .


