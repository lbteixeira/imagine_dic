# Utilities
include(CppCheck)
include(Format)
include(Doxygen)

# Dependencies
include(GetEigen)
include(GetBlaze)
include(GetOpenCV)
include(GetMatplotPlusPlus)

# Non-default compilation flags
set(EXTRA_COMPILATION_FLAGS
  -Werror -Wall -Wextra -pedantic-errors -Wconversion -Wsign-conversion
)

# Files that have to be compiled
set(PROJECT_FILES
  eigen.cpp
  blaze.cpp
  opencv.cpp
  matplot.cpp
)

# Generate an obj file, that can be used to build static and shared libraries
add_library(imagine_obj OBJECT ${PROJECT_FILES})
target_compile_options(imagine_obj PUBLIC ${EXTRA_COMPILATION_FLAGS})

# Runs Cppcheck on the obj library if in Debug mode
if(${CMAKE_BUILD_TYPE} STREQUAL Debug)
  AddCppCheck(imagine_obj)
endif()

# Linking the dependencies to the obj library
target_link_libraries(imagine_obj PRIVATE
  ${EIGEN_TARGET}
  ${BLAZE_TARGET}
  ${MATPLOT_TARGET}
  ${OpenCV_LIBS}
)

target_include_directories(imagine_obj PUBLIC
  "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
  "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>")

# Create a static library target and link the obj into it
add_library(imagine_static STATIC)
target_link_libraries(imagine_static imagine_obj)

# Formats the source files according to the style defined by .clang-format
Format(imagine_static .)

# Create the documentation target
Doxygen(imagine_static src/CMakeLists.txt)

