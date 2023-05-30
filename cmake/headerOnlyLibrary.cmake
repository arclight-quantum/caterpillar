include(CMakePackageConfigHelpers)
function(headerOnlyTarget target version files)
write_basic_package_version_file(
    "${PROJECT_BINARY_DIR}/${target}ConfigVersion.cmake"
    VERSION ${version}
    COMPATIBILITY AnyNewerVersion
)

install(TARGETS ${target}
EXPORT ${target}Targets
PUBLIC_HEADER DESTINATION include
)

configure_package_config_file(
    "${PROJECT_SOURCE_DIR}/cmake/${target}Config.cmake.in"
    "${PROJECT_BINARY_DIR}/${target}Config.cmake"
    INSTALL_DESTINATION lib/cmake/${target}
)

install(EXPORT ${target}Targets DESTINATION lib/cmake/${target})
install(FILES "${PROJECT_BINARY_DIR}/${target}ConfigVersion.cmake"
              "${PROJECT_BINARY_DIR}/${target}Config.cmake"
        DESTINATION lib/cmake/${target})
install(DIRECTORY ${files} DESTINATION include)

endfunction()
