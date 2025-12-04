FROM ubuntu:22.04 

RUN apt-get update && apt-get install -y \
    wget \
    git

# Install Hugo
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.146.0/hugo_extended_0.146.0_linux-amd64.deb \
    && dpkg -i hugo_extended_0.146.0_linux-amd64.deb \
    && rm hugo_extended_0.146.0_linux-amd64.deb

WORKDIR /site

EXPOSE 1313

COPY . /site/

RUN hugo --gc --minify

