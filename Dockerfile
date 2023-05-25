RUN apk update
RUN apk add py-pip
RUN apk add --no-cache python3-dev 
RUN pip install --upgrade pip

WORKDIR /app

COPY ./src .
RUN pip install --no-cache-dir -r requirements.txt 

# EXPOSE 5000

CMD ["python3", "app.py"]
# CMD flask run --host=0.0.0.0 --port=5000