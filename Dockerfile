# Dockerfile

# Pull base image
FROM python:3.13.2-alpine

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install system dependencies
RUN apk update && apk add --no-cache ca-certificates tzdata netcat-openbsd autoconf libtool automake make pkgconf
RUN apk add gcc libc-dev libffi-dev postgresql-dev postgresql-libs zlib-dev jpeg-dev musl-dev

# Set work directory
WORKDIR /usr/src/keycard_shell

# Install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# Copy project
COPY . .

# fix entrypoint.sh
RUN sed -i 's/\r$//g' /usr/src/keycard_shell/entrypoint.sh
RUN chmod +x /usr/src/keycard_shell/entrypoint.sh

# run entrypoint.sh
ENTRYPOINT ["/usr/src/keycard_shell/entrypoint.sh"]
