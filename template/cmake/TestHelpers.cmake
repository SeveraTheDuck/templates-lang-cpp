include_guard(GLOBAL)
include(GoogleTest)

# Adds a GTest executable from explicit SOURCES, linked against the project
# library, gtest_main and project_options. Registered with CTest under a label
# equal to the target name, so `ctest -L <name>` runs just this suite.
function(add_project_test TARGET_NAME)
  cmake_parse_arguments(ARG "" "" "SOURCES;LIBRARIES" ${ARGN})

  if(NOT ARG_SOURCES)
    message(FATAL_ERROR "add_project_test(${TARGET_NAME}): SOURCES is required")
  endif()

  add_executable(${TARGET_NAME} ${ARG_SOURCES})
  target_link_libraries(
          ${TARGET_NAME}
          PRIVATE ${PROJECT_NAMESPACE}::${PROJECT_NAME}
          GTest::gtest_main
          project_options
          ${ARG_LIBRARIES}
  )
  gtest_discover_tests(${TARGET_NAME} DISCOVERY_MODE PRE_TEST PROPERTIES LABELS ${TARGET_NAME})
endfunction()
