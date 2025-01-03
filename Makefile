
FMT ?= html

.PHONY: docs
docs: venv
	venv/bin/sphinx-build -j auto -b $(FMT) -D language=en -d build/en/doctrees source dist/en

venv:
	python -m venv venv
	venv/bin/pip3 install -r requirements.txt

.PHONY: check
check: venv
	# ignore-messages is needed due to links being used in directives, which
	# are not visible by rstcheck as these directives are ignored (mostly faq)
	venv/bin/rstcheck --recursive --ignore-directives card,tabs,faq,product-table \
		--ignore-messages "faq(.*)Hyperlink target(.*)is not referenced" \
		source

pkg: venv docs
	mv dist/en/_images dist/_images
	rm -rf dist/*/_sources dist/*/_images
	cp redirects/.htaccess dist
	

clean: 
	rm -rf dist build

cleaner: clean
	rm -rf venv
	
.PHONY: docs check pkg
