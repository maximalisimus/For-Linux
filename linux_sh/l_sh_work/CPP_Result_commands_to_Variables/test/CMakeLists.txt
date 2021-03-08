cmake_minimum_required(VERSION 3.2)

project(test VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)

set(CMAKE_CXX_STANDARD_REQUIRED on)

set(CC "gcc")

set(CXX "g++")

set(CMAKE_GENERATOR "Unix Makefiles")

set(CMAKE_AUTOMOC ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(Qt5 COMPONENTS Core REQUIRED)

set(BINARY_LIB "${CMAKE_CURRENT_BINARY_DIR}")
set(EXEC_NAME "test")
if(${CMAKE_SYSTEM_NAME} STREQUAL Windows)
	set(EXEC_SYS "${EXEC_NAME}_win")
	if(CMAKE_SYSTEM_PROCESSOR MATCHES "amd64.*|x86_64.*|AMD64.*")
		message("The system of Windows on - 'x86_64'. ")
	else()
		message("The system of Windows on - 'x86'. ")
	endif()
	if(CMAKE_CXX_COMPILER MATCHES "amd64.*|x86_64.*|AMD64.*")
		set(SOURCE_LIB "${CMAKE_CURRENT_SOURCE_DIR}/src/dirconvert-win-x64.exe")
		set(SOURCE_FILES "${CMAKE_CURRENT_SOURCE_DIR}/src/main_win_x64.cpp")
		set(EXECUTABLES "${EXEC_SYS}_x86_64")
	else()
		set(SOURCE_LIB "${CMAKE_CURRENT_SOURCE_DIR}/src/dirconvert-win-x86.exe")
		set(SOURCE_FILES "${CMAKE_CURRENT_SOURCE_DIR}/src/main_win_x86.cpp")
		set(EXECUTABLES "${EXEC_SYS}_i686")
	endif()
else()
	set(EXEC_SYS "${EXEC_NAME}_linux")
	if(CMAKE_SYSTEM_PROCESSOR MATCHES "amd64.*|x86_64.*|AMD64.*")
		message("The system of Linux on - 'x86_64'. ")
		set(EXECUTABLES "${EXEC_SYS}_x86_64")
	else()
		message("The system of Linux on - 'i686'. ")
		set(EXECUTABLES "${EXEC_SYS}_i686")
	endif()
	set(SOURCE_FILES "${CMAKE_CURRENT_SOURCE_DIR}/src/main_unix.cpp")
	set(SOURCE_LIB "${CMAKE_CURRENT_SOURCE_DIR}/src/dirconvert-linux-x86_64")
endif()

set(CMAKE_BUILD_TYPE Release)
# set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_CONFIGURATION_TYPES "Release" CACHE STRING "" FORCE)
# set(CMAKE_CONFIGURATION_TYPES "Debug" CACHE STRING "" FORCE)
# set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Wall -o0 -g")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -Wall -o2 -s -DNDEBUG")

add_executable(${EXECUTABLES} "${SOURCE_FILES}")

file(COPY "${SOURCE_LIB}" DESTINATION "${BINARY_LIB}")

qt5_use_modules(${EXECUTABLES} Core)
