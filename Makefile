ARCHS = arm64 arm64e
TARGET := iphone:clang:latest:16.0
THEOS_PACKAGE_SCHEME = roothide
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AODUnlock
AODUnlock_FILES = Tweak.xm
AODUnlock_CFLAGS = -fobjc-arc
AODUnlock_FRAMEWORKS = Foundation

include $(THEOS_MAKE_PATH)/tweak.mk
