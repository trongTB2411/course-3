FROM python:3.10-slim-buster

USER root

RUN apt update -y && apt install postgresql postgresql-contrib -y

WORKDIR /src
ENV DB_NAME=mydatabase
ENV DB_PASSWORD="mypassword"
ENV DB_USERNAME=myuser
ENV DB_HOST=127.0.0.1
env DB_PORT=5433

COPY ./analytics/requirements.txt requirements.txt

# Dependencies are installed during build time in the container itself so we don't have OS mismatch
RUN pip install -r requirements.txt

COPY ./analytics .

RUN python --version

# Start the database and Flask application
CMD service postgresql start && python app.py
