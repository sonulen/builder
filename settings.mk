# По умолчанию Clean мне так удобно
clean:
	rm -rf .d
	rm -rf .obj

# Реализуем отладочную и релиз сборки
ifeq ($(debug),true)
DEFS += DEBUG_FLAG
OPTIM := -O0
MARK := debug
else
OPTIM := -Os
MARK := release
endif

export OPTIM
export MARK
export DEFS

# Метки что б если был дебаг пересобирать для релиза	
.obj/debug: 
	@rm -f .obj/release
	@make clean
	@mkdir .obj
	@touch .obj/debug
	
.obj/release: 
	@rm -f .obj/debug
	@make clean
	@mkdir .obj
	@touch .obj/release
	
