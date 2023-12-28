resource "aws_ce_anomaly_monitor" "anomaly_monitor" {
  name              = "AWSServiceMonitor"
  monitor_type      = "DIMENSIONAL"
  monitor_dimension = "SERVICE"
}

resource "aws_ce_anomaly_subscription" "realtime_subscription" {
  name      = "RealtimeAnomalySubscription"
  frequency = "IMMEDIATE"

  monitor_arn_list = [
    aws_ce_anomaly_monitor.anomaly_monitor.arn,
  ]

  subscriber {
    type    = "EMAIL"
    address = "d.m.abheethaishan@gmail.com"
  }

  threshold_expression {
    dimension {
      key           = "ANOMALY_TOTAL_IMPACT_ABSOLUTE"
      values        = ["100.0"]
      match_options = ["GREATER_THAN_OR_EQUAL"]
    }
  }

}
