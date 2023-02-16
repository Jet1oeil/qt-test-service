# here is the target environment located
set(CMAKE_PREFIX_PATH
	/home/ebeuque/Developpement/Lib/startdeps-ve/ve-linux64/qt5-5.15.8-noglib/release
)

# adjust the default behaviour of the FIND_XXX() commands:
# search headers and libraries in the target environment, search
# programs in the host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
