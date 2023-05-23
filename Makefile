# vim:ft=make:
APP_NAME="benjitrapp/cyberchef"

.PHONY: all build github

all: build start

build:
	docker build --build-arg -t $(APP_NAME):latest .

github:
		docker pull ghcr.io/benjitrapp/boxed-cyberchef:main
		docker run -d --rm -p 8000:8000 --name boxed-cyberchef ghcr.io/benjitrapp/boxed-cyberchef:main
		echo "Browse to 'http://localhost:8000'" 

clean:
	docker rmi $(APP_NAME):latest

start:
	docker run -d --rm -p 8000:8000 --name boxed-cyberchef $(APP_NAME):latest

stop:
	docker rm -f boxed-cyberchef

debug:
	docker run -it --rm $(APP_NAME):latest bash

browser:
	browse 'http://localhost:8000' | sh -e