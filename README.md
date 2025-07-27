# devops-microservices-pipline
פרויקט DevOps מלא להרצת אפליקציית מיקרו-שירותים על גבי Kubernetes (EKS), כולל Terraform לתשתיות, Docker לקונטיינרים, ו-Ansible לאוטומציה של התקנות.

# main tools
- **ansible** -  התקנה והפצה של הכלים הנדרשים בין השרתים 
- **Flask,fastapi,nginx** - אפליקציות python בסיסיות.
- **Docker** - קונטינריזצייה של האפליקצייה 
- **Dockerhub**  - שימוש באימג'ים מהרפו שלי 
- **Terraform** - יצרית התשתית עבור הפרוייקט(vpc,eks,s3,iam) 
- **Kubernetes** - פריסת האפליקציות על הEKS ב-AWS 
- **Github Action** - אוטומציה של התהליך CI/CD

# folder structure
- **devops-microservices-pipline/config** 
- **devops-microservices-pipline/infrastructure** 
- **devops-microservices-pipline/k8s** 
- **devops-microservices-pipline/services** 
- **.github/workflows** 

# keys 
- **AWS_ACCESS_KEY_ID**
- **AWS_SECRET_ACCESS_KEY**
- **DOCKER_USERNAME**
- **DOCKER_PASSWORD**
