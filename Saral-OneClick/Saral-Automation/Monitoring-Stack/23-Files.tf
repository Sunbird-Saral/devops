provider "kubectl" {
  config_path    = "~/.kube/config"  # Path to your kubeconfig file
}

# List of YAML file paths
variable "yaml_files" {
  type    = list(string)
  default = ["${path.module}/storage-class.yml", "${path.module}/grafana.yml", "${path.module}/prometheus-alert-manager-pvc.yml", "${path.module}/prometheus-server-pvc.yml", "${path.module}/prometheus_values.yml"]
}

# Apply resources defined in each YAML file
resource "kubectl_manifest" "example" {
  for_each = { for idx, file_path in var.yaml_files : idx => file_path }

  yaml_body = file(each.value)

  # Add dependency on the AWS instance
  depends_on = [aws_instance.ubuntu_instance]
}
