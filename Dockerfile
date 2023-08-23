FROM python:3.7.17-slim
# check for curl
WORKDIR /app
COPY requirements.txt requirements.txt
RUN apt update && apt install -y rsync libpq-dev gcc bzip2 curl
RUN pip install -r requirements.txt

# COPY gutendex/.env gutendex/.env

COPY . .

RUN tar -xvf catalog_files/tmp/catalog.tar.bz2

ENTRYPOINT [ "./entry-point.sh" ]