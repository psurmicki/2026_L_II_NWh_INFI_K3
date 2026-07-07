IMAGE_NAME=hello-world-printer
TAG=$(USERNAME)/hello-world-printer-k3-2026

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
	@echo "$$DOCKER_PASSWORD" | docker login --username "$(USERNAME)" --password-stdin
	docker tag $(IMAGE_NAME) $(TAG)
	docker push $(TAG)
	docker logout

.PHONY: deps lint run docker_build docker_run docker_push test

test:
	PYTHONPATH=. py.test --verbose -s