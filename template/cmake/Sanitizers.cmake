include_guard(GLOBAL)

# Adds the enabled sanitizers to the project_options INTERFACE target, so they propagate
# consistently to every target that links it. Inconsistent sanitizer flags across the link graph
# cause ODR violations and false/missed reports.
function(apply_sanitizers)
  if(${PROJECT_NAME}_ENABLE_ASAN AND ${PROJECT_NAME}_ENABLE_TSAN)
    message(FATAL_ERROR "ASan and TSan cannot be enabled together")
  endif()

  if(${PROJECT_NAME}_ENABLE_ASAN)
    target_compile_options(project_options INTERFACE -fsanitize=address -fno-omit-frame-pointer)
    target_link_options(project_options INTERFACE -fsanitize=address)
  endif()

  if(${PROJECT_NAME}_ENABLE_UBSAN)
    target_compile_options(project_options INTERFACE -fsanitize=undefined)
    target_link_options(project_options INTERFACE -fsanitize=undefined)
  endif()

  if(${PROJECT_NAME}_ENABLE_TSAN)
    target_compile_options(project_options INTERFACE -fsanitize=thread)
    target_link_options(project_options INTERFACE -fsanitize=thread)
  endif()
endfunction()
