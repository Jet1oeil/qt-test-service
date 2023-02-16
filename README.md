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

Run project :

```
./qt-service-test && sleep 2 &&  killall qt-service-test && ls -lh app.log 
```

When the problem occurs the app.log is huge with many line :

```
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
```
