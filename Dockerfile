# Build step
FROM node:20 AS builder
WORKDIR /app

COPY . .
RUN npm install
RUN npm run build

# Serve step with NGINX
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]