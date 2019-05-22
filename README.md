# builder

A generic makefile for use with small/medium C and C++ projects. Allows for easy project setup without the need to create tedious build rules or dependency lists.

Builder solve tasks:
1. Compile c, c++, asm file into objects.
2. Runs the linker, which creates an executable file.

The directory contains a simple makefile - `makefile_simple`.  
And makefile with many settings - `makefile_full`.

# How to use?

## Simple

1. Copy [makefile_simple](.makefile_simple) to your project.
2. Rename it to `makefile`.
3. Set correctly path to `builder/builder.mk` into variable.
4. Run `make` or `make all`.

Builder take all you source files (\*.c \*.cpp \*.s \*.S) from current directory and will try to compile these.
All subdirs in this directory added like `-I` to sources, for searching include files.

Your project structure may look something like this:

<div style="text-align:center"><img src ="Project_structure.png" /></div>

## Divide and rule

1. Copy [makefile_full](.makefile_full) to your project.
2. Rename it to `makefile`.
3. Set correctly path to `builder/builder.mk` into variable.
5. Set all variables as you like (see point [Settings]()).
4. Run `make` or `make all`.

# Settings

| Variable name | Description | Is it necessary? | Possible values | Default value	|
|---	|---	|---	|---	|---	|
| SILENCE | Is silent mode on? 	| No | `false` / `true` | `true` |
| PATH_TO_BUILDER |  |  |  |  `.` 	|
| DEPS_PATH |  |  |  | `.deps` |
| OBJS_PATH |  |  |  | `.objs` |
| BIN_PATH |  |  |  | `bin` |
| BUILD |  |  |  | `$(MAKECMDGOALS)` |
| NAME |  |  |  | `run_me` |
| AS |  |  | constant value | `gcc` |
| CC |  |  | constant value | `gcc` |
| CPP |  |  | constant value | `g++` |
| G_OPTION |  |  |  | `-g3` or `empty`. look [compile_settings.mk](.compile_settings.mk) |
| BFLAGS | Common flags passed to the C and C ++  compiler. You can add flags, but do this with `+=` | No | - | look [compile_settings.mk](.compile_settings.mk) |
| CFLAGS | Flags passed to the C compiler. You can add flags, but do this with `+=`. | No | - | look [compile_settings.mk](.compile_settings.mk) |
| CPPFLAGS | Flags passed to the C++ compiler. You can add flags, but do this with `+=`. | No | - | look [compile_settings.mk](.compile_settings.mk) |
| DEBUG | If defined -> this debug build, else this release build. |  | Anything. Checks whether a variable is defined. | `empty` |
| TYPE_OF_BUILD |  |  |  |  |
| DEFS | Adding defines to u code. You can add defines, but do this with `+=` | No | - | `$(TYPE_OF_BUILD)`  |
| LD |  |  | constant value | `g++`|
| LDFLAGS | Common linker flags. You can add flags, but do this with `+=`. |  | what u want. example: `LDFLAGS += -lgcov -lgtest -lgmock` | look [link.mk](link.mk) |
| ASM |  |  |  |  |
| SIZE_OUTPUT |  |  |  |  |
| OPTIMIZATION_LVL |  |  | [Optimize-Options](https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html) | `-Os` |
| CPP_STANDARD | Choose c++ standard. | No | [cxx-status](https://www.gnu.org/software/gcc/projects/cxx-status.html) | `-std=c++17` |
| FLTO | Flag -flto enabled? | No | Anything. Checks whether a variable is defined. | `-flto` or `empty`. look [settings.mk](.settings.mk) |
| DIRS | Path to directories for searching include files. | Yes | - | empty |
| SOURCES | Path to source files. | Yes | - | empty |
