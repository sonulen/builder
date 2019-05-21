# Compare old and current compilation flags

# if (old_flags != new_flags) {
# 	call target to create $(DEPS_PATH)/%.flags file with new flags
# }

# Current flags
CURRENT_COMPILE_FLAGS = $(TYPE_OF_BUILD) $(CPP) $(CPPFLAGS) $(DEPFLAGS) $(DIRFLAGS) $(DEFFLAGS) -c $*.cpp

# Function to get old flags
MATCHING_SEARCH = $(shell grep -s -F '$(CURRENT_COMPILE_FLAGS)' $(DEPS_PATH)/$1.flags)

# Function to compare old and current flags
MAKE_CHECK_ABOUT_FLAGS =  $(if $(MATCHING_SEARCH),,force)

# Target to create a file with the current flags of the company, if the flags have changed
.SECONDARY:
.SECONDEXPANSION:
$(DEPS_PATH)/%.flags: $$(call MAKE_CHECK_ABOUT_FLAGS,%)
	@mkdir -p $(dir $@) && echo '$(CURRENT_COMPILE_FLAGS)' > $@

.PHONY: force
force:
