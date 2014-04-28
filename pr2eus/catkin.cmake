cmake_minimum_required(VERSION 2.8.3)
project(pr2eus)
set(pr2eus_catkin_components roseus rostest euscollada control_msgs nav_msgs dynamic_reconfigure )
if($ENV{ROS_DISTRO} STREQUAL "groovy")
  set(_ROS_PACKAGE_PATH $ENV{ROS_PACKAGE_PATH})
  set(ENV{ROS_PACKAGE_PATH} ${CMAKE_SOURCE_DIR}:${_ROS_PACKAGE_PATH})
  execute_process(COMMAND rosrun roseus generate-all-msg-srv.sh move_base_msgs)
  execute_process(COMMAND rosrun roseus generate-all-msg-srv.sh pr2_msgs)
  execute_process(COMMAND rosrun roseus generate-all-msg-srv.sh pr2_controllers_msgs)
  execute_process(COMMAND rosrun roseus generate-all-msg-srv.sh sound_play)
  set(ENV{ROS_PACKAGE_PATH} ${_ROS_PACKAGE_PATH})
else()
  set(pr2eus_catkin_components ${pr2eus_catkin_components} move_base_msgs pr2_msgs pr2_controllers_msgs sound_play)
endif()
find_package(catkin REQUIRED COMPONENTS ${pr2eus_catkin_components}
  geneus # this load roseus.cmake, so it needs to be located in the end
  )


catkin_package(
    DEPENDS 
    CATKIN-DEPENDS 
    INCLUDE_DIRS 
    LIBRARIES 
)

install(DIRECTORY test
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
  USE_SOURCE_PERMISSIONS
  )

install(DIRECTORY .
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
  USE_SOURCE_PERMISSIONS
  FILES_MATCHING
  PATTERN "*.l"
  PATTERN ".svn" EXCLUDE
  )

add_rostest(test/pr2eus-test.launch)
add_rostest(test/make-pr2-model-file-test.launch)
#add_rostest(test/pr2-ri-test.launch)
