#
#

cmake_minimum_required (VERSION 3.1)

project (test)
cmake_policy (SET CMP0022 NEW)

# verify vars controllable from the matrix
set (TEST_ENABLE_TEST
    "TRUE"
    CACHE BOOL "If FALSE, then do not build gRPC integration")

option(TEST_SWITCH "Test switch default to OFF" OFF)


message(STATUS "TEST_ENABLE_TEST: ${TEST_ENABLE_TEST}")
message(STATUS "TEST_SWITCH: ${TEST_SWITCH}")