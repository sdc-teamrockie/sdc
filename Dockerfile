# install node.js
FROM node:14

# add app source code to image
# WORKDIR is like cd into a directory
WORKDIR /SDC

# copy first for caching
COPY package*.json ./

RUN npm install
# copying over source code
COPY . .


CMD ["node", "server/server.js"]