FROM phusion/passenger-ruby22

RUN rm /etc/service/nginx/down
COPY nginx.default /etc/nginx/sites-available/default

COPY webapp /home/app/webapp
RUN chown -R app:app /home/app
