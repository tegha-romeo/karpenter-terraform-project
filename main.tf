terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14.0"
    }
  }
}

provider "kubectl" {
  config_path = "~/.kube/config"
}

resource "kubectl_manifest" "karpenter_ns" {
  yaml_body = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: karpenter
YAML
}

resource "kubectl_manifest" "karpenter_crds" {
  yaml_body = file("${path.module}/karpenter-crds.yaml")
  depends_on = [kubectl_manifest.karpenter_ns]
}

# resource "kubectl_manifest" "karpenter_controller" {
#   yaml_body = file("${path.module}/karpenter-deployment.yaml")
#   depends_on = [kubectl_manifest.karpenter_crds]
# }
