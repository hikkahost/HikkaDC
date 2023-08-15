FROM python:3.8-slim as python-base

# ENV
ENV DOCKER=true
ENV HIKKAHOST=true
ENV GIT_PYTHON_REFRESH=quiet

ARG username

ENV PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

RUN sudo hostname $username-hikkahost

# Packets
RUN apt update && apt install -y \
    libcairo2 \
    git \
    build-essential \
    neofetch --no-install-recommends \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp/*

RUN apt-get update && apt-get install -y \
    build-essential  \
    gcc \
    libmagic1 \
    python3-dev --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /data
COPY . /data/Hikka
WORKDIR /data/Hikka

RUN pip install --no-warn-script-location --no-cache-dir -U -r requirements.txt

EXPOSE 8080

# Run
CMD python -m hikka
