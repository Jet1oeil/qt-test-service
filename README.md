# qt-service-test

This projet help to reproduce a problem when applciation is started in service mode on linux, and when glib is not used.

## Installation

Compile Qt5 with stardeps and its dependencies :

```
# Install for stardeps
apt install git subversion cmake autoconf libtool gcc rsync nasm mercurial pkg-config patchelf libncurses5-dev

# Prepare virtual environnement
mkdir libs
cd libs
stardeps createenv linux-gcc-64

# Install openssl
stardeps install openssl --previous-steps --pkg-version=1.1.1d --scm-tag-version=OpenSSL_1_1_1d  --pkg-option=shared

# Install freetype2
stardeps install freetype2 --previous-steps --pkg-version=2-10-2 --scm-tag-version=VER-2-10-2 --pkg-option=static --pkg-option=shared

# Install fontconfig
apt install gperf autopoint expat libexpat1-dev
stardeps install fontconfig --previous-steps --pkg-version=2.13.96 --scm-tag-version=2.13.96 --pkg-option=static --pkg-option=shared

# Install qt
apt install '^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev libxkbcommon-dev libxkbcommon-x11-dev libsystemd-dev liblzma-dev libcap-dev libgcrypt20-dev libzstd-dev liblz4-dev libicu-dev
apt install build-essential libgl1-mesa-dev 
apt install python
stardeps install qt5 --previous-steps --pkg-version=5.15.8 --scm-tag-version=v5.15.8-lts-lgpl --pkg-option=openssl --pkg-option=freetype2 --pkg-option=fontconfig --pkg-option=shared --pkg-option=x11 --pkg-option=wayland

cd ..
```

Get project:

```
git clone https://github.com/Jet1oeil/qt-test-service.git
```

Compile project:

```
cmake -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=../toolchain-platform-unix-linux64-qt5.cmake .. && make

```

Run project :

```
# connect in root
su root # or sudo su
./qt-service-test && sleep 2 &&  killall qt-service-test && ls -lh app.log 
```

When the problem occurs the app.log is huge with many line :

```
QThreadPipe: internal error, wakeUps.testAndSetRelease(1, 0) failed!
```

