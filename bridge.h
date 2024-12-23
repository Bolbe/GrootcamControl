#ifndef BRIDGE_H
#define BRIDGE_H

#include <QObject>

class QNetworkAccessManager;
class QNetworkReply;
class QAuthenticator;

class Bridge : public QObject
{
    Q_OBJECT
public:
    explicit Bridge(QObject *parent = nullptr);

    void setCredentials(const QString& user, const QString& passwd);
    void requestAngle();
    void postAngle(int angle);
    int online() { return _online; }   // -1: don't know, 0: offline, 1: online
    QString user() { return _user; }
    QString passwd() { return _passwd; }

signals:
    void log(QString logString);
    void angle(int value);
    void onlineUpdate(int value);

private slots:
    void processAuthenticationRequest(QNetworkReply*, QAuthenticator* authenticator);

private:

    QNetworkAccessManager* _networkManager;
    QString _user;
    QString _passwd;
    int _online;
    QString _postAngleUrl;
    QString _getAngleUrl;

    void processPostAngleReply(QNetworkReply* reply); // responsible for deleteLater()
    void processAngleReply(QNetworkReply* reply);

};

#endif // BRIDGE_H
