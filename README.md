# SAFLE

## Deliverables
    - ✅Terraform configuration files for infrastructure provisioning.
    - ✅Dockerfile and docker-compose.yml for containerization
    - ✅CI/CD pipeline configuration (GitHub Actions, Jenkins, or similar)
    - ✅Documentation (README) explaining the setup, deployment, and monitoring.
    - ✅Link to the running application (if deployed on a public cloud) or steps to access it locally.


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

## Task 3 & 5 Infrastructure as Code (IaC) with Terraform & High Availability and Load Balancing
### Description
- I have grouped task 3 & 5 where I have deployed an application in GKE , and added a Load Balancer on top of the application . All the Infra is created using terraform modules , No hardcoded values , I have used locals.tf to make sure no sensitive values are exposed . Also attached a sample locals.tf for reference .
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
 

### Pre-requisites
- Terraform 
- Access to GCP

### Steps to provision infra
- cd task-3&5
- Run command " terrform init " 
- Run command " terraform plan "
- Run command " terraform apply "
- Give input " yes " after running  terraform apply

![VPC](screenshots/vpc_subnets.png)

![MYSQL](screenshots/mysql.png)

![GKE](screenshots/gke.png)

![ARTIFACT](screenshots/artifacts.png)


## Task 7 Monitoring and Alerts 
### Description
- To deploy monitoring stack and logging stack I have used Helm and community available charts , the settings can further be configured by using a custom values.yaml for each chart we use .

- For monitoring I have gone with widely used stack of Prometheus and Grafana , other options included google managed prometheus , or google default monitoruing 


### Pre-requisites
- Helm
- Access to GCP

### Steps to Install Prometheus
- Get Access to cluster by running :- 
    - gcloud container clusters get-credentials <cluster-name> --region <region> --project <project-id>
- Search and add helm chart 
    - helm search hub Prometheus
    - helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    - helm repo update
- Install Prometheus
    - helm install prometheus prometheus-community/prometheus
- Verify all the pods are up
![PROM-PODS](screenshots/prom-pods.png)
- Port forward the prometheus server to check metrics
    - kubectl port-forward service/prometheus-server 8080:9090
- Open browser and search for localhost:8080 ( 8080 is not mandatory in last step , can use any available port)
- Goto targets and verify the incoming data

![PROMETHEUS](screenshots/prometheus.png)

### Steps to Install Grafana
- Get Access to cluster by running :- 
    - gcloud container clusters get-credentials <cluster-name> --region <region> --project <project-id>
- Search and add helm chart
    - helm search hub grafana
    - helm repo add grafana https://grafana.github.io/helm-charts 
    - helm repo update
- Install Grafana
    - helm install grafana grafana/grafana
- Verify all the pods are up
![PODS](screenshots/grafana-pods.png)
- Port forward the grafana 
    - kubectl port-forward grafana-7f898f4699-jjlxp 3000:3000
- Open browser and search for localhost:3000 ( 3000 is not mandatory in last step , can use any available port)
- Retrieve Grafana Credentials
    - kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | ForEach-Object { [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($_)) }
    - paste the password 
    - username would be "admin"
- Add Datasource
    - Goto Connections -> Data Sources -> Add data source
![DS](screenshots/navigate-data-source.png)
    - Check for prometheus data source 
    - Add the endpoint :- "prometheus-server.default.svc.cluster.local"
    - Click on save and test
![DS](screenshots/add-ds-prom.png)
- Add dashboard
    - Get the Grafana Dashboard ID from the Grafana public Dashboard library ( https://grafana.com/grafana/dashboards/ )
    - Now go to the search dashboard, and search for Kubernetes
    - Choose Kubernetes cluster monitoring (via Prometheus)
    - Copy the ID to clipboard
    - Come back to grafana , click on dashboard , click on new and import ,paste the dashboard id and load , select the datasource we configured and click on import
![DASHBOARD](screenshots/grafana-dashboard.png)

### Setting up Alert to Slack
- Navigate to https://api.slack.com/apps
- Click on create an app -> from scratch -> give it a name and choose the workspace
![WORKSPACE](screenshots/alert-slack-app.png)
- Click on incoming webhooks and enable
![WEBHOOK](screenshots/enable-webhooks.png)
- Add a new webhook to the workspace -> Select the channel and copy the webhook URL
- Come back to Grafna -> Alerting and Contact points 
- Select Integration -> Slack , and paste the Webhook URL
![ALERT](screenshots/alert.png)
 
## Task 8 Logging and Debugging
### Description
- For logging and debugging I have used ELK stack , other options included EFK , loki with grafana

### ❌❌Setting up ELK 
- Add Elastic Helm Charts Repository
    - helm repo add elastic https://helm.elastic.co
    - helm repo update
- Install Elasticsearch
    - helm install elasticsearch elastic/elasticsearch
- Install Kibana
    - helm install kibana elastic/kibana
- Install Logstash
    - helm install logstash elastic/logstash

This setup could not be completed due to elasticsearch pods having excessive memory requirements , thus moving to GCP offering of logging and debugging Solution .

### Logs Explorer by GCP Monitoring 
- By Deafult GCP monitoring allows to explore and filter logs based on namespace , pod name , cluster , node and errors

![GCP-LOGS](screenshots/GCP-logs.png)
