## CI/CD Pipelines 

A CI/CD (Continuous Integration/Continuous Deployment) pipeline is a series of automated steps that enable developers to build, test, and deploy code changes efficiently and reliably. The pipeline is a core component of modern DevOps practices, ensuring that software is delivered quickly, with high quality, and with minimal manual intervention.



## Steps 


## 1. add .github/workflows directory

The .github/workflows directory is a special folder in your GitHub repository where you store workflow files for GitHub Actions.

Workflow files are written in YAML format (e.g., ci-cd-pipeline.yml) and define the steps for your CI/CD pipeline.

   - Create the .github Folder
     ```
     mkdir .github
     ```

   - Create the workflows Folder inside .github folder
     ```
     cd .github
     mkdir workflows
     ```

   - Create the Workflow File called ci-cd-pipeline.yml inside 
     ./workflows
     ```
     cd workflows
     touch ci-cd-pipeline.yml
      ```
   
   - Add source code to yml file
      
     ```
     name: CI/CD Pipeline for HTML Frontend


    branch
      on:
        push:
          branches:
            - main
          pull_request:
          branches:
            - main

    jobs:
       build-and-deploy:
          runs-on: ubuntu-latest 

    steps:
      # Step 1: Checkout the code
      - name: Checkout code
        uses: actions/checkout@v3

      # Step 2: Install dependencies (if any, e.g., npm packages)
      - name: Install dependencies
        run: |
          npm install  # Only if you have a package.json file

      # Step 3: Run tests (if any, e.g., linting or unit tests)
      - name: Run tests
        run: |
          npm test  # Only if you have tests

      # Step 4: Deploy to a server (e.g., GitHub Pages)
      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./src  # The folder containing your HTML 
          files
        ```  



## 2. Dockerizing Your HTML Frontend

   - In the root of your project, create a file named Dockerfile

   - Add the following content to the Dockerfile


```
# Use a lightweight web server image
FROM nginx:alpine

# Copy your HTML files to the Nginx web server directory
COPY ./src /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
```


## Build the Docker Image

```
docker build -t card-frontend .
```


## Run the Docker Container

```
docker run -p 8080:80 card-frontend
```

##  3. CI/CD Pipeline with Docker

update CI/CD pipeline to build and push the Docker image to a container registry (e.g., Docker Hub).


```
name: CI/CD Pipeline with Docker

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  build-and-test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2

      - name: Log in to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_HUB_USERNAME }}
          password: ${{ secrets.DOCKER_HUB_TOKEN }}

      - name: Build and push Docker image
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          tags: your-dockerhub-username/your-html-frontend:latest

  deploy:
    runs-on: ubuntu-latest
    needs: build-and-test

    steps:
      - name: Deploy to server
        run: |
          ssh user@your-server-ip 'docker pull your-dockerhub-username/your-html-frontend:latest && docker run -d -p 80:80 your-dockerhub-username/your-html-frontend:latest'
```



## 4. Steps to Use This Workflow

   - Add Secrets to GitHub

   Go to your GitHub repository > Settings > Secrets and 
   variables > Actions.
   
   Add the following secrets:

   ```
   DOCKER_HUB_USERNAME: Your Docker Hub username.

   DOCKER_HUB_TOKEN: Your Docker Hub access token.
   ```


   - How to generate a docker

   - Push the Workflow File

   ```
   git add .github/workflows/ci-cd-pipeline.yml
   git commit -m "Add CI/CD pipeline with Docker"
   git push origin main
   ```