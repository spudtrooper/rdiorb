NAME=rdio
VERSION=0.0.98
DATE=$(shell date +"%Y-%m-%d")

.PHONY: test

%.gemspec:%.gemspec.in
	cat $< | sed \
		-e 's/%NAME%/$(NAME)/g' \
		-e 's/%DATE%/$(DATE)/g' \
		-e 's/%VERSION%/$(VERSION)/g' \
		> $@

.rdio_access_token: create_access_token
	chmod +x $<
	./$<

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

install: $(NAME)-$(VERSION).gem
	sudo gem install $<

rdoc:
	rdoc --title "Rd.io API" `find lib -name "*.rb"`

test:
	ruby test/suite.rb

runtest: test/test_*.rb
	@for f in $^; do\
		echo --- $$f ---;\
		ruby $$f;\
	done

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