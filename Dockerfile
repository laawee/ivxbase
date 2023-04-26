ADD file:7fd90c097e2c4587dee91726d71abc02fa1aa6a3a3395c862206a4e14e0c299c in / 
CMD ["/bin/sh"]
/bin/sh -c apk add --no-cache --update libgcc libstdc++ ca-certificates libcrypto1.1 libssl1.1 libgomp expat git
LABEL org.opencontainers.image.authors=julien@rottenberg.info org.opencontainers.image.source=https://github.com/jrottenberg/ffmpeg
ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64
CMD ["--help"]
ENTRYPOINT ["ffmpeg"]
COPY dir:8b8036556bae1c909564b2e9b63ee04956b5512d750eb83aa1785e24d26a1fb0 in /usr/local 
RUN /bin/sh -c sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories &&     apk add --update ca-certificates &&     apk add tzdata &&     ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&     echo "Asia/Shanghai" > /etc/timezone &&     rm -rf /var/cache/apk/* /tmp/* # buildkit
ARG TARGETARCH
ADD ivxbase_arm64 /ivxbase # buildkit
RUN |1 TARGETARCH=arm64 /bin/sh -c chmod +x /ivxbase # buildkit
WORKDIR /
ENTRYPOINT ["/ivxbase"]
