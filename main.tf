# Terraform 0.13+ uses the Terraform Registry:

terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}


# Configure the Datadog provider
provider "datadog" {
    api_key = var.datadog_api_key
    app_key = var.datadog_app_key
}

# main.tf

resource "datadog_monitor" "high_cpu_usage" {
  name               = "High CPU Usage Monitor"
  type               = "metric alert"
  query              = "avg(last_5m):avg:system.cpu.idle{*} < 20"
  message            = "CPU usage is high! Alert triggered."
  escalation_message = "Please investigate immediately."
  tags               = ["env:prod", "service:api"]

monitor_thresholds {
  critical = "95"
  warning = "90"
}
}

