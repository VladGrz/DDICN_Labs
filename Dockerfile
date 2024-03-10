FROM nginx:latest
COPY ./index.html /usr/share/nginx/html/index.html
COPY ./css /usr/share/nginx/html/css
COPY ./img /usr/share/nginx/html/img