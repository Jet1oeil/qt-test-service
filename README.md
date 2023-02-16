# qt-service-test

This projet help to reproduce a problem when applciation is started in service mode on linux, and when glib is not used.

## Installation

Prerequisite

```
apt install git
```

Get project:

```
git clone https://github.com/Jet1oeil/qt-test-service.git
```

Build QtBase without Glib :

```
git clone https://github.com/qt/qt5.git
cd qt5
./init-repository -f --module-subset=qtbase
cd ..
mkdir qt-build
cd qt-build
../qt5/configure -opensource -confirm-license -shared -nomake examples -nomake tests -prefix ../qt-release
make
make install
```

Modify the toolchain-platform-unix-linux64-qt5.cmake to set the Qt's path

Compile project:

```
cmake -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=./toolchain-platform-unix-linux64-qt5.cmake .
make
```

Run project for a short time :

```
./qt-service-test && sleep 2 && killall qt-service-test
```

When the problem occurs the app.log is huge :

```
ls -l app.log 
-rw-rw-rw- 1 ebeuque ebeuque 37101769 févr. 16 15:24 app.log

```

And it contains a lot of error log:

```
Starting the main loop
Starting the thread
Starting the thread
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
```
