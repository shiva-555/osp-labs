######## Check weather cluster is exist on aws account in a particular region #######

aws eks list-clusters --region us-east-1

######### Check the status of the EKS cluster ###########

NOTE - It should be an "ACTIVE"

aws eks describe-cluster \
 --name osp-labs-eks-cluster \
 --region us-east-1 \
 --query "cluster.status"

######## If the cluster is active then we have to regenerate the "kubeconfig" #######

aws eks update-kubeconfig \
 --region us-east-1 \
 --name osp-labs-eks-cluster

###### verify the current context of the EKS cluster it means name of EKS cluster

kubectl config current-context

########## Get the EC2 instance ID i.e. EKS-Worker Node #######

aws ec2 describe-instances \
 --region us-east-1 \
 --filters "Name=tag:aws:eks:cluster-name,Values=osp-labs-eks-cluster" \
 --query "Reservations[].Instances[].[InstanceId,PrivateIpAddress,State.Name]" \
 --output table

##### instance registered with SSM?

aws ssm describe-instance-information --region us-east-1

##### List your nodeGroup name

aws eks list-nodegroups \
 --cluster-name osp-labs-eks-cluster \
 --region us-east-1

##### list of nodegroup role which is attach to the node group

aws eks describe-nodegroup \
 --cluster-name osp-labs-eks-cluster \
 --nodegroup-name <nodeGroup-name> \
 --region us-east-1 \
 --query "nodegroup.nodeRole"

###### List of all policy which is attach to the nodegroup role

aws iam list-attached-role-policies \
 --role-name <nodeGroup-role-name>

########## aws ssm start ###############

aws ssm start-session \
 --target <new-instance-id> \
 --region us-east-1

#######verify you are using correct account and region and user in AWS#####

aws sts get-caller-identity

####### Create ECR Repositories ###############

aws ecr create-repository \
 --repository-name frontend \
 --region us-east-1

########### List of all ECR repository in a region #########

aws ecr describe-repositories --region us-east-1

########## Login to Amazon ECR "Login to ECR"#######

NOTE - This command should execute where docker is installed already

aws ecr get-login-password --region us-east-1 | \
docker login \
--username AWS \
--password-stdin 027742774373.dkr.ecr.us-east-1.amazonaws.com

############ Tag the docker image for push in ECR ########

docker tag frontend-image:latest \
027742774373.dkr.ecr.us-east-1.amazonaws.com/frontend:latest
docker tag student-service-image:latest \
027742774373.dkr.ecr.us-east-1.amazonaws.com/student-service:latest

docker tag teacher-service-image:latest \
027742774373.dkr.ecr.us-east-1.amazonaws.com/teacher-service:latest

docker tag attendance-service-image:latest \
027742774373.dkr.ecr.us-east-1.amazonaws.com/attendance-service:latest

docker tag notification-service-image:latest \
027742774373.dkr.ecr.us-east-1.amazonaws.com/notification-service:latest

########## Check the ECR Repositories ###########

aws ecr describe-repositories --region us-east-1 --query "repositories[].repositoryName"

########## To check the what changes made in the kubernetes manifest file add annotation and apply the manifest file once it is done you can varify this deployment##

$ kubectl rollout history deployment/mysql -n dev

######## check eks cluster addons list ###########

aws eks list-addons \
 --cluster-name osp-labs-eks-cluster \
 --region us-east-1


######## when your service is clusterip and it is in private subnet then you can still access your application by port forwarding ###########

kubectl port-forward svc/frontend 8080:80 -n dev