FROM node:16-alpine

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install app dependencies
COPY ./NFT-Minter/package.json ./

RUN npm install

# add app
COPY ./NFT-Minter ./

# start app
CMD ["npm", "start", "--disableHostCheck", "true"]   