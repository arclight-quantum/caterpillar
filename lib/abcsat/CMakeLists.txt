cmake_minimum_required (VERSION 3.6)

project(libabcsat LANGUAGES CXX)

include_directories(${PROJECT_SOURCE_DIR})
file(GLOB ABC_SRC *.cpp)

# Surpress warnings in external library
if (UNIX)
    set(CMAKE_CXX_FLAGS "-w")
endif()

if (STATIC_LIBABC)
    add_library(libabcsat STATIC EXCLUDE_FROM_ALL ${ABC_SRC})
    set_property(TARGET libabcsat PROPERTY OUTPUT_NAME libabcsat)
else()
    add_library(libabcsat SHARED EXCLUDE_FROM_ALL ${ABC_SRC})
    set_property(TARGET libabcsat PROPERTY OUTPUT_NAME libabcsat)
    set_property(TARGET libabcsat PROPERTY POSITION_INDEPENDENT_CODE ON)
endif()
target_include_directories(libabcsat INTERFACE 
$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>
$<INSTALL_INTERFACE:include>
)

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
    "${PROJECT_BINARY_DIR}/libabcsatConfigVersion.cmake"
    VERSION ${CMAKE_PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
)

install(TARGETS libabcsat
EXPORT libabcsatTargets
PUBLIC_HEADER DESTINATION include
ARCHIVE DESTINATION lib/static
LIBRARY DESTINATION lib
)


configure_package_config_file(
    "${PROJECT_SOURCE_DIR}/cmake/libabcsatConfig.cmake.in"
    "${PROJECT_BINARY_DIR}/libabcsatConfig.cmake"
    INSTALL_DESTINATION lib/cmake/libabcsat
)

install(EXPORT libabcsatTargets DESTINATION lib/cmake/libabcsat)
install(FILES "${PROJECT_BINARY_DIR}/libabcsatConfigVersion.cmake"
              "${PROJECT_BINARY_DIR}/libabcsatConfig.cmake"
        DESTINATION lib/cmake/libabcsat)
install(DIRECTORY ./abc DESTINATION include)
