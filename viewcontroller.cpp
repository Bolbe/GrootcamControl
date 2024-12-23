#include "viewcontroller.h"
#include "bridge.h"

ViewController::ViewController(Bridge* bridge, QObject *parent)
    : QObject{parent},
        _bridge(bridge)
{

}

void ViewController::postAngle(int angle) {
    _bridge->postAngle(angle);
}

void ViewController::requestAngle() {
    _bridge->requestAngle();
}

void ViewController::setCredentials(const QString &user, const QString &passwd) {
    _bridge->setCredentials(user, passwd);
    _bridge->requestAngle();
}

int ViewController::online() {
    return _bridge->online();
}

QString ViewController::user() {
    return _bridge->user();
}

QString ViewController::passwd() {
    return _bridge->passwd();
}
