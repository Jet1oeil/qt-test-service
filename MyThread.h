#ifndef MYTHREAD_H
#define MYTHREAD_H

#include <QThread>
#include <QTimer>

class MyThread : public QThread 
{
    Q_OBJECT
public:
    MyThread(const QString& szName);

private slots:
    void onTimeOut();

public:
    void run();
};

#endif // MYTHREAD_H
