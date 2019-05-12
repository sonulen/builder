# make without args -> make clean

ifndef DEPS_PATH
export DEPS_PATH := .deps
endif

ifndef OBJS_PATH
export OBJS_PATH := .objs
endif

ifndef BIN_PATH
export BIN_PATH 	:= .bin
endif

# BUILD TYPE
ifndef BUILD
export BUILD := $(MAKECMDGOALS)
endif

ifndef BUILD
BUILD := all
endif

# default name
ifndef NAME
export NAME := run_me
endif

ifeq ($(SILENCE), false)
$(info Info from common.mk file: )
$(info Binary file path = $(BIN_PATH))
$(info Deps file path = $(DEPS_PATH))
$(info Objs file path = $(OBJS_PATH))
ifneq ($(BUILD),clean)
$(info Build type = $(BUILD))
$(info Name of result file = $(NAME))
endif
$(info )
endif

.PHONY: clean
clean: clean_all
	rm -rf $(BIN_PATH)

.PHONY: clean_all
clean_all:
	rm -rf $(OBJS_PATH)
	rm -rf $(DEPS_PATH)
