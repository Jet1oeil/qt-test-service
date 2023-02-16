cmake_minimum_required(VERSION "3.7")

project (qt-service-test VERSION 1.0.0 LANGUAGES CXX)

set (CMAKE_VERBOSE_MAKEFILE OFF)

#set(CMAKE_CXX_FLAGS "-Wall -fPIC -std=c++11")
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

####################
# Find Qt
####################

find_package (Qt5 5.1.0 COMPONENTS Core REQUIRED)
if(Qt5_FOUND)
    message(STATUS "QtCore: version ${Qt5Core_VERSION_STRING} found")
    message(STATUS "QtCore: include dirs ${Qt5Core_INCLUDE_DIRS}")
    message(STATUS "QtCore: libs ${Qt5Core_LIBRARIES}")
    include_directories(${Qt5Core_INCLUDE_DIRS})
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
target_link_libraries(qt-service-test ${Qt5Core_LIBRARIES})

install(TARGETS qt-service-test DESTINATION /usr/bin)
