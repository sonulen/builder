# Set silence mode [default: true]
# If silence == false -> print usage commands
SILENCE := false

# Name of result file [%NAME%.elf] [default: run_me.elf]
NAME := runnable

# Change BIN && DEPS && OBJS dirs
DEPS_PATH := ../.deps
OBJS_PATH := ../.objs
BIN_PATH 	:= ../bin

# Set optimization level [default: -0s]
OPTIMIZATION_LVL := -O0

# Set c++ standard [default: -std=c++17]
CPP_STANDARD := -std=c++17

# Disable flto [default: if OPTIMIZATION_LVL != -O0 -> flto := on else FLTO := off]
FLTO := on


# DIRS := $(shell find .. -not -path '*/\.*' -not -path '../builder' -type d)
SOURCE :=

ASM := on

PATH_TO_BUILDER = builder.mk
include $(PATH_TO_BUILDER)
