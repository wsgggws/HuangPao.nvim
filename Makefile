NVIM ?= nvim
PYTHON ?= python3

.PHONY: test

test:
	$(NVIM) --headless --clean -l tests/smoke.lua
	$(NVIM) --headless -u scripts/preview.lua -c 'luafile tests/preview.lua'
	$(PYTHON) -m unittest discover -s tests -p 'test_*.py' -v
