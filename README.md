# GrootcamControl
UI to control the grootcam

Linux:

# download Qt compiler for linux 20.04
./dl-qt653.sh

# build application (specify path to qmake
QMAKE=${PWD}/build/Qt-6.5.3/bin/qmake ./build-linux.sh

# package application 
QT_PATH=${PWD}/build/Qt-6.5.3 ./package-linux.sh

#CMAKE_PREFIX_PATH=/home/fiym7331/Qt/6.5.3/gcc_64/ cmake -S . -B build
