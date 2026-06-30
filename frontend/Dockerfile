FROM node:22-alpine AS build 

WORKDIR /app

# Copy package config file from your frontend directory
COPY frontend/package.json ./

# Run standard install since a lockfile doesn't exist yet
RUN npm install

# Copy all the rest of the frontend source code files
COPY frontend/ . 

# Compile your application
RUN npm run build 

FROM node:22-alpine AS prod 

WORKDIR /app

# Install the 'serve' utility to run your static site
RUN npm install -g serve

# Copy the compiled production dist folder from the build stage
COPY --from=build /app/dist /app/dist

USER node 

EXPOSE 3000

CMD ["serve", "-s", "dist", "-l", "3000"]
