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

if(TSAN_PERFILE_LOG)

    set(TSAN_OPTIONS "TSAN_OPTIONS=")

    # check if TSAN_OPTIONS are specified to keep it's contents
    if(ENV{TSAN_OPTIONS}) 
        string(APPEND TSAN_OPTIONS "$ENV{TSAN_OPTIONS}")
    endif()

    # Get a config timestamp (all builds of the same config override each other)
    if(WIN32)
        execute_process(COMMAND powershell -C Get-Date -Format "MMMM-d-yyyy_HH-mm-ss" OUTPUT_VARIABLE TSAN_TIMESTAMP)
    elseif(UNIX)
        execute_process(COMMAND $ENV{SHELL} -c "LC_ALL=en_US.utf8 date +%B-%d-%Y_%H-%M-%S" OUTPUT_VARIABLE TSAN_TIMESTAMP)
    else()
        string(TIMESTAMP TSAN_TIMESTAMP %B-%d-%Y_%H-%M-%S)
    endif()

    # get rid of line endings
    string(REGEX REPLACE "\r|\n" "" TSAN_TIMESTAMP "${TSAN_TIMESTAMP}")

    # Get a log dir
    set(TSAN_LOG_DIR "${PROJECT_BINARY_DIR}/${TSAN_TIMESTAMP}")
    file(MAKE_DIRECTORY ${TSAN_LOG_DIR})

    # Modify the properties in a proxy function
    function(proxy_add_test)

        # perfect forwarding
        add_test(${ARGV})

        # Get the test name 
        cmake_parse_arguments(PROXY "" NAME "" ${ARGV})

        if(PROXY_NAME)
            set_tests_properties(${PROXY_NAME} PROPERTIES ENVIRONMENT "${TSAN_OPTIONS} log_path=${TSAN_LOG_DIR}/${PROXY_NAME}")
        else()
            message(FATAL_ERROR "proxy_add_test cannot detect the test name")
        endif()

    endfunction()

    unset(TSAN_TIMESTAMP)
    # The following variables are used within the proxy function and cannot be removed yet
    # unset(TSAN_LOG_DIR) 
    # unset(TSAN_OPTIONS)
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
