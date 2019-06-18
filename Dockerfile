# Basically sets all steps after this one as builder
FROM node:alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install

COPY . .
RUN npm run build

# This second FROM statement terminates the above block
FROM nginx
# We want to copy something from another phase (builder)
COPY --from=builder  /app/build /usr/share/nginx/html
