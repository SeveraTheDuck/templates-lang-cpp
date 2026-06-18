target_sources(
        ${PROJECT_NAME}
        PRIVATE greeting.cpp
        PUBLIC FILE_SET HEADERS BASE_DIRS ${${PROJECT_NAME}_INCLUDE_ROOT} FILES greeting.hpp
)
