cmake_minimum_required (VERSION 3.0)

project (foo VERSION 1.0.0)

find_package(PythonInterp)
find_program(PY_INSTALLER "pyinstaller")
message("pyinstaller search: ${PY_INSTALLER}")
set(BINARY_LIB "${CMAKE_CURRENT_BINARY_DIR}")

if (PY_INSTALLER)
	
	set(SOURCE_FILE "src/test.py")
	set(SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
	set(ICONF "image/web.ico")
	set(PYFLAGS "--console --icon=src/image/web.ico ${SOURCE_FILE}")
	file(COPY "${SOURCE_DIR}" DESTINATION "${BINARY_LIB}")
	
	add_custom_target(main ALL
		COMMAND cd src/
		COMMAND pyinstaller --console --icon=src/image/web.ico ${SOURCE_FILE}
		COMMENT "Building 'all'..."
		WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
	)
	
endif()
