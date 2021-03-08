cmake_minimum_required(VERSION 3.2)

project(CPP_Result VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)

set(CMAKE_CXX_STANDARD_REQUIRED on)

set(CC "gcc")

set(CXX "g++")

set(CMAKE_GENERATOR "Unix Makefiles")

set(EXEC_NAME "mainExec")

set(BINARY_LIB "${CMAKE_CURRENT_BINARY_DIR}")

if(${CMAKE_SYSTEM_NAME} STREQUAL Windows)
	set(EXEC_SYS "${EXEC_NAME}_win")
	if(CMAKE_SYSTEM_PROCESSOR MATCHES "amd64.*|x86_64.*|AMD64.*")
		message("The system of Windows on - 'x86_64'. ")
	else()
		message("The system of Windows on - 'x86'. ")
	endif()
	if(CMAKE_CXX_COMPILER MATCHES "amd64.*|x86_64.*|AMD64.*")
		message("The compilers architecture on - 'x86_64'. ")
		set(SOURCE_FILES "${CMAKE_CURRENT_SOURCE_DIR}/src/main_win_x64.cpp")
		set(SOURCE_LIB "${CMAKE_CURRENT_SOURCE_DIR}/src/dirconvert-win-x64.exe")
		set(EXECUTABLES "${EXEC_SYS}_x86_64")
	else()
		message("The compilers architecture on - 'i686'. ")
		set(SOURCE_FILES "${CMAKE_CURRENT_SOURCE_DIR}/src/main_win_x86.cpp")
		set(SOURCE_LIB "${CMAKE_CURRENT_SOURCE_DIR}/src/dirconvert-win-x86.exe")
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

install(
	TARGETS ${EXECUTABLES}
	RUNTIME
	DESTINATION bin
	COMPONENT applications
)
install(
	FILES ${SOURCE_LIB}
	DESTINATION bin
	COMPONENT applications
)

# install(
#	TARGETS mylib 
#	ARCHIVE
#	DESTINATION lib
#	COMPONENT libraries
# )
# install(
#	TARGETS mylibapp
#	RUNTIME
#	DESTINATION bin
#	COMPONENT applications
# )
# install(
#	FILES mylib.h
#	DESTINATION include
#	COMPONENT headers
# )

if(UNIX)
	set(CMAKE_INSTALL_PREFIX /usr)
endif(UNIX)

set (CPACK_PACKAGE_NAME "CPP_Result")
set(CPACK_PACKAGE_VENDOR "MyCompany")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "maximalis171091@yandex.ru")
set(CPACK_PACKAGE_DESCRIPTION "The test programm on CPP to write STDOUT on variables")
set(CPACK_PACKAGE_VERSION 1.0.0)
# set (CPACK_PACKAGE_VERSION_MAJOR "1")
# set (CPACK_PACKAGE_VERSION_MINOR "0")
# set (CPACK_PACKAGE_VERSION_PATCH "0")
# set (CPACK_PACKAGE_INSTALL_DIRECTORY "CPack Component Example")
set(CPACK_GENERATOR "TGZ")
# 7Z     - 7-Zip file format (archive)
# IFW    - Qt Installer Framework (executable)
# NSIS   - Null Soft Installer (executable)
# NSIS64 - Null Soft Installer (64-bit, executable)
# STGZ   - Self extracting Tar GZip compression (archive)
# TBZ2   - Tar BZip2 compression (archive)
# TGZ    - Tar GZip compression (archive)
# TXZ    - Tar XZ compression (archive)
# TZ     - Tar Compress compression (archive)
# WIX    - MSI file format via WiX tools (executable archive)
# ZIP    - ZIP file format (archive)
set (CPACK_PACKAGE_INSTALL_DIRECTORY "CPack Component Example")
set (CPACK_COMPONENTS_ALL applications) # libraries headers
set (CPACK_COMPONENT_APPLICATIONS_DISPLAY_NAME "CPP_Result Applications")
# set (CPACK_COMPONENT_LIBRARIES_DISPLAY_NAME "Libraries")
# set (CPACK_COMPONENT_HEADERS_DISPLAY_NAME "C++ Headers")
set (CPACK_COMPONENT_APPLICATIONS_DESCRIPTION
  "The test programm on CPP to write STDOUT on variables")
# set (CPACK_COMPONENT_LIBRARIES_DESCRIPTION
 # "Static libraries used to build programs with MyLib")
# set (CPACK_COMPONENT_HEADERS_DESCRIPTION
 # "C/C++ header files for use with MyLib")
# set (CPACK_COMPONENT_HEADERS_DEPENDS libraries)
set(CPACK_COMPONENT_APPLICATIONS_GROUP "Runtime")
# set(CPACK_COMPONENT_LIBRARIES_GROUP "Development")
# set(CPACK_COMPONENT_HEADERS_GROUP "Development")
# set(CPACK_COMPONENT_GROUP_DEVELOPMENT_DESCRIPTION
#   "All of the tools you'll ever need to develop software")
set(CPACK_ALL_INSTALL_TYPES Full Developer)
# set(CPACK_COMPONENT_LIBRARIES_INSTALL_TYPES Developer Full)
# set(CPACK_COMPONENT_HEADERS_INSTALL_TYPES Developer Full)
set(CPACK_COMPONENT_APPLICATIONS_INSTALL_TYPES Full)
include(CPack)
