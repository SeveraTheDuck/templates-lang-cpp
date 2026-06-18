include_guard(GLOBAL)
include(FetchContent)

# Provides GTest::gtest_main: prefers a system package (e.g. from Nix), falling
# back to a pinned FetchContent build for non-Nix consumers.
function(setup_gtest)
  if(TARGET GTest::gtest_main)
    return()
  endif()

  find_package(GTest CONFIG QUIET)
  if(GTest_FOUND)
    message(STATUS "[${PROJECT_NAME}] Using system GTest")
    return()
  endif()

  message(STATUS "[${PROJECT_NAME}] Fetching GTest via FetchContent")
  FetchContent_Declare(
          googletest
          GIT_REPOSITORY https://github.com/google/googletest.git
          GIT_TAG        v1.17.0
          SYSTEM
  )
  FetchContent_MakeAvailable(googletest)
endfunction()
