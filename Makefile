REPO=luebken


cleanup:
	rm *.xpkg
	kubectl delete configuration ${REPO}-crossplane-test-config

build: cleanup
	kubectl crossplane build configuration
	kubectl crossplane push configuration ${REPO}/crossplane-test-config:v0.0.5

install: build
	kubectl crossplane install configuration ${REPO}/crossplane-test-config:v0.0.5
	kubectl get configuration
