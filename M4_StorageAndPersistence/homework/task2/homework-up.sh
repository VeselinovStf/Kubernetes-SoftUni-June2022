kubectl apply -f env-configmap.yaml
kubectl apply -f pv-be.yaml
kubectl apply -f service-be.yaml
kubectl apply -f service-fe.yaml
kubectl apply -f pod-be.yaml
kubectl apply -f pod-fe.yaml
