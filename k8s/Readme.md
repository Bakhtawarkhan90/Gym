# To Run With k8s use below commands
``` bash
  - cd k8s
  -  kubectl apply -f .
  -  kubectl port-forward svc/wedding-service 5000:5000 --address 0.0.0.0 &
```
# Now you can access the app on port 5000
