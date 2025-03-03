# Use a lightweight web server image
FROM nginx:alpine

# Copy your HTML files to the Nginx web server directory
COPY ./src /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]














