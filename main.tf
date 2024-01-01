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

resource "aws_s3_bucket" "bad_backet" {
  bucket = "bad-bucket"
  acl = "authenticated-read"

  logging {
    target_bucket = "access-logs"
    target_prefix = "bad-bucket/logging"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
