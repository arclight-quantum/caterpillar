cmake_minimum_required(VERSION 3.16)
set (CMAKE_CXX_STANDARD 20)
project(caterpillar_cmake_nix_example)
include(CMakeFindDependencyMacro)
find_package(caterpillar REQUIRED)
add_executable(hello hello.cpp)
target_link_libraries(hello caterpillar)
