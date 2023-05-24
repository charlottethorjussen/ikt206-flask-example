FROM python:3.10

WORKDIR /app

COPY ./site .
RUN pip install --no-cache-dir -r requirements.txt psycopg2 gunicorn
EXPOSE 80
CMD gunicorn -w 4 -b 0.0.0.0:80 app:app
