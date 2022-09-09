#ifndef CLIENTSIDETCP_H
#define CLIENTSIDETCP_H

#include <QObject>
#include <QTcpSocket>

class ClientSideTcp : public QObject
{
    Q_OBJECT
public:
    explicit ClientSideTcp(QObject *parent = nullptr);

signals:
     void newMessage(const QByteArray &barr);

public  slots:
    void connectToHost(const QString &ip , const QString &port);
    void sendMessage(const QString &message);

private slots:
    void onConnect();
    void onRead();
    void onErrorOccurred(QAbstractSocket::SocketError error);

private:
    QTcpSocket MyClient;


};

#endif // CLIENTSIDETCP_H
