# Backend commands for Docker
# Internal Variable
CONTAINER_NAME := kenesparta/fibonacci-wasm
CONTAINER_NAME_FRONT := kenesparta/fibonacci-wasm-front

.PHONY : be/build
be/build:
	docker buildx build \
		--platform wasi/wasm32 \
		-t $(CONTAINER_NAME):$(version) \
		--provenance=false \
		-f DockerfileBackend .

.PHONY : be/push
be/push:
	 docker push $(CONTAINER_NAME):$(version)

.PHONY : be/run
be/run:
	docker run -i \
		--rm \
		--runtime=io.containerd.wasmedge.v1 \
		--platform=wasi/wasm32 \
		--name=fibonacci-be \
		$(CONTAINER_NAME):$(version)

.PHONY : be/build-push
be/build-push: be/build be/push

# Frontend commands
.PHONY : fe/build
fe/build:
	docker buildx build \
		--platform linux/amd64 \
		-t $(CONTAINER_NAME_FRONT):$(version) \
		-f DockerfileFrontend .

.PHONY : fe/run
fe/run:
	docker run --rm \
		-p 8080:8080 \
		--name fibonacci-nginx \
		$(CONTAINER_NAME_FRONT):$(version)

fe/push:
	 docker push $(CONTAINER_NAME_FRONT):$(version)

fe/push-gcp:
	gcloud auth activate-service-account --key-file=sa.json
	gcloud auth configure-docker us-central1-docker.pkg.dev
	docker tag $(CONTAINER_NAME_FRONT):$(version) us-central1-docker.pkg.dev/dockerayacucho/fibo-wasm-$(id)/$(CONTAINER_NAME_FRONT):$(version)
	docker push us-central1-docker.pkg.dev/dockerayacucho/fibo-wasm-$(id)/$(CONTAINER_NAME_FRONT):$(version)
