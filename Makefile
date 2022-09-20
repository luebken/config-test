REPO=luebken
VERSION=v0.0.10
NAME=$(shell cat crossplane.yaml | yq .metadata.name)

default:
	@echo using REPO=${REPO}, NAME=${NAME}, VERSION=${VERSION} 

cleanup:
	-rm *.xpkg
	-kubectl delete configuration ${REPO}-$(NAME)

build: cleanup
	kubectl crossplane build configuration
	kubectl crossplane push configuration ${REPO}/$(NAME):${VERSION}

build-with-up: 
	up xpkg build --examples-root examples
	up xpkg push --create ${REPO}/$(NAME):${VERSION}
	open https://marketplace.upbound.io/configurations/${REPO}/$(NAME)/${VERSION}


install: build
	kubectl crossplane install configuration ${REPO}/$(NAME):${VERSION}
	kubectl get configuration