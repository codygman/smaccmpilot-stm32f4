# -*- Mode: makefile-gmake; indent-tabs-mode: t; tab-width: 2 -*-
#
# build.mk
#
# Copyright (C) 2012, Galois, Inc.
# All Rights Reserved.
#
# This software is released under the "BSD3" license.  Read the file
# "LICENSE" for more information.
#
# Written by Pat Hickey <pat@galois.com>, January 08, 2013
#

$(eval $(call tower_pkg,IVORY_PKG_TOWER_EXAMPLE_STM32F4SIGNAL,tower-example-stm32f4signal))

APP_TOWER_EXAMPLE_STM32F4SIGNAL_IMG          := tower-example-stm32f4signal

APP_TOWER_EXAMPLE_STM32F4SIGNAL_OBJECTS      := main.o
APP_TOWER_EXAMPLE_STM32F4SIGNAL_REAL_OBJECTS += $(IVORY_PKG_TOWER_EXAMPLE_STM32F4SIGNAL_OBJECTS)

APP_TOWER_EXAMPLE_STM32F4SIGNAL_INCLUDES     += $(FREERTOS_INCLUDES)

APP_TOWER_EXAMPLE_STM32F4SIGNAL_CFLAGS        = $(APP_TOWER_EXAMPLE_STM32F4SIGNAL_INCLUDES)
APP_TOWER_EXAMPLE_STM32F4SIGNAL_CFLAGS       += $(IVORY_PKG_TOWER_EXAMPLE_STM32F4SIGNAL_CFLAGS)
APP_TOWER_EXAMPLE_STM32F4SIGNAL_CXXFLAGS      = $(APP_TOWER_EXAMPLE_STM32F4SIGNAL_INCLUDES)
APP_TOWER_EXAMPLE_STM32F4SIGNAL_CXXFLAGS     += $(IVORY_PKG_TOWER_EXAMPLE_STM32F4SIGNAL_CFLAGS)

APP_TOWER_EXAMPLE_STM32F4SIGNAL_LIBRARIES    += libFreeRTOS.a

APP_TOWER_EXAMPLE_STM32F4SIGNAL_LIBS         += -lm

$(eval $(call when_os,freertos,image,APP_TOWER_EXAMPLE_STM32F4SIGNAL))

# vim: set ft=make noet ts=2:
