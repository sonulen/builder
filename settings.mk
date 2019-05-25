# Set default level of optimization
ifndef OPTIMIZATION_LVL
OPTIMIZATION_LVL := -Os
endif

ifdef DEBUG
TYPE_OF_BUILD := DEBUG
else
TYPE_OF_BUILD := RELEASE
endif

# Adding define to u code
DEFS += $(TYPE_OF_BUILD)

# Set default standard
ifndef CPP_STANDARD
CPP_STANDARD := -std=c++17
endif

# if (undefined FLTO && OPTIMIZATION_LVL!= -O0) {
# 	FLTO_FLAG = -flto
# } else {
# 	if (FLTO == on) {
# 		FLTO_FLAG = -flto
# 	} else {
# 		FLTO_FLAG = empty
# 	}
# }
ifndef FLTO
ifneq ($(OPTIMIZATION_LVL), -O0)
FLTO_FLAG := -flto
endif
else
ifeq ($(FLTO), on)
FLTO_FLAG := -flto
else
FLTO_FLAG :=
endif
endif

# Set default silence mode
ifndef SILENCE
SILENCE := true
endif

ifeq ($(SILENCE), off)
$(info Info from settings.mk file: )
$(info Optimization level = $(OPTIMIZATION_LVL))
$(info Type of build = $(TYPE_OF_BUILD))
$(info Cpp standard = $(CPP_STANDARD))
$(info Flto flag = $(FLTO_FLAG))
$(info )
endif
