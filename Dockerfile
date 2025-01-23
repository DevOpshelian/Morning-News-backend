FROM node:16.20.2-buster
RUN mkdir -p /home/node/app/node_modules 
WORKDIR /home/node/app
COPY . .
RUN chown -R node:node /home/node/app
ARG url
ENV CONNECTION_STRING $url
ARG token
ENV NEWS_API_KEY $token
USER node
RUN npm install
EXPOSE 3000
CMD ["npm", "start"]
