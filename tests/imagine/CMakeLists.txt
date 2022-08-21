include(GetEigen)
include(Memcheck)

# Add target for the tests executable.
add_executable(imagine_tests
  test-1.cpp
)

include(Format)
Format(imagine_tests .)

# Link target to the testing framework, to the library being tested and to
# other dependencies.
target_link_libraries(imagine_tests
  imagine_static

  Catch2::Catch2WithMain
  Eigen3::Eigen
  ${BLAZE_TARGET}
)

catch_discover_tests(imagine_tests)
AddMemcheck(imagine_tests)
