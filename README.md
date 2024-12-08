# SAFLE
## Task 1  Node.js Application Setup
### Description
I have used a simple nodejs application and added basic unit test for atleast two end points (used jest)

### Pre-requisites
- node

### Steps to produce
- cd task-1&2
- node index.js
- open browser and redirect to http://localhost:3000/api/todos
- npm test

## Task 2 Containerization with Docker
### Description
Used docker to containerize the Application , we created in task 1 and pushed to public dockerHub, and added community mysql docker image in docker-compose.yaml
NOTE :- I have also created a private artifact repository in task 4 , but for this project and to make the image available for review I have used public DockerHub 

### Pre-requisites
- Docker

### Steps to produce
- cd task-1&2
- docker build -t image-name:image-tag .
- docker push image-name:image-tag
- docker-compose up

## Task 3 Infrastructure as Code (IaC) with Terraform
## Task 5 High Availability and Load Balancing
## Task 7 Monitoring and Alerts
## Task 8 Logging and Debugging
### Description
- I have grouped task 3 , 5 , 7 & 8 where I have deployed an application in GKE , and added a Load Balancer on top of the application . All the Infra is created using terraform modules , No hardcoded values , I have used locals.tf to make sure no sensitive values are exposed . Also attached a sample locals.tf for reference .
- Infrastructure created using Terraform:- 
    - A VPC
    - 3 Subnets
    - GKE with 3 nodes 1 in each Availability zone to maintain high availability
    - Artifact registry to store our dockerized images ( private )
    - A Load balancer for my service
    - 1 Firewall for lb
    - Target Group for lb
    - Forwarding Rule for lb
    - Firewall Rules for lb
    - Network Endpoint for the service
    - Network Endpoint Group for Service
    - A managed MYSQL database

- To maintain high availability I have gone with kubernetes , while the other options like cloud run , or docker swarm were available , kubernetes allowed me to better orchestrate my application and also to deploy the monitoring ( task 7 ) and logging stack ( task 8 ) , I can reuse kubernetes to deploy them instead of provisioning new infra .

- To deploy monitoring stack and logging stack I have used Helm and community available charts , the settings can further be configured by using a custom values.yaml for each chart we use . 

### Pre-requisites
- Terraform 
- Helm
- Access to GCP

### Steps to provision infra
- cd task-3&5&7&8
- Run command " terrform init " 
- Run command " terraform plan "
- Run command " terraform apply "
- Give input " yes " after running  terraform apply
