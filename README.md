# 3-Tier application on AWS EKS through Kubevela

The purpose of this project is to demostrate the functionalities of Kubevela.

[Medium post about this repository](https://medium.com/@emanuelrusso93/how-to-deploy-a-3-tier-application-on-aws-eks-through-kubevela-8b6d1593cde7)

1. Apply Component

vela def apply frontend.cue
vela def apply backend.cue
kubectl apply -f postgres-component.yaml

2. Deploy application

vela up -f application.yaml

3. Verify Deploy of Application

vela status scrum-board-master
