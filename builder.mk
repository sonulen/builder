BUILDER_DIR := $(dir $(PATH_TO_BUILDER))

COMMON_PATH = $(BUILDER_DIR)common.mk
SETTINGS_PATH = $(BUILDER_DIR)settings.mk
COMPILE_PATH = $(BUILDER_DIR)compile.mk
LINK_PATH = $(BUILDER_DIR)link.mk

ifeq ($(SILENCE), false)
$(info Info from builder.mk file:)
$(info Path to builder.mk = $(PATH_TO_BUILDER))
$(info Path to common.mk = $(COMMON_PATH))
ifneq ($(MAKECMDGOALS),clean)
$(info Path to settings.mk = $(SETTINGS_PATH))
$(info Path to compile.mk = $(COMPILE_PATH))
$(info Path to link.mk = $(LINK_PATH))
endif
$(info )
endif

# Главное правило, которое требует объектные файлы.
.DEFAULT_GOAL:
all:

include $(COMMON_PATH)

ifneq ($(BUILD),clean)
include $(SETTINGS_PATH)
include $(COMPILE_PATH)
include $(LINK_PATH)
endif
