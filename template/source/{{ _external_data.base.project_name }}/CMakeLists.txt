# Top level of the source tree. main.cpp is the entry point and lives here; every
# other component is a module in a subdirectory that adds its sources to the
# library target via target_sources. main links that library.
#
# For a pure library, delete main.cpp and this add_executable block.

add_executable(${PROJECT_NAME}_exe main.cpp)
set_target_properties(${PROJECT_NAME}_exe PROPERTIES OUTPUT_NAME ${PROJECT_NAME})
target_link_libraries(
        ${PROJECT_NAME}_exe PRIVATE ${PROJECT_NAMESPACE}::${PROJECT_NAME} project_options
)

add_subdirectory(greeting)
