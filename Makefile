IMAGE_NAME=hello-world-printer
TAG=$(DOCKER_USERNAME)/hello-world-printer-k3-2026

deps:
	pip install -r requirements.txt
	pip install -r test_requirements.txt

lint:
	flake8 hello_world test

run:
	python main.py

docker_build:
	docker build -t $(IMAGE_NAME) .

docker_run: docker_build
	docker run --name hello-world-printer-dev -p 5000:5000 -d $(IMAGE_NAME)

docker_push: docker_build
	@test -n "$$DOCKER_USERNAME" || (echo "DOCKER_USERNAME is empty"; exit 1)
	@test -n "$$DOCKER_PASSWORD" || (echo "DOCKER_PASSWORD is empty"; exit 1)
	@echo "$$DOCKER_PASSWORD" | docker login --username "$$DOCKER_USERNAME" --password-stdin
	docker tag $(IMAGE_NAME) $$DOCKER_USERNAME/hello-world-printer-k3-2026
	docker push $$DOCKER_USERNAME/hello-world-printer-k3-2026
	docker logout

.PHONY: deps lint run docker_build docker_run docker_push test

test:
	PYTHONPATH=. py.test --verbose -s