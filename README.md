# FastAPI Docker Deployment on AWS EC2

This project demonstrates how to deploy a FastAPI application using Docker on an AWS EC2 instance, with Terraform for infrastructure provisioning and GitHub Actions for CI/CD.

## Technologies Used:
- **Terraform**: Infrastructure as Code (IaC)
- **AWS EC2**: Cloud compute instances
- **Docker**: Containerization for the FastAPI application
- **FastAPI**: Web framework for building APIs
- **GitHub Actions**: Continuous Integration / Continuous Deployment (CI/CD)

---

## Step 1: Infrastructure Setup with Terraform

1. **Clone this repository** to your local machine:

    ```bash
    git clone <repository-url>
    cd <repository-folder>
    ```

2. **Configure your IP**: Create a `terraform.tfvars` file inside the `infrastructure` folder and add your local machine's IP address for SSH and HTTP access:

    ```hcl
    my_ip = "YOUR_PUBLIC_IP"
    ```

    Replace `YOUR_PUBLIC_IP` with your own public IP (you can check it by searching "what is my ip" in your browser).

3. **Provision Infrastructure**: Run the following Terraform commands to provision the infrastructure on AWS.

    ```bash
    cd infrastructure
    terraform init
    terraform apply
    ```

    Confirm the apply step by typing `yes`.

---

## Step 2: Docker Setup

Before accessing the application, ensure the Docker container for FastAPI is configured and running.

1. **Copy the project files**: Move to the directory containing your FastAPI project files and Docker configuration (such as the `Dockerfile`, `.dockerignore`, etc.).

2. **Build the Docker image**:

    ```bash
    docker build -t fastapi-devops .
    ```

3. **Run the Docker container**:

    To expose the application on port 8000, run the following:

    ```bash
    docker run -d -p 8000:8000 fastapi-devops
    ```

    This will start your FastAPI application inside a Docker container, making it accessible via `http://<public-ip>:8000`.

---

## Step 3: Access the Application

After the EC2 instance is provisioned and Docker is set up, you can access the FastAPI application at the public IP provided in the output of Terraform:

```bash
http://<public-ip>:8000
