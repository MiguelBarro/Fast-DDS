# Copyright 2021 Proyectos y Sistemas de Mantenimiento SL (eProsima).
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if(WIN32)
    add_definitions(-D_WIN32_WINNT=0x0601)
endif()

set(LOG_COMMON_SOURCE
    ${PROJECT_SOURCE_DIR}/src/cpp/fastdds/log/Log.cpp
    ${PROJECT_SOURCE_DIR}/src/cpp/fastdds/log/OStreamConsumer.cpp
    ${PROJECT_SOURCE_DIR}/src/cpp/fastdds/log/StdoutConsumer.cpp
    ${PROJECT_SOURCE_DIR}/src/cpp/fastdds/log/StdoutErrConsumer.cpp
    ${PROJECT_SOURCE_DIR}/src/cpp/utils/SystemInfo.cpp
    )

# MACROS LOG TEST ALL
set(LOGMACROS_ALL_TEST_SOURCE LogMacrosAllActiveTests.cpp)

set(LOGMACROS_SOURCE
    ${LOG_COMMON_SOURCE}
    ${LOGMACROS_ALL_TEST_SOURCE})

add_executable(LogMacrosAllActiveTests ${LOGMACROS_SOURCE})
target_compile_definitions(LogMacrosAllActiveTests PRIVATE FASTRTPS_NO_LIB
    $<$<AND:$<NOT:$<BOOL:${WIN32}>>,$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">>:__DEBUG>
    $<$<BOOL:${INTERNAL_DEBUG}>:__INTERNALDEBUG> # Internal debug activated.
    )
target_include_directories(LogMacrosAllActiveTests PRIVATE
    ${PROJECT_SOURCE_DIR}/include ${PROJECT_BINARY_DIR}/include
    ${PROJECT_SOURCE_DIR}/src/cpp)
target_link_libraries(LogMacrosAllActiveTests GTest::gtest ${MOCKS}
    $<TARGET_NAME_IF_EXISTS:fastdds::wer>
    $<$<BOOL:${WIN32}>:iphlpapi$<SEMICOLON>Shlwapi>
    )
add_gtest(LogMacrosAllActiveTests SOURCES ${LOGMACROS_ALL_TEST_SOURCE})


# MACROS LOG TEST NO INFO
set(LOGMACROS_NOINFO_TEST_SOURCE LogMacrosNoInfoTests.cpp)

set(LOGMACROS_SOURCE
    ${LOG_COMMON_SOURCE}
    ${LOGMACROS_NOINFO_TEST_SOURCE})

add_executable(LogMacrosNoInfoTests ${LOGMACROS_SOURCE})
target_compile_definitions(LogMacrosNoInfoTests PRIVATE FASTRTPS_NO_LIB
    $<$<AND:$<NOT:$<BOOL:${WIN32}>>,$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">>:__DEBUG>
    $<$<BOOL:${INTERNAL_DEBUG}>:__INTERNALDEBUG> # Internal debug activated.
    )
target_include_directories(LogMacrosNoInfoTests PRIVATE
    ${PROJECT_SOURCE_DIR}/include ${PROJECT_BINARY_DIR}/include
    ${PROJECT_SOURCE_DIR}/src/cpp)
target_link_libraries(LogMacrosNoInfoTests GTest::gtest ${MOCKS}
    $<TARGET_NAME_IF_EXISTS:fastdds::wer>
    $<$<BOOL:${WIN32}>:iphlpapi$<SEMICOLON>Shlwapi>
    )
add_gtest(LogMacrosNoInfoTests SOURCES ${LOGMACROS_NOINFO_TEST_SOURCE})


# MACROS LOG TEST NO WARNING
set(LOGMACROS_NOWARNING_TEST_SOURCE LogMacrosNoWarningTests.cpp)

set(LOGMACROS_SOURCE
    ${LOG_COMMON_SOURCE}
    ${LOGMACROS_NOWARNING_TEST_SOURCE})

add_executable(LogMacrosNoWarningTests ${LOGMACROS_SOURCE})
target_compile_definitions(LogMacrosNoWarningTests PRIVATE FASTRTPS_NO_LIB
    $<$<AND:$<NOT:$<BOOL:${WIN32}>>,$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">>:__DEBUG>
    $<$<BOOL:${INTERNAL_DEBUG}>:__INTERNALDEBUG> # Internal debug activated.
    )
target_include_directories(LogMacrosNoWarningTests PRIVATE
    ${PROJECT_SOURCE_DIR}/include ${PROJECT_BINARY_DIR}/include
    ${PROJECT_SOURCE_DIR}/src/cpp)
