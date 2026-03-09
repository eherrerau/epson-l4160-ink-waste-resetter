FROM python:3.7.5

RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list \
    && sed -i 's|http://security.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list \
    && sed -i '/buster-updates/d' /etc/apt/sources.list
RUN apt-get update -o Acquire::Check-Valid-Until=false
RUN apt-get install libsnmp-dev -y

WORKDIR /code
COPY resetter.py .
COPY requirements.txt .

RUN pip install -r requirements.txt

ENTRYPOINT ["python", "resetter.py"]

