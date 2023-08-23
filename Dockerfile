FROM python:3.7.17

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

RUN apt update && apt install -y rsync

COPY gutendex/.env gutendex/.env

COPY . .

RUN tar -xvf catalog_files/tmp/catalog.tar.bz2

ENTRYPOINT [ "./entry-point.sh" ]