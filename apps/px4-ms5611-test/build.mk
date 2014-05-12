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

$(eval $(call tower_pkg,IVORY_PKG_MS5611_TEST,px4-ms5611-test-gen))

PX4_MS5611_TEST_IMG          := px4-ms5611-test

PX4_MS5611_TEST_OBJECTS      := freertos/main.o
PX4_MS5611_TEST_LIBRARIES    += libFreeRTOS.a
PX4_MS5611_TEST_INCLUDES     += $(FREERTOS_CFLAGS)

PX4_MS5611_TEST_REAL_OBJECTS += $(IVORY_PKG_MS5611_TEST_OBJECTS)
PX4_MS5611_TEST_CFLAGS       += $(IVORY_PKG_MS5611_TEST_CFLAGS)
PX4_MS5611_TEST_CFLAGS       += $(PX4_MS5611_TEST_INCLUDES)


$(eval $(call cbmc_pkg,PX4_MS5611_TEST,IVORY_PKG_MS5611_TEST))

$(eval $(call when_os,freertos,image,PX4_MS5611_TEST))
$(eval $(call when_os,echronos,echronos_gen,PX4_MS5611_TEST))
$(eval $(call when_os,echronos,image,PX4_MS5611_TEST))