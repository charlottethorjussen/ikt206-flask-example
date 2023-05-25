FROM python:3.8-alpine

WORKDIR /app

COPY ./src .
RUN apk update && pip install --no-cache-dir -r requirements.txt 

CMD ["gunicorn", "--bind", "0.0.0.0:5001", "app:app"]