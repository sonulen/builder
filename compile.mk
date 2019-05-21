include $(BUILDER_DIR)prebuild.mk
include $(BUILDER_DIR)compile_settings.mk

# Include dependency files (* .d) if they exist
-include $(DEPS)

# Rules to create objects from C sources
$(OBJS_PATH)/%.o: %.c $(COMMON_OBJ_DEPS) $(DEPS_PATH)/%.d
	@echo [CC] $<
	@mkdir -p $(dir $(DEPS_PATH)/$<)
	@mkdir -p $(dir $(OBJS_PATH)/$<)
	@$(CC) $(CFLAGS) $(DEPFLAGS) $(DIRFLAGS) $(DEFFLAGS) -c $< -o $@
	@$(POSTCOMPILE)

# Rules to create objects from C++ sources
$(OBJS_PATH)/%.o: %.cpp $(COMMON_OBJ_DEPS) $(DEPS_PATH)/%.d $(DEPS_PATH)/%.flags
	@echo [CPP] $<
	@mkdir -p $(dir $(DEPS_PATH)/$<)
	@mkdir -p $(dir $(OBJS_PATH)/$<)
	@$(CPP) $(CPPFLAGS) $(DEPFLAGS) $(DIRFLAGS) $(DEFFLAGS) -c $< -o $@
	@$(POSTCOMPILE)

# Rules to create objects from s sources
$(OBJS_PATH)/%.o: %.s $(COMMON_OBJ_DEPS)
	@echo [AS] $<
	@mkdir -p $(dir $(OBJS_PATH)/$<)
	@$(AS) $(BFLAGS) $(DIRFLAGS) $(DEFFLAGS) -c $< -o $@

# Rules to create objects from S sources
$(OBJS_PATH)/%.o: %.S $(COMMON_OBJ_DEPS)
	@echo [AS] $<
	@mkdir -p $(dir $(OBJS_PATH)/$<)
	@$(AS) $(BFLAGS) $(DIRFLAGS) $(DEFFLAGS) -c $< -o $@

# Preserve intermediate files created by this rules
$(DEPS_PATH)/%.d: ;
.PRECIOUS: $(DEPS_PATH)/%.d
