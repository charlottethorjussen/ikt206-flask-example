FROM python:3.8-alpine

WORKDIR /app

COPY ./src .
RUN apk update && pip install --no-cache-dir -r requirements.txt 

EXPOSE 5000
CMD flask run --host=0.0.0.0 --port=5000