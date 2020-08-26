FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# By putting a new FROM, that's saying the first phase is done
FROM nginx
# Copy the result in /app/build from the builder phase and put it in that nginx directory specified by nginx documentation
COPY --from=builder /app/build /usr/share/nginx/html