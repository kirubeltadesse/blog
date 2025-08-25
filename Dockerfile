FROM ubuntu:22.04 

RUN apt-get update && apt-get install -y \
    wget \
    pandoc \
    libssl-dev \
    libcurl4 \
    libicu70

# Install Quarto
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.7.33/quarto-1.7.33-linux-arm64.deb \
    && apt-get install -y ./quarto-1.7.33-linux-arm64.deb \
    && rm quarto-1.7.33-linux-arm64.deb

RUN quarto add mcanouil/quarto-iconify

WORKDIR /docs

EXPOSE 5555

COPY . /docs/

RUN quarto render

