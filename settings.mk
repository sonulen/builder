# Файл содержит общие настройки для компиляции и линковки.

# --0. Выбираем место хранения долгоживущих файлов.

# Папка *.d содержит флаги компиляции предыдущей сборки (.flags),
# а также файлы с указанием зависиомстей (.d). Файлы остаются с предыдущих
# компиляций и на их основе решается - требуется ли перекомпиляция исходника.

# Папка *.objs содержит объектные файлы на основе которыйх линкуется
# конечный бинарник.

# --1. Выбираем уровень оптимизации
# Если не задан другой уровень оптимизации то по умолчанию -Os
ifndef OPTIMIZATION_LVL
OPTIMIZATION_LVL := -Os
endif

# --2. Выбираем тип сборки debug/release
# Включение отладочных функций (DEBUG/RELEASE сборка)
ifdef DEBUG
TYPE_OF_BUILD := DEBUG
else
TYPE_OF_BUILD := RELEASE
endif

DEFS += $(TYPE_OF_BUILD)

# --3. Выбираем с каким стандартом собирать
# Если никто не сказал обратного то мы всегда собираем с 17
ifndef CPP_STANDARD
CPP_STANDARD := -std=c++17
endif

# --4. Выбираем включать ли flto. Вычисляемое в момент запроса значение
ifndef FLTO
ifneq ($(CPP_STANDARD), -O0)
FLTO_FLAG := -flto
endif
else
ifeq ($(FLTO), on)
FLTO_FLAG := -flto
else
FLTO_FLAG :=
endif
endif

ifndef SILENCE
SILENCE := true
endif

ifeq ($(SILENCE), false)
$(info Info from settings.mk file: )
$(info Optimization level = $(OPTIMIZATION_LVL))
$(info Type of build = $(TYPE_OF_BUILD))
$(info Cpp standard = $(CPP_STANDARD))
$(info Flto flag = $(FLTO_FLAG))
$(info )
endif