target_link_libraries(LogMacrosNoWarningTests GTest::gtest ${MOCKS}
    $<TARGET_NAME_IF_EXISTS:fastdds::wer>
    $<$<BOOL:${WIN32}>:iphlpapi$<SEMICOLON>Shlwapi>
    )
add_gtest(LogMacrosNoWarningTests SOURCES ${LOGMACROS_NOWARNING_TEST_SOURCE})


# MACROS LOG TEST NO ERROR
set(LOGMACROS_NOERROR_TEST_SOURCE LogMacrosNoErrorTests.cpp)

set(LOGMACROS_SOURCE
    ${LOG_COMMON_SOURCE}
    ${LOGMACROS_NOERROR_TEST_SOURCE})

add_executable(LogMacrosNoErrorTests ${LOGMACROS_SOURCE})
target_compile_definitions(LogMacrosNoErrorTests PRIVATE FASTRTPS_NO_LIB
    $<$<AND:$<NOT:$<BOOL:${WIN32}>>,$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">>:__DEBUG>
    $<$<BOOL:${INTERNAL_DEBUG}>:__INTERNALDEBUG> # Internal debug activated.
    )
target_include_directories(LogMacrosNoErrorTests PRIVATE
    ${PROJECT_SOURCE_DIR}/include ${PROJECT_BINARY_DIR}/include
    ${PROJECT_SOURCE_DIR}/src/cpp)
target_link_libraries(LogMacrosNoErrorTests GTest::gtest ${MOCKS}
    $<TARGET_NAME_IF_EXISTS:fastdds::wer>
    $<$<BOOL:${WIN32}>:iphlpapi$<SEMICOLON>Shlwapi>
    )
add_gtest(LogMacrosNoErrorTests SOURCES ${LOGMACROS_NOERROR_TEST_SOURCE})


# MACROS LOG TEST NO DEFAULT
set(LOGMACROS_DEFAULT_TEST_SOURCE LogMacrosDefaultTests.cpp)

set(LOGMACROS_SOURCE
    ${LOG_COMMON_SOURCE}
    ${LOGMACROS_DEFAULT_TEST_SOURCE})

add_executable(LogMacrosDefaultTests ${LOGMACROS_SOURCE})
target_compile_definitions(LogMacrosDefaultTests PRIVATE FASTRTPS_NO_LIB
    $<$<AND:$<NOT:$<BOOL:${WIN32}>>,$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">>:__DEBUG>
    $<$<BOOL:${INTERNAL_DEBUG}>:__INTERNALDEBUG> # Internal debug activated.
    )
target_include_directories(LogMacrosDefaultTests PRIVATE
    ${PROJECT_SOURCE_DIR}/include ${PROJECT_BINARY_DIR}/include
    ${PROJECT_SOURCE_DIR}/src/cpp)
target_link_libraries(LogMacrosDefaultTests GTest::gtest ${MOCKS}
    $<TARGET_NAME_IF_EXISTS:fastdds::wer>
    $<$<BOOL:${WIN32}>:iphlpapi$<SEMICOLON>Shlwapi>
    )
add_gtest(LogMacrosDefaultTests SOURCES ${LOGMACROS_DEFAULT_TEST_SOURCE})


# MACROS LOG TEST INTERNALDEBUG
# In case this test fails, it fails de compilation

set(LOGMACROS_INTERNALDEBUG_TEST_SOURCE LogMacrosInternalDebugOffTests.cpp)

set(LOGMACROS_SOURCE
    ${LOG_COMMON_SOURCE}
    ${LOGMACROS_INTERNALDEBUG_TEST_SOURCE})

add_executable(LogMacrosInternalDebugOffTests ${LOGMACROS_SOURCE})
target_compile_definitions(LogMacrosInternalDebugOffTests PRIVATE FASTRTPS_NO_LIB
    $<$<AND:$<NOT:$<BOOL:${WIN32}>>,$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">>:__DEBUG>
    $<$<BOOL:${INTERNAL_DEBUG}>:__INTERNALDEBUG> # Internal debug activated.
    )
target_include_directories(LogMacrosInternalDebugOffTests PRIVATE
    ${PROJECT_SOURCE_DIR}/include ${PROJECT_BINARY_DIR}/include
    ${PROJECT_SOURCE_DIR}/src/cpp)
target_link_libraries(LogMacrosInternalDebugOffTests GTest::gtest ${MOCKS}
    $<TARGET_NAME_IF_EXISTS:fastdds::wer>
    $<$<BOOL:${WIN32}>:iphlpapi$<SEMICOLON>Shlwapi>
    )
