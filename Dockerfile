FROM node:14-slim
# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

# If you are building your code for dev/testing
# RUN npm install
# If you are building your code for production
RUN npm ci --only=production

# Bundle app source
COPY . .

ENV NODE_ENV="production"

# Expose the network port that your app is using
# eg. if your server runs on 8080, this should be 8080
# EXPOSE 3000 # Apparently don't expose as most deployment platforms set it as an ENV variable anyway??

# Command to run the server goes here
CMD [ "npm", "start" ]