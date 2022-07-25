########################################
# definitions
########################################
service	:= website

########################################
# targets
########################################
# shards
shards-clean:
	@rm -rf lib/

shards-install:
	@/usr/bin/shards install

# crystal
crystal-run:
	@crystal run src/julianrutledge.com.cr

crystal-build:
	@crystal build src/julianrutledge.com.cr

# docker
docker-shell:
	@docker-compose run -it $(service)

docker-build:
	@docker-compose build $(service)

docker-up:
	@docker-compose up $(service)

