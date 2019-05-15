# Файл осуществляет непосредственную линковку объектных файлов в бинарник.

# Необходимые переменные для совершения линковки:
# LD         - Линковщик (бинарник).
# OBJDUMP    - Бинарник используется для генерации асемблерного файла (man objdump).
# PRINT_SIZE - Юниксовая команда для вывода текущего размера.
# CFLAGS     - Сишные флаги линковки.
# LDFLAGS    - Общие флаги линковки.

LD := g++
OBJDUMP := objdump
SIZE := size

CFLAGS := -Wl,--no-as-needed -pthread

# Пути расположения конечных файлов.
BINARY_FILE := $(BIN_PATH)/$(NAME).elf
MAP_FILE := $(BIN_PATH)/$(NAME).map
ASM_FILE := $(BIN_PATH)/$(NAME).asm

# Добавляем общие флаги линковки
CFLAGS += -Wall -g3 -Wextra -Werror
LDFLAGS += -Xlinker --gc-sections
LDFLAGS += -o $@ -Wl,-Map="$(MAP_FILE)" $(MEMORY_PRINT)
LDFLAGS	+= -lm

# Добавляем зависимость бинарника от мейкфайов, которые встречались
# до текущего момента
COMMON_OBJ_DEPS := $(MAKEFILE_LIST)

ifeq ($(ASM),on)
# Если флаг присутствует, то пререквезитом является бинарник.
ASM_GEN = $(ASM_FILE)
else
# Иначе удаляем ассемблерный файл на случай недоразумений с устаревшим файлом.
ASM_GEN = $(shell rm -rf $(ASM_FILE))
endif

ifeq ($(SILENCE), false)
ifneq ($(BUILD),clean)
$(info Info from link.mk file: )
$(info Linker = $(LD))
$(info Linker C flags = $(CFLAGS))
$(info Linker flags = $(LDFLAGS))
$(info )
endif
endif

ifndef SIZE_OUTPUT
SIZE_OUTPUT := berkeley
endif

# Правило генерации ассемблерного файла
$(ASM_FILE): $(BINARY_FILE)
	@echo 'Assembler file generating'
	@$(OBJDUMP) --source -D $(BINARY_FILE) > $(ASM_FILE)

$(BINARY_FILE): $(OBJS) $(COMMON_OBJ_DEPS)
	@mkdir -p $(BIN_PATH)
	@echo
	@echo [LD] $@
	@echo
	@$(LD) $(CFLAGS) $(OBJS) $(LDFLAGS)
	@echo 'Size summary:'
	@$(SIZE) --format=$(SIZE_OUTPUT) $(BINARY_FILE)

all: $(BINARY_FILE) $(ASM_GEN)
