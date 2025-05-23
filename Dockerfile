
FROM python:3.10-slim AS builder

ENV PIP_NO_CACHE_DIR=1

RUN apt-get update && apt-get install -y --no-install-recommends \
	git python3-dev gcc && \
	rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/*

RUN git clone -b Test https://github.com/Roger-git-cmd/Djtjtdhrsutdjtvjbvkhgoufl7fi6du5d7464e47du5dy4dutdkyfkug.igitl7fi6du4a4uaurdktsrusu5sitdgjfjbvkhfiy /Hikka

RUN python -m venv /Hikka/venv

RUN /Hikka/venv/bin/python -m pip install --upgrade pip

RUN /Hikka/venv/bin/pip install --no-warn-script-location --no-cache-dir -r /Hikka/requirements.txt

FROM python:3.10-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
	curl libcairo2 git ffmpeg libmagic1 libavcodec-dev libavutil-dev libavformat-dev \
	libswscale-dev libavdevice-dev neofetch wkhtmltopdf gcc python3-dev && \
	curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && apt-get install -y nodejs && \
	rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/* && apt-get clean

ENV DOCKER=true \
	GIT_PYTHON_REFRESH=quiet \
	PIP_NO_CACHE_DIR=1 \
	PATH="/Hikka/venv/bin:$PATH"

COPY --from=builder /Hikka /Hikka

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /Hikka

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
