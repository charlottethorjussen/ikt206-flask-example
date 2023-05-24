FROM python:3.8-alpine

COPY ./ /work
RUN apk update && pip install -r /work/requirements.txt --no-cache-dir
RUN pip install --no-cache-dir -r requirements.txt psycopg2 gunicorn
EXPOSE 80
CMD gunicorn -w 4 -b 0.0.0.0:80 work:app