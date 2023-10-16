-include .env
export

# checks if submodule is already loaded
ifeq ($(wildcard "build"),)
    $(shell git submodule update --init)
endif

EXTENSION=PageForms

MW_VERSION?=1.35
SMW_VERSION?=4.1.2
PHP_VERSION?=7.4
DT_VERSION?=3.1
PS_VERSION?=0.6.1
DB_TYPE?=sqlite
DB_IMAGE?=""

# check for build dir and git submodule init if it does not exist
include build/Makefile

