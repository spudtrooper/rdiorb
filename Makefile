NAME=rdio
VERSION=0.0.2
DATE=$(shell date +"%Y-%m-%d")

.PHONY: test

%.gemspec:%.gemspec.in
	cat $< | sed \
		-e 's/%NAME%/$(NAME)/g' \
		-e 's/%DATE%/$(DATE)/g' \
		-e 's/%VERSION%/$(VERSION)/g' \
		> $@

$(NAME)-$(VERSION).gem: $(NAME).gemspec rdoc
	gem build $<

lib/rdio/datatypes.rb: gen_types
	chmod +x $<
	./$< > $@

lib/rdio/api.rb: gen_api
	chmod +x $<
	./$< > $@

all: $(NAME)-$(VERSION).gem

push: $(NAME)-$(VERSION).gem
	gem push $<

rdoc:
	rdoc --title "Rd.io API" `find lib -name "*.rb"`

test:
	ruby test/suite.rb

api: lib/rdio/api.rb
datatypes: lib/rdio/datatypes.rb

tests:
	chmod +x $(NAME)
	./$(NAME) test/logfile.txt

clean:
	rm -f `find . -name "*~"` $(NAME).gemspec $(NAME)-*.gem

docclean:
	rm -rf doc

allclean: docclean clean