  resource "helm_release" "cluster-autoscaler" {
  name       = "cluster-autoscaler"
  repository = "https://charts.helm.sh/stable"
  chart      = "cluster-autoscaler"
  version    = "7.1.0"
  namespace  = "kube-system"
  timeout    =  300

  values = [
    "${file("./chart_values.yaml")}"
  ]

  set {
    name  = "cluster.enabled"
    value = "true"
  }

  set {
    name  = "metrics.enabled"
    value = "true"
  }

  depends_on = [local_file.kubeconfig_EKS_Cluster]
}