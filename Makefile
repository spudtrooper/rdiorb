NAME=rdio
VERSION=0.0.1
DATE=$(shell date +"%Y-%m-%d")

.PHONY: runtest

%.gemspec:%.gemspec.in
	cat $< | sed \
		-e 's/%NAME%/$(NAME)/g' \
		-e 's/%DATE%/$(DATE)/g' \
		-e 's/%VERSION%/$(VERSION)/g' \
		> $@

$(NAME)-$(VERSION).gem: $(NAME).gemspec
	gem build $<

lib/rdio/datatypes.rb: gen_types
	chmod +x $<
	./$< > $@

lib/rdio/api.rb: gen_api
	chmod +x $<
	./$< > $@

all: $(NAME)-$(VERSION).gem

push: $(NAME)-$(VERSION).gem
	gem push 

runtest:
	ruby test/suite.rb

api: lib/rdio/api.rb
datatypes: lib/rdio/datatypes.rb

tests:
	chmod +x $(NAME)
	./$(NAME) test/logfile.txt

clean:
	rm -f `find . -name "*~"` $(NAME).gemspec $(NAME)-*.gem