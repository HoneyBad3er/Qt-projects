#include "appcore.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    AppCore appCore;

    const QUrl url(QStringLiteral("qrc:/main.qml"));

    QQmlContext *context = engine.rootContext();    // Создаём корневой контекст
        /* Загружаем объект в контекст для установки соединения,
         * а также определяем имя, по которому будет происходить соединение
         * */
    context->setContextProperty("appCore", &appCore);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
