#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <signal.h>

#include <QCoreApplication>
#include <QFile>

#include "MyThread.h"

QString getLogFilePath()
{
	return QCoreApplication::applicationDirPath() + "/app.log";
}

void logger(QtMsgType type, const QMessageLogContext& context, const QString& msg)
{
	// Write in file
	QString szFilePath = getLogFilePath();
	QFile fileLog(szFilePath);
	if(fileLog.open(QFile::WriteOnly | QFile::Append | QFile::Text)){
		QByteArray buf = msg.toUtf8();
		fileLog.write(buf.constData(), buf.size());
		fileLog.write("\n");
		fileLog.close();
	}

	// Write in console
	QByteArray localMsg = msg.toLocal8Bit();
	fprintf(stderr, "%s\n", localMsg.constData());

}

void sig_term(int sig)
{
	qDebug("[Main] Received signal: %d", sig);
	QCoreApplication::quit();
}

void applicationStart(int argc, char *argv[])
{
	bool bRes;

	// Install signal for stop
	bRes = (signal(SIGTERM, sig_term) != SIG_ERR);

	// Initialize the QT application
	if(bRes){
		QCoreApplication app(argc, argv);

        // Delete previous log
		QString szFilePath = getLogFilePath();
		qDebug("Log will be in: %s", qPrintable(szFilePath));
		QFile fileLog(szFilePath);
		fileLog.remove();

        // Install log handler in file
		qInstallMessageHandler(logger);

        // Start somes thread with event loop to reproduce the problem
		MyThread thread;
		thread.start();

		MyThread thread2;
		thread2.start();

		qDebug("Starting the main loop");
		app.exec();
		qDebug("Exiting the main loop");
	}
}

bool runService(int argc, char *argv[])
{
	bool bRes = false;

	// Our process ID and Session ID
	pid_t pid, sid;

	// Fork off the parent process
	pid = fork();
	qDebug("PID: %d", pid);
	if (pid < 0) {
		exit(EXIT_FAILURE);
	}
	// If we got a good PID, then we can exit the parent process.
	if (pid > 0) {
		exit(EXIT_SUCCESS);
	}

	// Change the file mode mask
	umask(0);

	// Open any logs here

	// Create a new SID for the child process
	sid = setsid();
	qDebug("SID: %d", pid);
	if (sid < 0) {
		// Log the failure
		exit(EXIT_FAILURE);
	}

	// Change the current working directory
	if ((chdir("/")) < 0) {
		// Log the failure
		exit(EXIT_FAILURE);
	}

	// Close out the standard file descriptors
	close(STDIN_FILENO);
	close(STDOUT_FILENO);
	close(STDERR_FILENO);

	// Start the application
	applicationStart(argc, argv);

	bRes = true;

	return bRes;
}

int main(int argc, char **argv)
{
    QString szMode = "service";
    if(argc > 1){
        szMode = "no-service";
    }

	qDebug("Starting application");
    if(szMode == "service"){
	    runService(argc, argv);
    }else{
	    applicationStart(argc, argv);
    }
	qDebug("Stopping application");
}
