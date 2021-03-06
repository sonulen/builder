# builder

A generic makefiles for use with small/medium C and C++ projects. Allows for easy project setup without the need to create tedious build rules or dependency lists.

**builder** solves the following problems:
1. Compiling a c, c ++, asm files into objects.
2. Runs the linker, which creates an executable file.

Repository contains a simple makefile for example - `makefile_simple`.  
And makefile with many settings - `makefile_full`.

---

Your project structure may look something like this:

<div style="text-align:center"><img src ="Project_structure.png" /></div>

# How to use?

## Simple

1. Copy [makefile_simple](makefile_simple) to your project.
2. Rename it to `makefile`.
3. Set correctly path to `builder/builder.mk` into corresponding variable (`PATH_TO_BUILDER`).
4. Run `make` or `make all`.

**Builder** take all you source files (\*.c \*.cpp \*.s \*.S) from current directory and will try to compile these.

All subdirs in this directory added like `-I` to sources, for searching include files.

## Divide and rule

1. Copy [makefile_full](makefile_full) to your project.
2. Rename it to `makefile`.
3. Set correctly path to `builder/builder.mk` into corresponding variable (`PATH_TO_BUILDER`).
5. Set all variables as you like (look at [Settings](#settings)).
4. Run `make` or `make all`.

# Settings

| Variable name | Description | Is it necessary? | Possible values | Default value	|
|---	|---	|---	|---	|---	|
| SILENCE | Is silent mode on? 	| No | `on` / `off` | `on` |
| PATH_TO_BUILDER | Path to `builder.mk` file   | No | - |  `builder/` 	|
| DEPS_PATH | Path where to create dependencies files | No | - | `.deps` |
| OBJS_PATH | Path where to create object files | No | - | `.objs` |
| BIN_PATH | Path where to create executable file | No | - | `bin` |
| NAME | The name of the resulting file | No | - | `run_me` |
| AS | Assembler compiler | - | constant value | `gcc` |
| CC | C compiler | - | constant value | `gcc` |
| CPP | Cpp compiler | - | constant value | `g++` |
| G_OPTION | Flag to generates debug information to be used by GDB debugger | No | `-g` / `-g0` / `-g1` / `-g3` | `-g3` or `empty`. look [compile_settings.mk](compile_settings.mk) |
| BFLAGS | Common flags passed to the C and C ++  compiler. You can add flags, but do this with `+=` | No | - | look [compile_settings.mk](compile_settings.mk) |
| CFLAGS | Flags passed to the C compiler. You can add flags, but do this with `+=`. | No | - | look [compile_settings.mk](compile_settings.mk) |
| CPPFLAGS | Flags passed to the C++ compiler. You can add flags, but do this with `+=`. | No | - | look [compile_settings.mk](compile_settings.mk) |
| DEBUG | If defined -> this debug build, else this release build. | No | Anything. Checks whether a variable is defined. | `empty` |
| TYPE_OF_BUILD | If DEBUG defined takes `DEBUG` else `RELEASE`  | No | Automatic variable | `RELEASE` |
| DEFS | Adding defines to u code. You can add defines, but do this with `+=` | No | - | `$(TYPE_OF_BUILD)`  |
| LD | Linker | - | constant value | `g++`|
| LDFLAGS | Common linker flags. You can add flags, but do this with `+=`. | No | what u want. example: `LDFLAGS += -lgcov -lgtest -lgmock` | look [link.mk](link.mk) |
| ASM | Do need to create an ASM file? If the value is "on" then the file will be generated. | No | `on` / `anything` | empty |
| SIZE_OUTPUT | Format to print size | No | `berkeley` / `SysV` | `berkeley` |
| OPTIMIZATION_LVL | Setting the code optimization level | No | [Optimize-Options](https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html) | `-Os` |
| CPP_STANDARD | Choose c++ standard. | No | [cxx-status](https://www.gnu.org/software/gcc/projects/cxx-status.html) | `-std=c++17` |
| FLTO | Flag -flto enabled? | No | Anything. Checks whether a variable is defined. | `-flto` or `empty`. look [settings.mk](settings.mk) |
| DIRS | Path to directories for searching include files. | Yes | - | empty |
| SOURCES | Path to source files. | Yes | - | empty |

# Output example

If u set `SILENCE == off` you can see all variables:

```shell                                 
Info from builder.mk file:
Path to builder.mk = builder/builder.mk
Path to common.mk = builder/common.mk
Path to settings.mk = builder/settings.mk
Path to compile.mk = builder/compile.mk
Path to link.mk = builder/link.mk

Info from common.mk file:
Binary file path = bin
Deps file path = .deps
Objs file path = .objs
Build type = all
Name of result file = runnable

Info from settings.mk file:
Optimization level = -Os
Type of build = RELEASE
Cpp standard = -std=c++17
Flto flag = -flto

Info from compile_settings.mk file:
Sources files = ./class.cpp ./telemetry/telemetry.cpp ./main.cpp
Object files = .objs/./class.o .objs/./telemetry/telemetry.o .objs/./main.o
Deps files = .deps/./class.d .deps/./telemetry/telemetry.d .deps/./main.d
Include dirs (with headers) = . ./bin ./telemetry ./builder
Defines = RELEASE
Flags for C = -Os -flto -Wall  -Wextra -Werror -ffunction-sections
Flags for C++ = -Os -flto -Wall  -Wextra -Werror -ffunction-sections -pthread -std=c++17
Common deps for sources =  makefile builder/builder.mk builder/common.mk builder/settings.mk builder/compile.mk builder/prebuild.mk builder/compile_settings.mk

Info from link.mk file:
Linker = g++
Linker C flags = -Wl,--no-as-needed -pthread -Wall -g3 -Wextra -Werror
Linker flags = -Xlinker --gc-sections -o  -Wl,-Map="bin/runnable.map"  -lm

[CPP] class.cpp
[CPP] telemetry/telemetry.cpp
[CPP] main.cpp

[LD] bin/runnable.elf

Size summary:
  text    data     bss     dec     hex filename
  2172     696     280    3148     c4c bin/runnable.elf
```
