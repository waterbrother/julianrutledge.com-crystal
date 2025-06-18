########################################
# definitions
########################################
version := $(shell cat VERSION)
service	:= website
aws_account_id := $(shell aws sts get-caller-identity --query "Account" --output text)
aws_region := us-east-2
aws_ecr_name := julianrutledge
aws_ecr_root := $(aws_account_id).dkr.ecr.$(aws_region).amazonaws.com
image := $(aws_ecr_root)/$(aws_ecr_name)

########################################
# targets
########################################
# shards
shards-clean:
	@rm -rf lib/
	@rm -f shard.lock

shards-install:
	@/usr/bin/shards install

# crystal
crystal-run: shards-clean shards-install
	@crystal run src/julianrutledge.com.cr

crystal-build: shards-clean shards-install
	@crystal build src/julianrutledge.com.cr

# docker
docker-compose:
	@yq e -i '.services.$(service).image = "$(image):$(version)"' docker-compose.yaml

docker-shell: docker-compose
	@docker-compose run -it $(service)

docker-build: docker-compose
	@docker-compose build $(service)

docker-up: docker-compose
	@docker-compose up $(service)

docker-repo:
	@aws ecr create-repository --repository-name $(aws_ecr_name) --region $(aws_region)

docker-login:
	@aws ecr get-login-password --region $(aws_region) | docker login --username AWS --password-stdin $(aws_ecr_root)

docker-push: docker-login
	@docker push $(image):$(version)

# helm
helm-chart:
	@yq e -i '.deployment.container.image = "$(image):$(version)"' helm/values.yaml

helm-install:
	@helm upgrade --install $(aws_ecr_name) ./helm

