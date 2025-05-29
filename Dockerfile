FROM python:3.12-slim

RUN apt-get update && \
    apt-get install -y nginx supervisor curl && \
    apt-get clean

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

RUN rm /etc/nginx/sites-enabled/default
COPY config.nginx /etc/nginx/sites-enabled/flaskapp

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80

CMD ["/usr/bin/supervisord"]