cmake_minimum_required(VERSION 3.21)
include($ENV{XMOS_CMAKE_PATH}/xcommon.cmake)
project(app_an00248)

set(APP_HW_TARGET          XK-EVK-XU316)

set(APP_DEPENDENT_MODULES  "lib_xua(5.3.0)"
                           "lib_board_support(1.5.0)")

set(APP_COMPILER_FLAGS -O3
                       -report
                       -g
                       -Wno-unused-function
                       -DXUD_CORE_CLOCK=600
                       -DBOARD_SUPPORT_BOARD=XK_EVK_XU316)

set(APP_INCLUDES           src/)

set(XMOS_SANDBOX_DIR       ${CMAKE_CURRENT_LIST_DIR}/../..)

XMOS_REGISTER_APP()
