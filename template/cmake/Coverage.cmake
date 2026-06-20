# Self-gated by ${PROJECT_NAME}_ENABLE_COVERAGE (Options.cmake). Flags layer onto the
# project_options INTERFACE target, so the library, executable and tests are instrumented, while
# GTest -- which does not link project_options -- stays clean, exactly like the warning flags.
# Reports are produced out-of-tree by `just coverage`; this module only wires compile/link
# instrumentation.

if(${PROJECT_NAME}_ENABLE_COVERAGE)
  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    message(STATUS "[${PROJECT_NAME}] Coverage: source-based (Clang/llvm-cov)")
    target_compile_options(project_options INTERFACE
            -fprofile-instr-generate -fcoverage-mapping)
    target_link_options(project_options INTERFACE -fprofile-instr-generate)
  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    message(STATUS "[${PROJECT_NAME}] Coverage: arc-based (GCC/gcov)")
    target_compile_options(project_options INTERFACE --coverage)
    target_link_options(project_options INTERFACE --coverage)
  else()
    message(FATAL_ERROR
            "[${PROJECT_NAME}] Coverage requires Clang or GCC, got '${CMAKE_CXX_COMPILER_ID}'")
  endif()
endif()
