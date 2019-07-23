#include "appcore.h"
#include <iostream>

AppCore::AppCore(QObject *parent): QObject(parent)
{
    connect(agent, SIGNAL(deviceDiscovered(QBluetoothDeviceInfo)),
                this, SLOT(deviceDiscovered(QBluetoothDeviceInfo)));
    agent->start();

    socket = new QBluetoothSocket(QBluetoothServiceInfo::RfcommProtocol);
}


void AppCore::on_findBtn_clicked()
{
    emit clearCarList();
    agent->stop();
    agent->start();
}

void AppCore::deviceDiscovered(const QBluetoothDeviceInfo &device)
{
// Add new car to QML ListView
    carName = device.name();
    AdressByName[carName] = device.address().toString();
    emit addCarToList();

}


void AppCore::on_ItemClicked(QString name){

    static const QString serviceUuid(QStringLiteral("00001101-0000-1000-8000-00805F9B34FB"));
    socket->connectToService(QBluetoothAddress(AdressByName.at(name)), QBluetoothUuid(serviceUuid), QIODevice::ReadWrite);
    emit connectedToCar();

}

QString AppCore::addCarToList_(QString carName){
    return carName;
}


QString AppCore::getCarAdress(){
    return this->carName;
}

void AppCore::on_turns_on_Btn_clicked()
{
    socket->write("10");
}

void AppCore::on_turns_off_Btn_clicked()
{
    socket->write("11");
}

void AppCore::on_lights_on_Btn_clicked()
{
    socket->write("3");
}

void AppCore::on_lights_off_Btn_clicked()
{
    socket->write("4");
}

void AppCore::on_near_lights_on_Btn_clicked()
{
    socket->write("5");
}

void AppCore::on_near_lights_off_Btn_clicked()
{
    socket->write("6");
}

void AppCore::on_long_lights_on_Btn_clicked()
{
    socket->write("7");
}

void AppCore::on_long_lights_off_Btn_clicked()
{
    socket->write("8");
}

void AppCore::on_soundBtn_clicked()
{
    socket->write("9");
}

void AppCore::on_helloBtn_clicked()
{
    socket->write("12");
}

void AppCore::on_byeBtn_clicked()
{
    socket->write("13");
}

void AppCore::on_unlockBtn_clicked()
{
    socket->write("1");
}

void AppCore::on_lockBtn_clicked()
{
    socket->write("2");
}
