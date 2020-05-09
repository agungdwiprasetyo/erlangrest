build-docker:
	docker build -t erlangrest:latest .

run-container:
	docker run --name=erlangrest -p 4000:4000 -d erlangrest