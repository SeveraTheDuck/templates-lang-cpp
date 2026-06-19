include_guard(GLOBAL)
include(CheckIPOSupported)

# Enables interprocedural optimisation (LTO) project-wide for optimised configs when requested and
# supported. A macro so the CMAKE_* variables land in the including (top-level) scope. Set globally
# rather than on project_options: target properties do not propagate through INTERFACE linking.
macro(setup_lto)
  if(${PROJECT_NAME}_ENABLE_LTO)
    check_ipo_supported(RESULT _ipo_supported OUTPUT _ipo_error)
    if(_ipo_supported)
      set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_RELEASE ON)
      set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_RELWITHDEBINFO ON)
    else()
      message(WARNING "LTO requested but not supported: ${_ipo_error}")
    endif()
  endif()
endmacro()
