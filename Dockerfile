

FROM node:22-alpine AS build

RUN apk add --no-cache git

ARG REPO_URL

WORKDIR /app

RUN git clone --depth 1 "$REPO_URL" .


RUN npm ci


RUN npm run build -- --configuration production


RUN test -f dist/equipo4-curso-ing/browser/index.html


FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /app/dist/equipo4-curso-ing/browser/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]