add_gtest(LogMacrosInternalDebugOffTests SOURCES ${LOGMACROS_INTERNALDEBUG_TEST_SOURCE})

# MACROS OLD LOG TEST ALL
set(LOGMACROS_ALL_TEST_SOURCE OldLogMacrosTests.cpp)

set(LOGMACROS_SOURCE
    ${LOG_COMMON_SOURCE}
    ${LOGMACROS_ALL_TEST_SOURCE})

add_executable(OldLogMacrosTests ${LOGMACROS_SOURCE})
target_compile_definitions(OldLogMacrosTests PRIVATE FASTRTPS_NO_LIB
    $<$<AND:$<NOT:$<BOOL:${WIN32}>>,$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">>:__DEBUG>
    $<$<BOOL:${INTERNAL_DEBUG}>:__INTERNALDEBUG> # Internal debug activated.
    )
target_include_directories(OldLogMacrosTests PRIVATE
    ${PROJECT_SOURCE_DIR}/include ${PROJECT_BINARY_DIR}/include
    ${PROJECT_SOURCE_DIR}/src/cpp)
target_link_libraries(OldLogMacrosTests GTest::gtest ${MOCKS}
    $<$<BOOL:${WIN32}>:iphlpapi$<SEMICOLON>Shlwapi>
    $<TARGET_NAME_IF_EXISTS:fastdds::wer>
    )
add_gtest(OldLogMacrosTests SOURCES ${LOGMACROS_ALL_TEST_SOURCE})


# MACROS OLD DISABLE LOG TEST ALL
set(LOGMACROS_ALL_TEST_SOURCE OldLogMacrosDisableTests.cpp)

set(LOGMACROS_SOURCE
    ${LOG_COMMON_SOURCE}
    ${LOGMACROS_ALL_TEST_SOURCE})

add_executable(OldLogMacrosDisableTests ${LOGMACROS_SOURCE})
target_compile_definitions(OldLogMacrosDisableTests PRIVATE FASTRTPS_NO_LIB
    $<$<AND:$<NOT:$<BOOL:${WIN32}>>,$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">>:__DEBUG>
    $<$<BOOL:${INTERNAL_DEBUG}>:__INTERNALDEBUG> # Internal debug activated.
    )
target_include_directories(OldLogMacrosDisableTests PRIVATE
    ${PROJECT_SOURCE_DIR}/include ${PROJECT_BINARY_DIR}/include
    ${PROJECT_SOURCE_DIR}/src/cpp)
target_link_libraries(OldLogMacrosDisableTests GTest::gtest ${MOCKS}
    $<$<BOOL:${WIN32}>:iphlpapi$<SEMICOLON>Shlwapi>
    $<TARGET_NAME_IF_EXISTS:fastdds::wer>
    )
add_gtest(OldLogMacrosDisableTests SOURCES ${LOGMACROS_ALL_TEST_SOURCE})

# SET PROPERTIES TO TESTS
if(ANDROID)
    set_property(TARGET LogMacrosAllActiveTests PROPERTY CROSSCOMPILING_EMULATOR "adb;shell;cd;${CMAKE_CURRENT_BINARY_DIR};&&")
    set_property(TARGET LogMacrosDefaultTests PROPERTY CROSSCOMPILING_EMULATOR "adb;shell;cd;${CMAKE_CURRENT_BINARY_DIR};&&")
    set_property(TARGET LogMacrosInternalDebugOffTests PROPERTY CROSSCOMPILING_EMULATOR "adb;shell;cd;${CMAKE_CURRENT_BINARY_DIR};&&")
    set_property(TARGET LogMacrosNoErrorTests PROPERTY CROSSCOMPILING_EMULATOR "adb;shell;cd;${CMAKE_CURRENT_BINARY_DIR};&&")
    set_property(TARGET LogMacrosNoInfoTests PROPERTY CROSSCOMPILING_EMULATOR "adb;shell;cd;${CMAKE_CURRENT_BINARY_DIR};&&")
    set_property(TARGET LogMacrosNoWarningTests PROPERTY CROSSCOMPILING_EMULATOR "adb;shell;cd;${CMAKE_CURRENT_BINARY_DIR};&&")
    set_property(TARGET OldLogMacrosTests PROPERTY CROSSCOMPILING_EMULATOR "adb;shell;cd;${CMAKE_CURRENT_BINARY_DIR};&&")
    set_property(TARGET OldLogMacrosDisableTests PROPERTY CROSSCOMPILING_EMULATOR "adb;shell;cd;${CMAKE_CURRENT_BINARY_DIR};&&")
endif()
