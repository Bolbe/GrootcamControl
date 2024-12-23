#include "bridge.h"
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QSettings>
#include <QAuthenticator>
#include <QDateTime>

Bridge::Bridge(QObject *parent)
    : QObject{parent},
        _networkManager(new QNetworkAccessManager(this)),
        _online(-1)
{
    QSettings defaultSettings(QStringLiteral(":/default.ini"), QSettings::IniFormat);
    _postAngleUrl = defaultSettings.value("postangleurl").toString();
    _getAngleUrl = defaultSettings.value("getangleurl").toString();

    QSettings settings("grootcam");
    _user = settings.value("user", defaultSettings.value("user").toString()).toString();
    _passwd = settings.value("passwd", defaultSettings.value("passwd").toString()).toString();

    QObject::connect(_networkManager, &QNetworkAccessManager::authenticationRequired,
                     this, &Bridge::processAuthenticationRequest);
}

void Bridge::setCredentials(const QString& user, const QString& passwd) {

    qDebug() << "Setting credentials with " << user << ":" << passwd;
    _user = user;
    _passwd = passwd;
    QSettings settings("grootcam");
    settings.setValue("user", _user);
    settings.setValue("passwd", _passwd);
}

void Bridge::requestAngle() {
    QNetworkRequest request(_getAngleUrl);
    QNetworkReply* reply = _networkManager->get(request);
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        processAngleReply(reply);
    });
    emit log("Angle requested...");
}

void Bridge::processAngleReply(QNetworkReply *reply) {
    int returnCode = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    emit log(QString("Response code for angle request: %1").arg(returnCode));
    QString body = reply->readAll();
    if (returnCode==200) {
        // body is of the form: angle|datetime (angle is int, datetime is string, like: 50|2023-12-03 10:20:32)
        QStringList tab = body.split('|');

        int setpoint = tab.at(0).toInt();
        emit angle(setpoint);

        _online = -1;
        if (tab.length()>1) {
            QDateTime timestamp = QDateTime::fromString(tab.at(1), Qt::ISODate);
            // check if more than 55 sec
            _online = timestamp.secsTo(QDateTime::currentDateTime())>55 ? 0 : 1;
        }
        emit onlineUpdate(_online);

    }
    else {
        emit log(QString("Content:%1").arg(body));
    }
    reply->deleteLater();
}

void Bridge::processAuthenticationRequest(QNetworkReply*, QAuthenticator* authenticator) {
    authenticator->setUser(_user);
    authenticator->setPassword(_passwd);
}

void Bridge::postAngle(int angle) {
    QString postData;
    QNetworkRequest request(_postAngleUrl);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");
    postData.append(QString("angle=%1").arg(angle));
    QNetworkReply* reply = _networkManager->post(request, postData.toLocal8Bit());
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        processPostAngleReply(reply);
    });
    emit log(QString("Angle %1 posted...").arg(angle));
}

void Bridge::processPostAngleReply(QNetworkReply *reply) {

    int returnCode = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    emit log(QString("Response code: %1").arg(returnCode));
    if (returnCode!=200) {
        emit log(QString(reply->readAll()));
    }
    reply->deleteLater();
}
