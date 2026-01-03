cmake_minimum_required(VERSION 3.16)

project(UniQmlTk VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick Gui)

qt_add_library(UniQmlTk SHARED
  UniQmlTk_global.h
  uniqmltk.cpp
  uniqmltk.h
  BaseWindow.qml
  qmldir
)

qt_add_qml_module(UniQmlTk
  URI UniQmlTk
  VERSION 1.0
  QML_FILES
    BaseWindow.qml
  OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml/UniQmlTk
  QML_FILES UniButton.qml
  QML_FILES BaseSidebarShellOverlay.qml
  QML_FILES ThemeManager.qml
  QML_FILES SelectableBackground.qml
  QML_FILES PressableListDelegate.qml
  QML_FILES UniLabel.qml
)

target_link_libraries(UniQmlTk PRIVATE Qt6::Core Qt6::Quick Qt6::Gui)

target_compile_definitions(UniQmlTk PRIVATE UNIQMLTK_LIBRARY)

target_include_directories(UniQmlTk PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
    $<INSTALL_INTERFACE:include/UniQmlTk>
)

include(GNUInstallDirs)

install(TARGETS UniQmlTk
    EXPORT UniQmlTkTargets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

get_target_property(QML_MODULE_DIR UniQmlTk QT_QML_MODULE_INSTALL_DIR)
if(NOT QML_MODULE_DIR)
    set(QML_MODULE_DIR "${CMAKE_INSTALL_LIBDIR}/qt6/qml/UniQmlTk")
endif()

install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/qml/UniQmlTk/
    DESTINATION ${QML_MODULE_DIR}
)

# Export targets
install(EXPORT UniQmlTkTargets
    FILE UniQmlTkTargets.cmake
    NAMESPACE UniQmlTk::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/UniQmlTk
)

# Create config file
include(CMakePackageConfigHelpers)
configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/UniQmlTkConfig.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/UniQmlTkConfig.cmake"
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/UniQmlTk
)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/UniQmlTkConfigVersion.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
)

install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/UniQmlTkConfig.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/UniQmlTkConfigVersion.cmake"
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/UniQmlTk
)
