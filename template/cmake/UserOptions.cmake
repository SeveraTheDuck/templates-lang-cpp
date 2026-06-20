# UserOptions.cmake -- project-local build options.
#
# Owned by you. Created once on generation; `copier update` never overwrites it
# (kept via _skip_if_exists). Included at the end of ProjectOptions.cmake.
#
# Flags for YOUR code only (not propagated to consumers of your library):
#   target_compile_options(project_options INTERFACE -freflection)
#
# Flags consumers must also use (e.g. reflection used in your public headers):
#   target_compile_options(${PROJECT_NAME} PUBLIC -freflection)
#   target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_26)
#
# Leave empty if you have no custom options.
