FROM node:8

# Environment variables which handle runtime behaviour.
ENV HOST 0.0.0.0
ENV PORT 3000

# Install the modules and build the code.
COPY package.json .
COPY package-lock.json .
RUN npm install --production
COPY . .

EXPOSE ${PORT}
CMD ["node", "./src/index.js"]
