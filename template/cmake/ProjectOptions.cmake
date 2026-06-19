include_guard(GLOBAL)

# Creates the `project_options` INTERFACE target carrying the project's common build settings (C++
# standard, warnings). Every target links it PRIVATE so the settings stay consistent across the
# whole link graph. Sanitizers and LTO are layered on separately (Sanitizers.cmake / Lto.cmake).
function(setup_project_options)
  add_library(project_options INTERFACE)

  target_compile_features(project_options INTERFACE "cxx_std_${${PROJECT_NAME}_CXX_STANDARD}")

  target_compile_options(
    project_options
    INTERFACE $<$<CXX_COMPILER_ID:Clang,AppleClang,GNU>:
              -Wall
              -Wextra
              -Werror
              -Wpedantic
              -Wconversion
              -Wshadow
              -fstack-protector-strong
              $<$<NOT:$<CONFIG:Release>>:-fno-omit-frame-pointer>
              >
  )

  target_compile_definitions(
    project_options
    INTERFACE $<$<AND:$<CXX_COMPILER_ID:Clang,AppleClang,GNU>,$<CONFIG:Release>>:_FORTIFY_SOURCE=2>
  )
endfunction()
