# Setting up cert-manager on Kubernetes

After installing cert-manager, manually apply the ClusterIssuer configuration:

Note: Make sure to update the email address in the file before applying it.

```bash
kubectl apply -f terraform/modules/cluster_resources/modules/extras/cluster-issuer.yaml
```
