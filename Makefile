ROLE := fzf 

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: roles
roles: $(ROLE)

.PHONY: $(ROLE)
	@make $(ROLE)=$@ test

.PHONY: shellcheck
shellcheck: ## Run shellcheck test
	docker run --rm -it -v "${PWD}:/mnt" koalaman/shellcheck:v0.7.0 *.sh

.PHONY: test
test:
	if ! ./check-role-changed.sh ; then \
		exit 0; \
	fi

	cd ./${ROLE} && molecule test --parallel

deploy:
	ansible-playbook -i hosts -e ansible_python_interpreter=/usr/bin/python3 --ask-become-pass ./dev-env.yml