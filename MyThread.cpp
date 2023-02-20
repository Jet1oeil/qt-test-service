
#include "MyThread.h"

MyThread::MyThread(const QString& szName) {
    moveToThread(this);
	setObjectName(szName);
}    

void MyThread::onTimeOut()
{
    qDebug("Timeout");
}

void MyThread::run()
{
    qDebug("Starting the thread");
    
    QTimer timer;
    timer.start();
    timer.setInterval(1000);

    connect(&timer, SIGNAL(timeout()), this, SLOT(onTimeOut()));
    
    exec();
    
    qDebug("Stopping the thread");
}
