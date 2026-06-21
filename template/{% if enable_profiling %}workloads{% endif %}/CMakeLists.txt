# Profiling workloads: standalone benchmark programs that exercise the library
# under perf. Built only when ${PROJECT_NAME}_ENABLE_WORKLOADS is ON (see root
# CMakeLists). Each is a plain executable -- add another by dropping a .cpp here
# plus one add_executable / target_link_libraries pair.

#add_executable(${PROJECT_NAME}_workload workload.cpp)
#target_link_libraries(
#        ${PROJECT_NAME}_workload
#        PRIVATE ${PROJECT_NAMESPACE}::${PROJECT_NAME} project_options
#)
