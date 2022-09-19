REPO=luebken


cleanup:
	rm *.xpkg
	kubectl delete configuration ${REPO}-crossplane-test-config

build:m
	kubectl crossplane build configuration
	docker import crossplane-test-config-*.xpkg ${REPO}/crossplane-test-config:v0.0.1
	docker push ${REPO}/crossplane-test-config:v0.0.1

install: 
	kubectl crossplane install configuration ${REPO}/crossplane-test-config:v0.0.1
	kubectl get configuration
