cmake_minimum_required(VERSION 3.6)

add_definitions(-DTRANSLATION_DOMAIN=\"plasma_applet_org.kde.plasma.publictransport.timetable\")

find_package(ECM 0.0.11 REQUIRED NO_MODULE)
set( CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR} ${CMAKE_MODULE_PATH} )

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)

find_package(KF5Plasma REQUIRED)

plasma_install_package(timetable org.kde.plasma.publictransport.timetable)
