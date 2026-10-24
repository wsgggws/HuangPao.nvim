NVIM ?= nvim

.PHONY: test test-dark test-light

test:
	SHEEPSKIN_TEST_VARIANT=auto $(NVIM) --headless --clean -l tests/smoke.lua

test-dark:
	SHEEPSKIN_TEST_VARIANT=dark $(NVIM) --headless --clean -l tests/smoke.lua

test-light:
	SHEEPSKIN_TEST_VARIANT=light $(NVIM) --headless --clean -l tests/smoke.lua
