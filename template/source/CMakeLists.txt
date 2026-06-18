# The library aggregates every module under source/<project>/. It is created here,
# empty, and populated by target_sources() in each module's subdirectory.

add_library(${PROJECT_NAME} STATIC)
add_library(${PROJECT_NAMESPACE}::${PROJECT_NAME} ALIAS ${PROJECT_NAME})
target_link_libraries(${PROJECT_NAME} PRIVATE project_options)

set(${PROJECT_NAME}_INCLUDE_ROOT "${CMAKE_CURRENT_SOURCE_DIR}")

# Generated <name/version.hpp> lives in the build tree.
target_include_directories(
        ${PROJECT_NAME} PUBLIC $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/generated>
)

add_subdirectory(${PROJECT_NAME})
