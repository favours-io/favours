FROM python:3.7-alpine

## psycopg2 dependencies
RUN apk update && \
    apk add --virtual build-deps gcc python3-dev musl-dev && \
    apk add postgresql-dev && \
    apk add build-base 

# Pillow dependencies
RUN apk --no-cache add python3 \
    jpeg-dev \
    zlib-dev \
    freetype-dev \
    lcms2-dev \
    openjpeg-dev \
    tiff-dev \
    tk-dev \
    tcl-dev \
    harfbuzz-dev \
    fribidi-dev

EXPOSE 8000

ADD . /favours

WORKDIR /favours

## add and install requirements
RUN pip install -r requirements.txt

# env variables
ENV DEBUG False
ENV SECRET_KEY 'test!5+-o_s*tl8ykeyCHANGE-ME'

RUN python manage.py migrate

CMD [ "python", "manage.py", "runserver", "0.0.0.0:8000" ] 