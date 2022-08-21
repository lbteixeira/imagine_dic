# Utilities
include(Format)
include(Memcheck)

# Dependencies
include(GetGLFW)

# Create the library target associated with the application business logic.
# The file containing the main function shouldn't be included in the library.
add_library(imagine_app_static STATIC
  gui_manager.cpp
)
target_compile_options(imagine_app_static PUBLIC ${EXTRA_COMPILATION_FLAGS})

# Include directories for the business logic related library
target_include_directories(imagine_app_static PUBLIC include)

target_link_libraries(imagine_app_static PUBLIC
  imagine_static
  glfw
)

add_executable(imagine_app main.cpp)
target_link_libraries(imagine_app imagine_app_static)
Format(imagine_app .)
AddMemcheck(imagine_app)

# Create the documentation target
Doxygen(imagine_app src/CMakeLists.txt)
