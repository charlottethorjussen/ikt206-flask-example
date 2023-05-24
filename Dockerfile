# Use an official Python runtime as a parent image
FROM python:3.10

# Set the working directory to /app
WORKDIR /app

# Copy the site directory contents into the container at /app
COPY ./src .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt gunicorn

ENV FLASK_APP=app.py
ENV FLASK_ENV=testing

# Expose port 80 for the Flask app to listen on
EXPOSE 80

# start the app
CMD gunicorn -w 4 -b 0.0.0.0:80 app:app
