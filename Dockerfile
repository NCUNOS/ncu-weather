FROM crystallang/crystal:0.18.2

WORKDIR /tmp

RUN apt-get update
RUN apt-get install -y gcc dpkg-dev cdbs automake autoconf libtool make libssl-dev libsasl2-dev git python-lxml pkg-config
RUN git clone https://github.com/mongodb/mongo-c-driver.git
RUN cd mongo-c-driver && git checkout 1.3.5 && ./autogen.sh --with-libbson=bundled && make && make install

ADD . /ncu_weather
WORKDIR /ncu_weather

RUN crystal deps
RUN crystal build --release -o build/web src/web.cr
RUN crystal build --release -o build/crawler src/crawler.cr
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/bin/sh", "entrypoint.sh"]
