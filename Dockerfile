FROM python:3.5-alpine

ADD requirements.txt /
RUN set -ex \
	&& apk update \
	&& apk add --no-cache --virtual .build-deps \
		gcc \
		make \
		libc-dev \
		musl-dev \
		linux-headers \
		postgresql-dev \
		libjpeg-turbo-dev \
		libpng-dev \
		freetype-dev \
		libxslt-dev \
		libxml2-dev \
		zlib-dev \
	&& pyvenv /venv \
	&& LIBRARY_PATH=/lib:/usr/lib /bin/sh -c "/venv/bin/pip install -r /requirements.txt" \
	&& runDeps="$( \
		scanelf --needed --nobanner --recursive /venv \
			| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
			| sort -u \
			| xargs -r apk info --installed \
			| sort -u \
	)" \
	&& apk add --virtual .python-rundeps $runDeps \
	&& apk del .build-deps
RUN mkdir /code/
WORKDIR /code/
ADD . /code/
RUN SECRET_KEY=none /venv/bin/python manage.py collectstatic --noinput
ENV UWSGI_VIRTUALENV=/venv
CMD ["/venv/bin/uwsgi"]
