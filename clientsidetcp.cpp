#include "clientsidetcp.h"

ClientSideTcp::ClientSideTcp(QObject *parent)
    : QObject{parent}
{
    //when connected signal
    connect(&MyClient ,&QTcpSocket::connected ,this,&ClientSideTcp::onConnect);
    //when error
    connect(&MyClient ,&QTcpSocket::errorOccurred ,this,&ClientSideTcp::onErrorOccurred);

    //when rx data from server
    connect(&MyClient,&QTcpSocket::readyRead ,this,&ClientSideTcp::onRead);

}

void ClientSideTcp::connectToHost(const QString &ip, const QString &port)
{

    MyClient.connectToHost(ip,port.toUInt());
}

void ClientSideTcp::sendMessage(const QString &message)
{
    MyClient.write(message.toUtf8());
}

void ClientSideTcp::onConnect()
{
    qInfo()<<"connected to host";
}

void ClientSideTcp::onRead()
{
    const auto message =MyClient.readAll();

    //emite a signal for new message
    emit newMessage(message);
}

void ClientSideTcp::onErrorOccurred(QAbstractSocket::SocketError error)
{
   qWarning() <<"Error : "<<error ;
}
