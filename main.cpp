#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <control/system.h>
#include <control/hvachandler.h>
#include <control/audiocontroller.h>

int main(int argc, char *argv[])
{
    if (qEnvironmentVariableIsEmpty("QTGLESSTREAM_DISPLAY")) {
        qputenv("QT_QPA_EGLFS_PHYSICAL_WIDTH", QByteArray("213"));
        qputenv("QT_QPA_EGLFS_PHYSICAL_HEIGHT", QByteArray("120"));

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
        QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    }
    QGuiApplication app(argc, argv);

    System m_system_handler;
    HVACHandler m_driverHVACHandler;
    HVACHandler m_passengerHVACHandler;
    AudioController m_audioController;

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    QQmlContext *context (engine.rootContext());

    context->setContextProperty( "systemHandler" , &m_system_handler);
    context->setContextProperty( "driverHVAC" , &m_driverHVACHandler);
    context->setContextProperty( "passengerHVAC" , &m_passengerHVACHandler);
    context->setContextProperty( "audioController" , &m_audioController);



    return app.exec();
}
