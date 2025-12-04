FROM klakegg/hugo:latest AS hugo

FROM ubuntu:22.04 

RUN apt-get update && apt-get install -y \
    wget \
    pandoc \
    libssl-dev \
    libcurl4 \
    libicu70

# Install Quarto
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.7.33/quarto-1.7.33-linux-amd64.deb \
    && dpkg -i quarto-1.7.33-linux-amd64.deb \
    && rm quarto-1.7.33-linux-amd64.deb

# Copy Hugo from the klakegg image
COPY --from=hugo /usr/lib/hugo/hugo /usr/local/bin/hugo

WORKDIR /site

EXPOSE 1313

COPY . /site/

# Render Quarto files to Hugo markdown, then build with Hugo
RUN quarto render && hugo --gc --minify

