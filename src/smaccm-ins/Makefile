IVORY_REPO ?= ../../../ivory
TOWER_REPO ?= ../../../tower
BSP_REPO ?= ../../../ivory-tower-stm32

.PHONY: psas-test
psas-test: cabal.sandbox.config
	cabal run --only codegen -- --src-dir=psas-test --const-fold --no-sanity-check
	make -C psas-test

create-sandbox: cabal.sandbox.config

.PRECIOUS: cabal.sandbox.config
cabal.sandbox.config:
	cabal sandbox init
	cabal sandbox add-source $(IVORY_REPO)/ivory
	cabal sandbox add-source $(IVORY_REPO)/ivory-artifact
	cabal sandbox add-source $(IVORY_REPO)/ivory-backend-c
	cabal sandbox add-source $(IVORY_REPO)/ivory-hw
	cabal sandbox add-source $(IVORY_REPO)/ivory-opts
	cabal sandbox add-source $(IVORY_REPO)/ivory-serialize
	cabal sandbox add-source $(IVORY_REPO)/ivory-stdlib
	cabal sandbox add-source $(TOWER_REPO)/tower
	cabal sandbox add-source $(TOWER_REPO)/tower-config
	cabal sandbox add-source $(BSP_REPO)/ivory-bsp-stm32
	cabal sandbox add-source $(BSP_REPO)/ivory-freertos-bindings
	cabal sandbox add-source $(BSP_REPO)/tower-freertos-stm32
	cabal sandbox add-source ../ivory-px4-hw
	cabal install --dependencies-only

clean:
	-rm -rf psas-test dist

clean-sandbox:
	-rm -rf .cabal-sandbox
	-rm cabal.sandbox.config
