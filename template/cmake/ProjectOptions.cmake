include_guard(GLOBAL)

# Creates the `project_options` INTERFACE target carrying the project's common build settings (C++
# standard, warnings). Every target links it PRIVATE so the settings stay consistent across the
# whole link graph. Sanitizers and LTO are layered on separately (Sanitizers.cmake / Lto.cmake).
function(setup_project_options)
  add_library(project_options INTERFACE)

  target_compile_features(project_options INTERFACE "cxx_std_${${PROJECT_NAME}_CXX_STANDARD}")

  target_compile_options(
    project_options
    INTERFACE
          -Wall
          -Wextra
          -Wpedantic
          -Wshadow
          -Wconversion
          -Wsign-conversion
          -Wcast-qual
          -Wcast-align
          -Wold-style-cast
          -Wnon-virtual-dtor
          -Woverloaded-virtual
          -Wunused-parameter
          -Wzero-as-null-pointer-constant
          -Wextra-semi
          -Wsuggest-override
          -Wdouble-promotion
          -Wformat=2
          -Wredundant-decls
          -Wmissing-declarations

          # -- gcc only --
          $<$<CXX_COMPILER_ID:GNU>:-Wuseless-cast>
          $<$<CXX_COMPILER_ID:GNU>:-Wduplicated-cond>
          $<$<CXX_COMPILER_ID:GNU>:-Wduplicated-branches>
          $<$<CXX_COMPILER_ID:GNU>:-Wlogical-op>
          $<$<CXX_COMPILER_ID:GNU>:-Wnull-dereference>

          # -- clang only --
          $<$<CXX_COMPILER_ID:Clang>:-Wshadow-all>
          $<$<CXX_COMPILER_ID:Clang>:-Wconditional-uninitialized>
          $<$<CXX_COMPILER_ID:Clang>:-Wcomma>
          $<$<CXX_COMPILER_ID:Clang>:-Wloop-analysis>
          $<$<CXX_COMPILER_ID:Clang>:-Wunreachable-code>
          $<$<CXX_COMPILER_ID:Clang>:-Wheader-hygiene>
          $<$<CXX_COMPILER_ID:Clang>:-Wdocumentation>
  )

  target_compile_definitions(
    project_options
    INTERFACE
      $<$<AND:$<CXX_COMPILER_ID:Clang,AppleClang,GNU>,$<CONFIG:Release>,$<NOT:$<BOOL:${${PROJECT_NAME}_ENABLE_ASAN}>>>:_FORTIFY_SOURCE=2>
  )
endfunction()
