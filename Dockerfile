FROM node
WORKDIR root/blog
RUN npm install -g hexo-cli \
    && hexo init /root/blog \
    && cd /root/blog \
    && npm install
RUN npm install hexo-server --save
CMD ["hexo", "server"]