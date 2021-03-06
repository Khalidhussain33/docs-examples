resource "google_cloud_scheduler_job" "job" {
  name             = "test-job-${local.name_suffix}"
  schedule         = "*/4 * * * *"
  description      = "test app engine job"
  time_zone        = "Europe/London"
  attempt_deadline = "320s"

  retry_config {
    min_backoff_duration = "1s"
    max_retry_duration = "10s"
    max_doublings = 2
    retry_count = 3
  }

  app_engine_http_target {
    http_method = "POST"

    app_engine_routing {
      service  = "web"
      version  = "prod"
      instance = "my-instance-001"
    }

    relative_uri = "/ping"
  }
}
