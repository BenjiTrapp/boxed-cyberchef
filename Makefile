# vim:ft=make:
APP_NAME="benjitrapp/cyberchef"

.PHONY: all build start stop

all: build start

build:
	docker build --build-arg -t $(APP_NAME):latest .

clean:
	docker rmi $(APP_NAME):latest

start:
	docker run -d --rm -p 8000:8000 --name boxed-cyberchef $(APP_NAME):latest

stop:
	docker rm -f boxed-cyberchef

debug:
	docker run -it --rm $(APP_NAME):latest bash
