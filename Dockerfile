FROM debian:stretch
LABEL maintainer="ken restivo <ken@restivo.org>" \
      original_maintainer="Luke Childs <lukechilds123@gmail.com>"

ENV HOME /root
WORKDIR /root

RUN apt-get update \
 && apt-get install -y \
    build-essential \
    cmake \
    curl \
    git \
    libcurl4-openssl-dev \
    sudo  \
 && rm -rf /var/lib/apt/lists/*


RUN git clone https://github.com/nanomsg/nanomsg && \
  cd nanomsg  \
  && cmake .  \
  && make  \
  && sudo make install \
  && sudo ldconfig \
  && cd ..  \
  && rm -rf nanomsg

RUN git clone https://github.com/jl777/SuperNET \
 && cd SuperNET/iguana \
 && git checkout spvdex \
 && ./m_mm \
 && cd .. \
 && mv ~/SuperNET/iguana/marketmaker /usr/local/bin  \
 && mv ~/SuperNET/iguana/exchanges/coins ~/coins  \
 && rm -rf ~/SuperNET

COPY ./bin /usr/local/bin
ENTRYPOINT ["init"]
EXPOSE 7783
