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
