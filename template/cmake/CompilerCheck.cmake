include_guard(GLOBAL)

# Rejects compilers older than the project's pinned minimums (a guard for builds
# outside the Nix dev shell). The minimums live in Options.cmake.
function(check_compiler_versions)
  message(STATUS "[${PROJECT_NAME}] Compiler: ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")

  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|AppleClang")
    if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "${${PROJECT_NAME}_MIN_CLANG}")
      message(FATAL_ERROR "Clang ${${PROJECT_NAME}_MIN_CLANG}+ required, got ${CMAKE_CXX_COMPILER_VERSION}")
    endif()
  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "${${PROJECT_NAME}_MIN_GCC}")
      message(FATAL_ERROR "GCC ${${PROJECT_NAME}_MIN_GCC}+ required, got ${CMAKE_CXX_COMPILER_VERSION}")
    endif()
  else()
    message(FATAL_ERROR "Unsupported compiler: ${CMAKE_CXX_COMPILER_ID}. Use GCC or Clang.")
  endif()
endfunction()
