# Kubernetes deployment instructions for MERN stack

## Apply resources
kubectl apply -f k8s/db.yaml
kubectl apply -f k8s/backend.yaml
kubectl apply -f k8s/frontend.yaml
kubectl apply -f k8s/nginx-daemonset.yaml

## Check pods and services
kubectl get pods
kubectl get svc
kubectl get daemonset

## Scale deployments (if needed)
kubectl scale deployment/frontend --replicas=3
kubectl scale deployment/backend --replicas=3

## Clean up
kubectl delete -f k8s/

## Access frontend
# Use NodePort: http://<node-ip>:30080
