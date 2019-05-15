# Set silence mode [default: true]
# If silence == false -> print usage commands
SILENCE := false

# Name of result file [%NAME%.elf] [default: run_me.elf]
NAME := runnable

# Change BIN && DEPS && OBJS dirs
DEPS_PATH := .deps
OBJS_PATH := .objs
BIN_PATH 	:= bin

# Set optimization level [default: -0s]
OPTIMIZATION_LVL := -O0

# This adding `#define DEBUG` for your code. [default: `#define RELEASE`]
DEBUG := true

# Set c++ standard [default: -std=c++17]
CPP_STANDARD := -std=c++17

# Disable flto [default: if OPTIMIZATION_LVL != -O0 -> flto := on else FLTO := off]
FLTO := on

# Set GDB debuging info [default: if DEGUB_BUILD -> -g3 else None]
G_OPTION := -g3

DIRS := $(shell find . -not -path '*/\.*' -not -path '../builder' -type d)
SOURCES := $(shell find . -type f \( -name '*.c' -o -name '*.cpp' -o -name '*.s' -o -name '*.S' \))

# Enable generating asm files
ASM := on

# Use += and this variable adding define for you program code
DEFS +=

# Set output format from GNU size [default: berkeley]
SIZE_OUTPUT := sysv

PATH_TO_BUILDER = builder/builder.mk
include $(PATH_TO_BUILDER)
