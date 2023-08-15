FROM python:3.8-slim as python-base

# ENV
ENV DOCKER=true
ENV HIKKAHOST=true
ENV GIT_PYTHON_REFRESH=quiet

ENV PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Packets
#RUN apt update && apt install curl libcairo2 git ffmpeg libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavdevice-dev neofetch wkhtmltopdf -y --no-install-recommends
#RUN rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp/*

#RUN apt-get update && apt-get install -y \
#    build-essential  \
#    gcc \
#    libmagic1 \
#    python3-dev --no-install-recommends \
#    && rm -rf /var/lib/apt/lists/*

# Node.js
#RUN curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
#RUN bash nodesource_setup.sh
#RUN apt-get install -y nodejs

# Perms, catalogs and user
RUN mkdir /home/user

#COPY . /home/user/Hikka
RUN mkdir /data
COPY . /data/Hikka
WORKDIR /data/Hikka

RUN pip install --no-warn-script-location --no-cache-dir -U -r requirements.txt

EXPOSE 8080

# Run
CMD python -m hikka --port 8080
