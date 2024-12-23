#ifndef VIEWCONTROLLER_H
#define VIEWCONTROLLER_H

#include <QObject>

class Bridge;

class ViewController : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int online READ online NOTIFY onlineChanged)
    Q_PROPERTY(QString user READ user CONSTANT)
    Q_PROPERTY(QString passwd READ passwd CONSTANT)

public:
    explicit ViewController(Bridge* bridge, QObject *parent = nullptr);
    int online();
    QString user();
    QString passwd();

signals:
    void log(QString logString);
    void angleInit(int angle);
    void onlineChanged(int);

public slots:
    void postAngle(int angle);
    void requestAngle();
    void setCredentials(const QString& user, const QString& passwd);

private:

    Bridge* _bridge;

};

#endif // VIEWCONTROLLER_H

