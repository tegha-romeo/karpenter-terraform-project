
# Karpenter Terraform Project on Minikube

This project demonstrates how to deploy [Karpenter](https://karpenter.sh) using Terraform on a **Minikube** Kubernetes cluster.

Karpenter is an open-source node provisioning project that automatically launches and terminates nodes in response to unschedulable pods.

---

##  Project Structure

| File Name                | Purpose                                                                 |
|-------------------------|-------------------------------------------------------------------------|
| `main.tf`               | Terraform config for provisioning Karpenter components via Helm         |
| `karpenter-crds.yaml`   | Installs required Custom Resource Definitions (CRDs) for Karpenter      |
| `karpenter-deployment.yaml` | Manually deploys Karpenter controller (optional if using Helm)     |
| `unschedulable-pod.yaml`| Test pod to trigger Karpenter node provisioning                         |

---

## ⚙️ Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Minikube](https://minikube.sigs.k8s.io/)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/)
- `runc`, `crictl`, `crio` (already configured with your Minikube cluster)

---

## 📦 Setup Instructions

### 1. Start Minikube
```bash
minikube start --nodes 2 --driver=docker

kubectl get nodes

terraform init

kubectl apply -f karpenter-deployment.yaml

kubectl -n karpenter get pods

kubectl apply -f provisioner.yaml

kubectl apply -f unschedulable-pod.yaml

kubectl get pod unschedulable

```
### restart demo
```bash
kubectl delete -f unschedulable-pod.yaml
kubectl delete -f provisioner.yaml
terraform destroy -auto-approve
kubectl delete -f karpenter-crds.yaml
