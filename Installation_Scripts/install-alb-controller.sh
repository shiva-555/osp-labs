#!/bin/bash

set -e

#############################################
# Variables
#############################################

CLUSTER_NAME="osp-labs-eks-cluster"
REGION="us-east-1"

ACCOUNT_ID=$(aws sts get-caller-identity \
--query Account \
--output text)

ROLE_NAME="osp-labs-alb-controller-role"

#############################################
# Add Helm Repository
#############################################

echo "Adding EKS Helm Repository..."

helm repo add eks https://aws.github.io/eks-charts

helm repo update

#############################################
# Create Service Account
#############################################

echo "Creating Service Account..."

kubectl create serviceaccount \
aws-load-balancer-controller \
-n kube-system \
--dry-run=client \
-o yaml | kubectl apply -f -

#############################################
# Annotate IRSA
#############################################

echo "Annotating Service Account..."

kubectl annotate serviceaccount \
aws-load-balancer-controller \
-n kube-system \
eks.amazonaws.com/role-arn=arn:aws:iam::$ACCOUNT_ID:role/$ROLE_NAME \
--overwrite

#############################################
# Install Controller
#############################################

echo "Installing AWS Load Balancer Controller..."

helm upgrade --install aws-load-balancer-controller \
eks/aws-load-balancer-controller \
-n kube-system \
--set clusterName=$CLUSTER_NAME \
--set serviceAccount.create=false \
--set serviceAccount.name=aws-load-balancer-controller \
--set region=$REGION \
--set vpcId=$(aws eks describe-cluster \
--name $CLUSTER_NAME \
--region $REGION \
--query "cluster.resourcesVpcConfig.vpcId" \
--output text)

#############################################
# Verify
#############################################

kubectl rollout status deployment/aws-load-balancer-controller \
-n kube-system

echo ""
echo "Installation Completed Successfully"