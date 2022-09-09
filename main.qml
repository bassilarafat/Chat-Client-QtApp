import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12


Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Client App")

    //connect to backend object server
    Connections{
        target: client
        //define a fun to connect to signal newNewMessage
        function onNewMessage(barr){
            listOfMessages.append({
                                      message:barr+""
                                  })
        }
    }

    ColumnLayout{
        anchors.fill: parent
        RowLayout{
            Layout.fillWidth: true
            TextField{
                Layout.fillWidth: true
                id:txtFieldIp
                placeholderText: "server Ip"
                //when press enter
                onAccepted:btnConnect.clicked()
            }
            TextField{
                Layout.fillWidth: true
                id:txtFieldPort
                placeholderText: "server port"
                //when press enter
                onAccepted:btnConnect.clicked()
            }
            Button{
                id:btnConnect
                text:"Connect"
                onClicked: {
                    client.connectToHost(txtFieldIp.text,txtFieldPort.text);
                }
            }
        }
        ListView{
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            model: ListModel{         //to view our messages from the client
                id:listOfMessages
                ListElement{
                    message :"here is my client ..welcome"
                }
            }
            //delegate to show our item in model
            delegate: ItemDelegate{
                text: message
            }
            ScrollBar.vertical: ScrollBar{}
        }
        RowLayout{
            Layout.fillWidth: true
            TextField{
                Layout.fillWidth: true
                id:txtFieldMessage
                placeholderText: "type your message to the client"
                //when press enter
                onAccepted:btnsendMessage.clicked()
            }
            Button{
                id:btnsendMessage
                text:"Send"
                onClicked: {
                    client.sendMessage(txtFieldMessage.text)
                    txtFieldMessage.clear()
                }
            }
        }
    }



}
