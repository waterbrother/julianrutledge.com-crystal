FROM crystallang/crystal:1.16-alpine

LABEL maintainer="julian@julianrutledge.com"

EXPOSE 8080

RUN mkdir /web

COPY . /web

WORKDIR /web

RUN make shards-clean

RUN make shards-install

RUN make crystal-build

CMD [ "./julianrutledge.com" ]

