TARGET = GrootcamControl
TEMPLATE = app

QT += network qml quick
CONFIG += c++11

unix:!macx {
    QMAKE_LFLAGS += -no-pie
}

SOURCES += \
        bridge.cpp \
        main.cpp \
        viewcontroller.cpp

resources.files = \
    main.qml \
    default.ini

resources.prefix = /
RESOURCES += resources

RC_FILE = grootcam.rc
ICON = grootcam.icns

HEADERS += \
    bridge.h \
    viewcontroller.h

