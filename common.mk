ifndef DEPS_PATH
# Default path to dep files
export DEPS_PATH := .deps
endif

ifndef OBJS_PATH
# Default path to obj files
export OBJS_PATH := .objs
endif

ifndef BIN_PATH
# Default path to bin file
export BIN_PATH := bin
endif

# BUILD TYPE
ifndef BUILD
export BUILD := $(MAKECMDGOALS)
endif

ifndef BUILD
# Default BUILD
BUILD := all
endif

ifndef NAME
# Default name
export NAME := run_me
endif

ifeq ($(SILENCE), off)
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

# Clean target declaration
.PHONY: clean
clean: clean_all
	rm -rf $(BIN_PATH)

.PHONY: clean_all
clean_all:
	rm -rf $(OBJS_PATH)
	rm -rf $(DEPS_PATH)
