FROM docker.io/node:21 as build

ENV CYBERCHEF_VERSION master

RUN chown -R node:node /srv

USER node
WORKDIR /srv

RUN git clone -b "$CYBERCHEF_VERSION" --depth=1 https://github.com/gchq/CyberChef.git .
RUN npm install

ENV NODE_OPTIONS="--max-old-space-size=2048"
RUN npx grunt prod


FROM docker.io/nginxinc/nginx-unprivileged:alpine

LABEL org.opencontainers.image.author="benjitrapp.github.io"

COPY --from=build /srv/build/prod /usr/share/nginx/html

RUN sed -i \
    -e 's/listen       8080;/listen       8000;/g' \
    -e '/listen       8000;/a\' \
    -e '    listen       [::]:8000;' /etc/nginx/conf.d/default.conf
    

EXPOSE 8000
