cmake_minimum_required(VERSION "3.7")

project (qt-service-test VERSION 1.0.0 LANGUAGES CXX)

set (CMAKE_VERBOSE_MAKEFILE OFF)

#set(CMAKE_CXX_FLAGS "-Wall -fPIC -std=c++11")
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

####################
# Find Qt
####################

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core)
message(STATUS "Looking for Qt${QT_VERSION_MAJOR}")
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core)
if(Qt${QT_VERSION_MAJOR}_FOUND)
    message(STATUS "QtCore: version ${Qt${QT_VERSION_MAJOR}Core_VERSION_STRING} found")
    message(STATUS "QtCore: include dirs ${Qt${QT_VERSION_MAJOR}Core_INCLUDE_DIRS}")
    message(STATUS "QtCore: libs ${Qt${QT_VERSION_MAJOR}Core_LIBRARIES}")
    include_directories(${Qt${QT_VERSION_MAJOR}Core_INCLUDE_DIRS})
endif()

####################
# Create Executable
####################

# Build executable
add_executable (qt-service-test
	main.cpp
    MyThread.cpp
    MyThread.h
)
target_link_libraries(qt-service-test PRIVATE Qt::Core)

install(TARGETS qt-service-test DESTINATION /usr/bin)
