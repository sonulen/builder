AS := gcc
CC :=  gcc
CPP :=  g++

# Вычисляем имена объектников основываясь на исходниках.
# (Заменяя суффиксы на .o)
CHANGE_C = $(SOURCES:.c=.o)
CHANGE_LOWER_S = $(CHANGE_C:.s=.o)
CHANGE_UPPER_S = $(CHANGE_LOWER_S:.S=.o)
CHANGE_CPP = $(CHANGE_UPPER_S:.cpp=.o)

# Вычисляем конечные пути расположения объектников и файлов с зависимостями
OBJS = $(addprefix $(OBJS_PATH)/,$(CHANGE_CPP))
DEPS = $(addprefix $(DEPS_PATH)/,$(CHANGE_CPP:.o=.d))

BFLAGS += $(OPTIMIZATION_LVL) $(FLTO_FLAG) -Wall -g3 -Wextra -Werror -ffunction-sections
CFLAGS += $(BFLAGS)
CPPFLAGS += $(BFLAGS) -pthread $(CPP_STANDARD)

# Переменная содержит флаги для генерации файла с зависимостями обрабатываемого исходника.
# Файл с зависимостями имеет путь: $(DEPS_PATH)/_path_to_source_/_source_name_.Td
DEPFLAGS = -MMD -MP -MF $(DEPS_PATH)/$*.Td
DIRFLAGS = $(addprefix -I,$(DIRS))
DEFFLAGS = $(addprefix -D,$(DEFS))

# Функция перемещает временные файлы с зависимостями (*.Td) в конечные *.d
# link: http://make.mad-scientist.net/papers/advanced-auto-dependency-generation/
POSTCOMPILE = @mv -f $(DEPS_PATH)/$*.Td $(DEPS_PATH)/$*.d && touch $@

# Добавляем зависимость объектных файлов от мейкфайов,
# которые встречались до текущего момента.
COMMON_OBJ_DEPS := $(MAKEFILE_LIST)


ifeq ($(SILENCE), false)
$(info Info from compile.mk file:)
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
