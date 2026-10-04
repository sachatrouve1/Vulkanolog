cmake_minimum_required(VERSION 3.22)
project(Vulkanolog VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(Vulkan_INCLUDE_DIR "$ENV{VULKAN_HEADERS_PATH}/include")
set(Vulkan_LIBRARY "$ENV{VULKAN_LOADER_PATH}/lib/libvulkan.so")
set(GLM_INCLUDE_DIR "$ENV{GLM_PATH}/include")
set(VMA_INCLUDE_DIR "$ENV{VULKAN_MEMORY_ALLOCATOR_PATH}/include")
set(GLM_INCLUDE_DIR "$ENV{KTX_PATH}/include")

# Pkgconfig
find_package(PkgConfig REQUIRED)
pkg_check_modules(GLFW3 REQUIRED glfw3)
pkg_check_modules(TinyObj REQUIRED tinyobjloader)
pkg_check_modules(Slang REQUIRED slang)
pkg_check_modules(VOLK REQUIRED volk)

add_executable(Vulkanolog 
    src/main.cpp
)

add_library(imgui STATIC
    libs/imgui/imgui.cpp
    libs/imgui/imgui_draw.cpp
    libs/imgui/imgui_tables.cpp
    libs/imgui/imgui_widgets.cpp
    libs/imgui/backends/imgui_impl_glfw.cpp
    libs/imgui/backends/imgui_impl_vulkan.cpp
)

target_include_directories(Vulkanolog PRIVATE
  libs/imgui
  libs/imgui/backends
  ${GLFW3_INCLUDE_DIRS} 
  ${Vulkan_INCLUDE_DIR}
  ${VMA_INCLUDE_DIRS}
  ${GLM_INCLUDE_DIRS}
  ${TinyObj_INCLUDE_DIRS}
  ${KTX_INCLUDE_DIRS}
  ${Slang_INCLUDE_DIRS}
)

target_link_libraries(Vulkanolog PRIVATE
  imgui
  ${Vulkan_LIBRARY}
  ${GLFW3_LIBRARIES}
  ${VOLK_LIBRARIES}
  ${TinyObj_LIBRARIES}
  ${KTX_LIBRARIES}
  ${Slang_LIBRARIES}
)
