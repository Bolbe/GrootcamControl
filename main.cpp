#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "viewcontroller.h"
#include <QQmlContext>
#include "bridge.h"
#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Bridge bridge;
    ViewController viewController(&bridge);

    QObject::connect(&bridge, &Bridge::log, &viewController, &ViewController::log);
    QObject::connect(&bridge, &Bridge::angle, &viewController, &ViewController::angleInit);
    QObject::connect(&bridge, &Bridge::onlineUpdate, &viewController, &ViewController::onlineChanged);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("viewcontroller", &viewController);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    // If built with CMakeList, the URL is
    //const QUrl url(QStringLiteral("qrc:/qt/qml/grootcamcontrol/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
