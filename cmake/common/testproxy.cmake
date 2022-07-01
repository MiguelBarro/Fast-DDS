# Copyright 2022 Proyectos y Sistemas de Mantenimiento SL (eProsima).
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

include_guard(DIRECTORY)

if(SAN_PERFILE_LOG)

    # Semicolon separated list of sanitizer environment variables
    set(SAN_OPTIONS "")

    # Get a config timestamp (all builds of the same config override each other)
    if(WIN32)
        execute_process(COMMAND powershell -C Get-Date -Format "MMMM-dd-yyyy_HH-mm-ss" OUTPUT_VARIABLE SAN_TIMESTAMP)
    elseif(UNIX)
        execute_process(COMMAND $ENV{SHELL} -c "LC_ALL=en_US.utf8 date +%B-%d-%Y_%H-%M-%S" OUTPUT_VARIABLE SAN_TIMESTAMP)
    else()
        string(TIMESTAMP SAN_TIMESTAMP %B-%d-%Y_%H-%M-%S)
    endif()

    # get rid of line endings
    string(REGEX REPLACE "\r|\n" "" SAN_TIMESTAMP "${SAN_TIMESTAMP}")

    set(SAN_REPORT_ROOT ${PROJECT_BINARY_DIR})

    # windows paths use : for drive units which can be misunderstood as unix list separator
    # turn the path into UNC one 
    if(WIN32)
        string(REPLACE ":" "$" SAN_REPORT_ROOT "${SAN_REPORT_ROOT}")
        set(SAN_REPORT_ROOT "//$ENV{COMPUTERNAME}/${SAN_REPORT_ROOT}")
    endif()

    # Address sanitizer
    if(SANITIZE_ADDRESS)
        set(ASAN_OPTIONS "ASAN_OPTIONS=")

        # check if TSAN_OPTIONS are specified to keep it's contents
        if(DEFINED ENV{ASAN_OPTIONS})
            string(APPEND ASAN_OPTIONS "$ENV{ASAN_OPTIONS}:")
        endif()

        # Get a log dir
        set(ASAN_LOG_DIR "${SAN_REPORT_ROOT}/${SAN_TIMESTAMP}/asan")
        file(MAKE_DIRECTORY ${ASAN_LOG_DIR})

        # Populate environment variables
        list(APPEND SAN_OPTIONS "${ASAN_OPTIONS}log_path=${ASAN_LOG_DIR}/<PROXY_NAME>")

        unset(ASAN_OPTIONS)
        unset(ASAN_LOG_DIR)
    endif(SANITIZE_ADDRESS)

    # Thread sanitizer
    if(SANITIZE_THREAD)
        set(TSAN_OPTIONS "TSAN_OPTIONS=")

        # check if TSAN_OPTIONS are specified to keep it's contents
        if(DEFINED ENV{TSAN_OPTIONS})
            string(APPEND TSAN_OPTIONS "$ENV{TSAN_OPTIONS}:")
        endif()

        # Get a log dir
        set(TSAN_LOG_DIR "${SAN_REPORT_ROOT}/${SAN_TIMESTAMP}/tsan")
        file(MAKE_DIRECTORY ${TSAN_LOG_DIR})

        # Populate environment variables
        list(APPEND SAN_OPTIONS "${TSAN_OPTIONS}log_path=${TSAN_LOG_DIR}/<PROXY_NAME>")

        unset(TSAN_OPTIONS)
        unset(TSAN_LOG_DIR)
    endif(SANITIZE_THREAD)

    set(SAN_OPTIONS "${SAN_OPTIONS}" CACHE INTERNAL "sanitizer log template")

    # Modify the properties in a proxy function
    function(proxy_add_test)

        # perfect forwarding
        add_test(${ARGV})

        # Get the test name
        cmake_parse_arguments(PROXY "" NAME "" ${ARGV})

        if(PROXY_NAME)
            string(REPLACE "<PROXY_NAME>" "${PROXY_NAME}" THIS_TEST_SAN_OPTIONS "${SAN_OPTIONS}")
            set_tests_properties(${PROXY_NAME} PROPERTIES ENVIRONMENT "${THIS_TEST_SAN_OPTIONS}")
            unset(THIS_TEST_SAN_OPTIONS)
        else()
            message(FATAL_ERROR "proxy_add_test cannot detect the test name")
        endif()

    endfunction()

    unset(SAN_REPORT_ROOT)
    unset(SAN_TIMESTAMP)
    unset(SAN_OPTIONS)
else()
    # perfect forwarding
    function(proxy_add_test)
        add_test(${ARGV})
    endfunction()
endif()

# Function to traverse all subdirs and get all tests
function(get_subdir_tests directory list)

    # Get all tests for this directory
    get_property(TEST_LIST DIRECTORY ${directory} PROPERTY TESTS)

    if(TEST_LIST)
        list(APPEND ${list} ${TEST_LIST})
    endif()

    get_property(SUB_LIST DIRECTORY ${directory} PROPERTY SUBDIRECTORIES)

    # recurse into subdirs
    if(SUB_LIST)
        foreach(subdir IN LISTS SUB_LIST)
            get_subdir_tests(${subdir} ${list})
        endforeach()
    endif()

    # Propagate always to the parent scope
    set(${list} ${${list}} PARENT_SCOPE)

endfunction()
