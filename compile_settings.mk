# Assembler compiler
AS := gcc

# C compiler
CC :=  gcc

# Cpp compiler
CPP :=  g++

# Change **file_name**.c|.cpp|.s|.S to **file_name**.o
CHANGE_C = $(SOURCES:.c=.o)
CHANGE_LOWER_S = $(CHANGE_C:.s=.o)
CHANGE_UPPER_S = $(CHANGE_LOWER_S:.S=.o)
CHANGE_CPP = $(CHANGE_UPPER_S:.cpp=.o)

# Calculate the final paths of the location of objects and files with dependencies
OBJS = $(addprefix $(OBJS_PATH)/,$(CHANGE_CPP))
DEPS = $(addprefix $(DEPS_PATH)/,$(CHANGE_CPP:.o=.d))

# If it is debug build and G_OPTION not installed -> set default -g3
# else if this release build is set it to empty

# if (TYPE_OF_BUILD == DEBUG && G_OPTION is undefined) {
# 	G_OPTION = -g3
# } else {
# 	G_OPTION = empty
# }
ifeq ($(TYPE_OF_BUILD), DEBUG)
ifndef G_OPTION
G_OPTION := -g3
endif
endif

# Common flags passed to the C and C ++  compiler.
BFLAGS += $(OPTIMIZATION_LVL) $(FLTO_FLAG) -Wall $(G_OPTION) -Wextra -Werror -ffunction-sections

# Flags passed to the C compiler.
CFLAGS += $(BFLAGS)

# Flags passed to the C ++  compiler.
CPPFLAGS += $(BFLAGS) -pthread $(CPP_STANDARD)

# Flags to generate dependencies
DEPFLAGS = -MMD -MP -MF $(DEPS_PATH)/$*.Td

#
DIRFLAGS = $(addprefix -I,$(DIRS))

#
DEFFLAGS = $(addprefix -D,$(DEFS))

# Function to move *.Td to *.d
POSTCOMPILE = @mv -f $(DEPS_PATH)/$*.Td $(DEPS_PATH)/$*.d && touch $@

# Dependencies from all makefiles
COMMON_OBJ_DEPS := $(MAKEFILE_LIST)


ifeq ($(SILENCE), off)
$(info Info from compile_settings.mk file:)
$(info Sources files = $(SOURCES))
$(info Object files = $(OBJS))
$(info Deps files = $(DEPS))
$(info Include dirs (with headers) = $(DIRS))
$(info Defines = $(DEFS))
$(info Flags for C = $(CFLAGS))
$(info Flags for C++ = $(CPPFLAGS))
$(info Common deps for sources = $(COMMON_OBJ_DEPS))
$(info )
endif
