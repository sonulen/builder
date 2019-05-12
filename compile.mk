# Файл осуществляет непосредственную компиляцию исходников в объектные файлы.

# Необходимые переменные для совершения компиляции:
# AS       - Компилятор ассемблерных файлов.
# CC       - Компилятор C файлов.
# CPP      - Компилятор C++ файлов.
# SOURCES  - Список исходных файлов относительно директории текущего мейкфайла
# DIRS     - Список диркеторий, где происходит поиск заголовочных файлов.
# DEFS     - Дефайны(#define), которые передаются компилятору.
# BFLAGS   - Общие флаги передаваемые компилятору при обработке C и C++ исходников.
# CFLAGS   - Флаги передаваемые компилятору при обработке C исходников
# CPPFLAGS - Флаги передаваемые компилятору при обработке C++ исходников

include $(BUILDER_DIR)settings.mk
include $(BUILDER_DIR)prebuild.mk
include $(BUILDER_DIR)compile_settings.mk

# Инклюдим файлы с зависимостями (*.d).
-include $(DEPS)

# Правила создания объектных файлов из исходников.
$(OBJS_PATH)/%.o: %.c $(COMMON_OBJ_DEPS) $(DEPS_PATH)/%.d
	@echo [CC] $<
	@mkdir -p $(dir $(DEPS_PATH)/$<)
	@mkdir -p $(dir $(OBJS_PATH)/$<)
	@$(CC) $(CFLAGS) $(DEPFLAGS) $(DIRFLAGS) $(DEFFLAGS) -c $< -o $@
	@$(POSTCOMPILE)

$(OBJS_PATH)/%.o: %.cpp $(COMMON_OBJ_DEPS) $(DEPS_PATH)/%.d $(DEPS_PATH)/%.flags
	@echo [CPP] $<
	@mkdir -p $(dir $(DEPS_PATH)/$<)
	@mkdir -p $(dir $(OBJS_PATH)/$<)
	@$(CPP) $(CPPFLAGS) $(DEPFLAGS) $(DIRFLAGS) $(DEFFLAGS) -c $< -o $@
	@$(POSTCOMPILE)

$(OBJS_PATH)/%.o: %.s $(COMMON_OBJ_DEPS)
	@echo [AS] $<
	@mkdir -p $(dir $(OBJS_PATH)/$<)
	@$(AS) $(BFLAGS) $(DIRFLAGS) $(DEFFLAGS) -c $< -o $@

$(OBJS_PATH)/%.o: %.S $(COMMON_OBJ_DEPS)
	@echo [AS] $<
	@mkdir -p $(dir $(OBJS_PATH)/$<)
	@$(AS) $(BFLAGS) $(DIRFLAGS) $(DEFFLAGS) -c $< -o $@

# Сообщаем мейку, чтобы не удалял наши файлы с зависимостями после
# окончания их использования.
$(DEPS_PATH)/%.d: ;
.PRECIOUS: $(DEPS_PATH)/%.d
