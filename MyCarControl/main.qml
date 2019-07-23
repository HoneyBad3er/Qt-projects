import QtQuick 2.7
import QtQuick.Window 2.7
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

Window {
    visible: true
    width: 720
    height: 1280
    title: qsTr("MyCarControl")


    Connections{
        target: appCore;

        onClearCarList: {
            listModel.clear();
        }

        onConnectedToCar: {
            search_layout.visible = false;
            control_layout.visible = true;
        }

        onAddCarToList: {
            listModel.append({itemName: appCore.addCarToList_(appCore.getCarAdress())});
        }


    }
    Rectangle{
        id: screensaver
        anchors.fill: parent
        visible: true
        color: "black"
        Image{
            anchors.fill: parent
            source:"screen_saver.jpg"

        }
        Timer{
            running: true
            id: timer
            interval: 2000
            onTriggered: {
                screensaver.visible = false
                search_layout.visible = true
            }
        }

    }

    Rectangle{
        id: search_layout
        width: parent.width
        height: parent.height
        visible: false
        color: "black"

        ListView {
            id: listView
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: findButton.top
            anchors.margins: 5
            z: 1
            delegate: Item{
                    id: item
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 80

                    Button{
                        anchors.fill: parent
                        anchors.margins: 4

                        text: itemName

                        background: Rectangle{
                            color: findButton.pressed ? "#868482" : "#d7d6d5"
                        }

                        onClicked: appCore.on_ItemClicked(itemName)

                    }
                }

                // Модель для представления данных в ListView
                model: ListModel {
                    id: listModel
                }

        }

        Button{
            id: findButton
            anchors.bottom: parent.bottom
            height: parent.height/12
            anchors.left: parent.left
            anchors.right: parent.right

            background: Rectangle{
                color: findButton.pressed ? "#868482" : "#d7d6d5"
            }
            text: "Поиск"

            onClicked: appCore.on_findBtn_clicked();

        }


    }


    Rectangle{
        id: control_layout
        width: parent.width
        height: parent.height
        visible: false
        color: "black"

        Rectangle{
            id: pictureBox
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height/3

            Image{
                anchors.fill: parent
                source:"shestyorka.jpg"

            }
        }

        Rectangle{
            anchors.top: pictureBox.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            color: "black"
            scale: 0.9
        GridLayout{
            id: gridlayout
            anchors.fill: parent
            anchors.centerIn: parent
            columns: 2
            rows: 4
            columnSpacing: 20
            rowSpacing: 20

            Button{
                Layout.fillWidth: true
                Layout.fillHeight: true
                id:lockBtn
                state: "LOCK"

                background: Rectangle{
                    anchors.fill: parent
                    id: lockBtnBack
                    color: "black"
                    border.color: "white"
                    border.width: 5
                    state: "LOCK"
                    Text {
                        anchors.fill: parent
                        anchors.centerIn: parent
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Helvetica"
                        font.pointSize: 18
                        id: lockBtnText
                        state: "LOCK"
                        font.bold: true
                        color: "white"
                    }
                }

                states:[
                    State {
                        name: "LOCK"
                        PropertyChanges {
                            target: lockBtnText;
                            text: "Открыть"

                        }
                    },
                    State {
                        name: "UNLOCK"
                        PropertyChanges {
                            target: lockBtnText;
                            text: "Закрыть"

                        }
                    }
                ]

                onClicked: if (lockBtn.state == "LOCK"){
                            lockBtn.state = "UNLOCK";
                            appCore.on_unlockBtn_clicked();
                           }
                      else{
                           lockBtn.state = "LOCK"
                               appCore.on_lockBtn_clicked();
                           }
                //onClicked: lockBtn.state == "LOCK"? lockBtn.state = "UNLOCK" : lockBtn.state = "LOCK";
                onPressed: lockBtnBack.color = "#5d5b59"
                onReleased: lockBtnBack.color = "black"
            }

            Button{
                id: mainLightBtn

                Layout.fillWidth: true
                Layout.fillHeight: true
                state: "OFF"

                background: Rectangle{
                    anchors.fill: parent
                    id: mainLightBtnBack
                    border.color: "white"
                    border.width: 5
                    state: "OFF"
                    Text {

                        anchors.fill: parent
                        anchors.centerIn: parent
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Helvetica"
                        font.pointSize: 18
                        id: mainLightBtnText
                        state: "OFF"
                        font.bold: true
                        color: "white"
                        text: "Габариты"
                    }
                }

                states:[
                    State {
                        name: "OFF"
                        PropertyChanges {
                            target: mainLightBtnBack;
                            color: "black"

                        }
                    },
                    State {
                        name: "ON"
                        PropertyChanges {
                            target: mainLightBtnBack;
                            color: "#5d5b59"

                        }
                    }
                ]

                onClicked: if (mainLightBtn.state == "OFF"){
                           mainLightBtn.state = "ON";
                           appCore.on_lights_on_Btn_clicked();
                      }
                      else{
                        mainLightBtn.state = "OFF";
                        appCore.on_lights_off_Btn_clicked();
                      }
                //onClicked: mainLightBtn.state == "OFF"? mainLightBtn.state = "ON" : mainLightBtn.state = "OFF";
                onPressed: mainLightBtnBack.color = "#5d5b59"
                onReleased: mainLightBtnBack.color = "black"
            }

            Button{
                Layout.fillWidth: true
                Layout.fillHeight: true
                id: nearLightBtn
                state: "OFF"

                background: Rectangle{
                    id: nearLightBtnBack
                    anchors.fill: parent
                    color: "black"
                    border.color: "white"
                    border.width: 5
                    state: "OFF"
                    Text {
                        anchors.centerIn: parent
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Helvetica"
                        font.pointSize: 18
                        id: nearLightBtnText
                        state: "OFF"
                        font.bold: true
                        color: "white"
                        text: "Ближний свет"
                    }
                }

                states:[
                    State {
                        name: "OFF"
                        PropertyChanges {
                            target: nearLightBtnBack;
                            color: "black"

                        }
                    },
                    State {
                        name: "ON"
                        PropertyChanges {
                            target: nearLightBtnBack;
                            color: "#5d5b59"

                        }
                    }
                ]

                onClicked: if (nearLightBtn.state == "OFF"){
                           nearLightBtn.state = "ON";
                           appCore.on_near_lights_on_Btn_clicked();
                      }
                      else{
                        nearLightBtn.state = "OFF";
                        appCore.on_near_lights_off_Btn_clicked();
                      }

                //onClicked: nearLightBtn.state == "OFF"? nearLightBtn.state = "ON" : nearLightBtn.state = "OFF";
                onPressed: nearLightBtnBack.color = "#5d5b59"
                onReleased: nearLightBtnBack.color = "black"
            }

            Button{
                Layout.fillWidth: true
                Layout.fillHeight: true
                id: longLightBtn
                state: "OFF"

                background: Rectangle{
                    id: longLightBtnBack
                    anchors.fill: parent
                    color: "black"
                    border.color: "white"
                    border.width: 5
                    state: "OFF"
                    Text {
                        anchors.centerIn: parent
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Helvetica"
                        font.pointSize: 18
                        id: longLightBtnText
                        state: "OFF"
                        font.bold: true
                        text: "Дальний свет"
                        color: "white"
                    }
                }

                states:[
                    State {
                        name: "OFF"
                        PropertyChanges {
                            target: longLightBtnBack;
                            color: "black"

                        }
                    },
                    State {
                        name: "ON"
                        PropertyChanges {
                            target: longLightBtnBack;
                            color:"#5d5b59"

                        }
                    }
                ]

                onClicked: if (longLightBtn.state == "OFF"){
                           longLightBtn.state = "ON";
                           appCore.on_long_lights_on_Btn_clicked();
                      }
                      else{
                        longLightBtn.state = "OFF";
                        appCore.on_long_lights_off_Btn_clicked();
                      }

                //onClicked: longLightBtn.state == "OFF"? longLightBtn.state = "ON" : longLightBtn.state = "OFF";
                onPressed: longLightBtnBack.color = "#5d5b59"
                onReleased: longLightBtnBack.color = "black"
            }

            Button{
                Layout.fillWidth: true
                Layout.fillHeight: true
                id: turnLightBtn
                state: "OFF"

                background: Rectangle{
                    id: turnLightBtnBack
                    anchors.fill: parent
                    color: "black"
                    border.color: "white"
                    border.width: 5
                    state: "OFF"
                    Text {
                        anchors.centerIn: parent
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Helvetica"
                        font.pointSize: 18
                        id: turnLightBtnText
                        state: "OFF"
                        font.bold: true
                        color: "white"
                        text: "Поворотники"
                    }

                }

                states:[
                    State {
                        name: "OFF"
                        PropertyChanges {
                            target: turnLightBtnBack;
                            color: "black"

                        }
                    },
                    State {
                        name: "ON"
                        PropertyChanges {
                            target: turnLightBtnBack;
                            color: "#5d5b59"

                        }
                    }
                ]

                onClicked: if (turnLightBtn.state == "OFF"){
                           turnLightBtn.state = "ON";
                           appCore.on_turns_on_Btn_clicked();
                      }
                      else{
                        turnLightBtn.state = "OFF";
                        appCore.on_turns_off_Btn_clicked();
                      }


                //onClicked: turnLightBtn.state == "OFF"? turnLightBtn.state = "ON" : turnLightBtn.state = "OFF";
                onPressed: turnLightBtnBack.color = "#5d5b59"
                onReleased: turnLightBtnBack.color = "black"
            }

            Button{
                Layout.fillWidth: true
                Layout.fillHeight: true
                id: soundSignalBtn


                background: Rectangle{
                    id: soundSignalBtnBack
                    anchors.fill: parent
                    color: "black"
                    border.color: "white"
                    border.width: 5

                    Text {
                        anchors.centerIn: parent
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Helvetica"
                        font.pointSize: 18
                        id: soundSignalBtnText
                        text: "Сигнал"
                        font.bold: true
                        color: "white"
                    }
                }



                onClicked: {appCore.on_soundBtn_clicked();}
                onPressed: soundSignalBtnBack.color = "#5d5b59"
                onReleased: soundSignalBtnBack.color = "black"
            }

            Button{
                Layout.fillWidth: true
                Layout.fillHeight: true
                id: helloBtn

                background: Rectangle{
                    id: helloBtnBack
                    anchors.fill: parent
                    color: "black"
                    border.color: "white"
                    border.width: 5
                    Text {
                        anchors.centerIn: parent
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Helvetica"
                        font.pointSize: 18
                        id: helloBtnText
                        font.bold: true
                        text: "Приветствие"
                        color: "white"
                    }
                }

                onClicked: {appCore.on_helloBtn_clicked();}
                onPressed: helloBtnBack.color = "#5d5b59"
                onReleased: helloBtnBack.color = "black"
            }

            Button{
                Layout.fillWidth: true
                Layout.fillHeight: true
                id: byeByeBtn

                background: Rectangle{
                    id: byeByeBtnBack
                    anchors.fill: parent
                    color: "black"
                    border.color: "white"
                    border.width: 5
                    Text {
                        anchors.centerIn: parent
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Helvetica"
                        font.pointSize: 18
                        id: byeByeBtnText
                        font.bold: true
                        text: "Спасибо"
                        color: "white"
                    }
                }

                onClicked: {appCore.on_byeBtn_clicked();}
                onPressed: byeByeBtnBack.color = "#5d5b59"
                onReleased: byeByeBtnBack.color = "black"
            }

        }

        }
    }
}
