FROM registry.access.redhat.com/ubi8/nodejs-12

ARG PRINT_ME="this was not set"
RUN echo "print_me value: $PRINT_ME" \
  && mkdir ~/.npm-global \
  && npm config set prefix '~/.npm-global' \
  && npm config set strict-ssl false \
  ;

WORKDIR /opt/app-root
COPY package*.json ./
COPY app.js ./
RUN npm install

EXPOSE 3000
CMD ["node", "app.js"]
