#  🚀 CI/CD Pipeline with Docker

Working with a CI/CD pipeline in a GitHub project involves using GitHub Actions, which is GitHub's built-in automation tool. GitHub Actions allows you to create workflows to automate tasks like building, testing, and deploying your code. 

Contains a simple web application with a frontend built using HTML, CSS, and JavaScript. It leverages Docker Containerization tool to create a consistent and portable development environment, ensuring that the application runs seamlessly across different systems. The project also incorporates CI/CD pipelines to automate the development and deployment process.


## folder structure  📚 

```
ci-cd-pipeline/
├── .github/
│   └── workflows/
│       └── ci-cd-pipeline.yml
├── src/
│   └── frondend project source code
├── tests/
│   └── (my test code)
└── Dockerfile
└── README.md
└── API-Documentation.md  
```


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

    - The CD pipeline automatically deploys the Docker image to nginx web server.

4. Production:

    - Frontend is live and accessible to users.


---

## 🌟 Technologies Used

- **Docker** - (to create a consistent development environment) create consistent, isolated, and portable environments for developing, testing, and deploying applications, ensuring they run the same way everywhere.
- **CI/CD Pipeline** - To automate the building, testing, and deployment of applications
- **Nginx server** - The CD pipeline automatically deploys the Docker image to nginx server
- **HTML** - create frontend application
- **Tailwindcss** - Add styles to frontend application
- **yaml files (.yml)** - to define workflows and configurations  for CI/CD pipelines in GitHub Actions

---

## Preview of the frontend 📷

<div style="display: flex; justify-content: center; align-items: center;">
  <img src="/src/assets/preview.png" alt="Image 2">
</div>



---

Further details for refer the API Documentation.


## 📚 License

This project is licensed under the [MIT License](LICENSE).

---

Happy Coding! ✨
