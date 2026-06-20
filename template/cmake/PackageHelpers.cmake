# PackageHelpers.cmake -- opt-in install/export of the library as a relocatable
# CMake package, consumable via find_package(${PROJECT_NAME} CONFIG).
#
# Library-first: only the library target + its public headers (FILE_SET) are
# installed. The executable is intentionally NOT installed (demo entry point).
# Gated by ${PROJECT_NAME}_ENABLE_INSTALL (Options.cmake, default OFF).

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

function(setup_install)
  if(NOT ${PROJECT_NAME}_ENABLE_INSTALL)
    return()
  endif()

  # Install the library + its FILE_SET headers. EXPORT records the target into a
  # named export set; FILE_SET HEADERS installs public headers and rewrites the
  # target's include dir to the INSTALL_INTERFACE location automatically.
  install(TARGETS ${PROJECT_NAME} project_options
          EXPORT ${PROJECT_NAME}Targets
          ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
          LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
          FILE_SET HEADERS DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

  # Export the target set with the project namespace, so consumers link
  # ${PROJECT_NAMESPACE}::${PROJECT_NAME}.
  install(EXPORT ${PROJECT_NAME}Targets
          FILE ${PROJECT_NAME}Targets.cmake
          NAMESPACE ${PROJECT_NAMESPACE}::
          DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

  # Generate <Project>Config.cmake from the template (resolves @PACKAGE_INIT@ and
  # any @VARS@), placing it where find_package(CONFIG) discovers it.
  configure_package_config_file(
          ${CMAKE_CURRENT_SOURCE_DIR}/cmake/ProjectConfig.cmake.in
          ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
          INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

  # SameMajorVersion: 1.x consumers accept any 1.y >= requested.
  write_basic_package_version_file(
          ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
          VERSION ${PROJECT_VERSION}
          COMPATIBILITY SameMajorVersion)

  install(FILES
          ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
          ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
          DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})
endfunction()
