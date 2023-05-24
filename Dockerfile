FROM python:3.8-alpine

WORKDIR /app

COPY ./src .
RUN apk update && pip install --no-cache-dir -r requirements.txt gunicorn
EXPOSE 80
CMD gunicorn -w 4 -b 0.0.0.0:80 app:app
