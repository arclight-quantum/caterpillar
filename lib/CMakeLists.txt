include(${PROJECT_SOURCE_DIR}/cmake/headerOnlyLibrary.cmake)
if (NOT TARGET sparsepp)
  add_library(sparsepp INTERFACE) # v1.21
  target_include_directories(sparsepp INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/sparsepp> $<INSTALL_INTERFACE:include>)
  if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU" AND CMAKE_CXX_COMPILER_VERSION VERSION_EQUAL "8.1.0")
    target_compile_options(sparsepp INTERFACE -Wno-class-memaccess)
  endif()
  headerOnlyTarget(sparsepp 1.21 ${CMAKE_CURRENT_SOURCE_DIR}/sparsepp)
endif()

if (NOT TARGET ez)
  add_library(ez INTERFACE) # v1.0
  target_include_directories(ez INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/ez> $<INSTALL_INTERFACE:include>)
  headerOnlyTarget(ez 1.0 ${CMAKE_CURRENT_SOURCE_DIR}/ez)
endif()


if (NOT TARGET kitty)
  add_library(kitty INTERFACE) # v0.4
  target_include_directories(kitty INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/kitty> $<INSTALL_INTERFACE:include>)
  headerOnlyTarget(kitty 0.4 ${CMAKE_CURRENT_SOURCE_DIR}/kitty)
endif()

if (NOT TARGET rang)
  add_library(rang INTERFACE)
  target_include_directories(rang INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/rang> $<INSTALL_INTERFACE:include>)
  headerOnlyTarget(rang 0.1 ${CMAKE_CURRENT_SOURCE_DIR}/rang)
endif()

if (NOT TARGET lorina)
  add_library(lorina INTERFACE) # v0.1
  target_include_directories(lorina INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/lorina> $<INSTALL_INTERFACE:include>)
  target_link_libraries(lorina INTERFACE rang fmt::fmt-header-only)
  headerOnlyTarget(lorina 0.1 ${CMAKE_CURRENT_SOURCE_DIR}/lorina)
endif()

if (NOT TARGET percy)
  add_library(percy INTERFACE) # >v0.1.2
  target_include_directories(percy SYSTEM INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/percy> $<INSTALL_INTERFACE:include>)
  target_compile_definitions(percy INTERFACE DISABLE_NAUTY)

  set(THREADS_PREFER_PTHREAD_FLAG ON)
  find_package(Threads REQUIRED)
  target_link_libraries(percy INTERFACE Threads::Threads)

  set(ABC_USE_NAMESPACE "pabc")
  set(STATIC_LIBABC true)
  add_subdirectory(abcsat)
  if (UNIX)
    target_compile_definitions(libabcsat PUBLIC "LIN64" ABC_NAMESPACE=pabc ABC_NO_USE_READLINE)
  elseif(WIN32)
    target_compile_definitions(libabcsat PUBLIC ABC_NAMESPACE=pabc ABC_USE_NO_READLINE NOMINMAX)
    target_compile_definitions(libabcsat PUBLIC WIN32_NO_DLL)
  endif()
  target_link_libraries(percy INTERFACE libabcsat)
  headerOnlyTarget(percy 0.1.2 ${CMAKE_CURRENT_SOURCE_DIR}/percy)
endif()

if (NOT TARGET mockturtle) # spectral c2e4149
  add_library(mockturtle INTERFACE)
  target_include_directories(mockturtle INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/mockturtle> $<INSTALL_INTERFACE:include>)
  target_link_libraries(mockturtle INTERFACE ez kitty lorina sparsepp percy bill nlohmann_json::nlohmann_json)
  headerOnlyTarget(mockturtle 0.1 ${CMAKE_CURRENT_SOURCE_DIR}/mockturtle)
endif()

if (NOT TARGET easy)
  add_library(easy INTERFACE)
  target_include_directories(easy INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/easy> $<INSTALL_INTERFACE:include>)
  target_link_libraries(easy INTERFACE bill)
  headerOnlyTarget(easy 0.1 ${CMAKE_CURRENT_SOURCE_DIR}/easy)
endif()

if (NOT TARGET tweedledum)
  add_library(tweedledum INTERFACE)
  target_include_directories(tweedledum INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/tweedledum> $<INSTALL_INTERFACE:include>)
  target_link_libraries(tweedledum INTERFACE easy fmt::fmt-header-only lorina kitty)
  headerOnlyTarget(tweedledum 0.1 ${CMAKE_CURRENT_SOURCE_DIR}/tweedledum)
endif()

if (NOT TARGET bill)
  add_library(bill INTERFACE)
  target_include_directories(bill SYSTEM INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/bill> $<INSTALL_INTERFACE:include>)
  headerOnlyTarget(bill 0.1 ${CMAKE_CURRENT_SOURCE_DIR}/bill)
endif()
