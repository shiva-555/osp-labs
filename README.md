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

##############################################