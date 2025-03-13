## CI/CD Pipelines 🚀

A CI/CD (Continuous Integration/Continuous Deployment) pipeline is a series of automated steps that enable developers to build, test, and deploy code changes efficiently and reliably. The pipeline is a core component of modern DevOps practices, ensuring that software is delivered quickly, with high quality, and with minimal manual intervention.


## Workflow 🚀

1. Development:

   - Write code using HTML, CSS, and JavaScript.
   - Use Docker to create a consistent development environment.

2. CI Pipeline:

   - Push code to a Git repository (e.g., GitHub, GitLab).
   - The CI pipeline automatically:
      - Lints your code.
      - Runs tests (if any).
      - Builds a Docker image.

3. CD Pipeline:

   - The CD pipeline automatically deploys the Docker image to a server or hosting platform (e.g., AWS, Netlify, Vercel).

4. Production:

   - Your frontend is live and accessible to users.


---

## Why Use a CI/CD Pipeline? 

1. Automation:

   - CI/CD pipeline automates repetitive tasks like testing, building, and deploying your application. This saves time and reduces the risk of human error.

2. Continuous Integration (CI):

   - Every time you push code to your repository, the CI pipeline automatically runs tests and checks for errors. This ensures that your code is always in a deployable state.

3. Continuous Deployment (CD):

   - The CD pipeline automates the deployment process, so you can quickly and reliably deploy updates to your frontend. This is especially useful if you’re frequently making changes to your HTML, CSS, or JavaScript.

4. Quality Assurance:

    - By integrating automated testing into your pipeline, you can catch bugs and issues early in the development process.

5. Collaboration:

   - CI/CD pipeline makes it easier for teams to collaborate on a project. Everyone’s code is automatically tested and integrated, reducing the risk of conflicts or broken builds.

6. Faster Delivery:

   - With a CI/CD pipeline, you can deliver updates to your frontend faster and more frequently, improving the overall development cycle.

---


## Why Use Docker?

1. Consistency Across Environments:

   - Docker ensures that your application runs the same way in development, testing, and production environments. This eliminates the "it works on my machine" problem.

   - For example, if you’re using specific versions of Node.js, npm, or other tools, Docker ensures everyone working on the project uses the same versions.

2. Isolation:

   - Docker containers isolate your application and its dependencies from the host system. This prevents conflicts with other software or libraries installed on your machine.

3. Portability:

   - Once your application is containerized, it can be easily deployed to any environment that supports Docker (e.g., local machines, cloud servers, etc.).

4. Simplified Onboarding:

   - New team members can quickly set up the project by running a single Docker command, without needing to manually install dependencies or configure their environment.

5. Scalability:

   - If your project grows and you need to scale your application, Docker makes it easier to deploy multiple instances of your frontend.

---


## Why Use Both Together?

 - Docker ensures your application is consistent and portable.
 - CI/CD automates the process of testing, building, and deploying your Dockerized application.
 - Together, they create a robust workflow that improves development efficiency, reduces errors, and makes your project more scalable and maintainable.



## Why use Nginx web server?

  - The CD pipeline automatically deploys the Docker image to a Nginx server.
  - NGINX can serve static content (like HTML, CSS, JavaScript, and images) to users who visit your website.
  - It is known for being lightweight, fast, and efficient at handling high traffic.

---

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

   - Add the relavant content to the Dockerfile


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


## Docker login

```
docker login -u prabodha1234
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
          tags: prabodha1234/card-frontend:latest

  deploy:
    runs-on: ubuntu-latest
    needs: build-and-test

    steps:
      - name: Deploy to server
        run: |
          ssh user@your-server-ip 'docker pull prabodha1234/card-frontend && docker run -d -p 80:80 prabodha1234/card-frontend:latest'
```



## 4. Steps to Use This Workflow
   
   - Generate Secrets in DockerHub


  Docker Hub uses access tokens instead of passwords for secure 
  authentication in CI/CD pipelines and other automated 
  workflows.

  1. Create a Docker Hub Account

  2. Navigate to Account settings in top-right corner of the 
       profile icon..

  3. In the left-hand menu, click on Security

  4. Create a New Access Token

      - add description
      - Set the Permissions to Read & Write
      - click generate button


   - Add DockerHub Secrets to GitHub

   ```
   Go to your GitHub repository > Settings > Secrets and 
   variables > Actions.
   ```
   
  Add the following secrets:

   ```
   DOCKER_HUB_USERNAME: Your Docker Hub username.

   DOCKER_HUB_TOKEN: Your Docker Hub access token.
   ```


   - Push the Workflow File

   ```
   git add .github/workflows/ci-cd-pipeline.yml
   git commit -m "Add CI/CD pipeline with Docker"
   git push origin main
   ```
