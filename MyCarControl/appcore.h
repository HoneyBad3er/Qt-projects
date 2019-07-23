#ifndef APPCORE_H
#define APPCORE_H
#include <QObject>
#include <map>
#include <QBluetoothDeviceDiscoveryAgent>
#include <QBluetoothSocket>

class AppCore: public QObject
{

    Q_OBJECT

public:
    explicit AppCore(QObject *parent = nullptr);


signals:
    // Сигнал для передачи данных в qml-интерфейс
    void connectedToCar();

    void clearCarList();

    void addCarToList();

public slots:
    void on_findBtn_clicked();

    void deviceDiscovered(const QBluetoothDeviceInfo &device);

    void on_ItemClicked(QString adress);

    QString addCarToList_(QString carName);

    QString getCarAdress();

    void on_turns_on_Btn_clicked();

    void on_turns_off_Btn_clicked();

    void on_lights_on_Btn_clicked();

    void on_lights_off_Btn_clicked();

    void on_near_lights_on_Btn_clicked();

    void on_near_lights_off_Btn_clicked();

    void on_long_lights_on_Btn_clicked();

    void on_long_lights_off_Btn_clicked();

    void on_soundBtn_clicked();

    void on_helloBtn_clicked();

    void on_byeBtn_clicked();

    void on_unlockBtn_clicked();

    void on_lockBtn_clicked();

private:
    QBluetoothSocket* socket;

    QBluetoothDeviceDiscoveryAgent* agent = new QBluetoothDeviceDiscoveryAgent;

    QString string;

    QString carName;

    std::map<QString, QString> AdressByName;

    bool k = false;



};

#endif // APPCORE_H
