module "iam" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 7"

  projects = ["knative-tests"]

  mode = "authoritative"

  bindings = {


    "roles/artifactregistry.reader" = [
      "serviceAccount:${google_service_account.gke_nodes.email}",
    ]

    "roles/cloudbuild.builds.editor" = [
      "serviceAccount:prow-job@knative-tests.iam.gserviceaccount.com",
      "serviceAccount:pwg-admins@knative-tests.iam.gserviceaccount.com"
    ]

    "roles/container.admin" = [
      "serviceAccount:prow-deployer@knative-tests.iam.gserviceaccount.com",
      "serviceAccount:pwg-admins@knative-tests.iam.gserviceaccount.com"
    ]

    "roles/container.clusterAdmin" = [
      "serviceAccount:workload-metrics-svc-acct@knative-tests.iam.gserviceaccount.com"
    ],

    "roles/iam.serviceAccountTokenCreator" = [
      "serviceAccount:workload-metrics-svc-acct@knative-tests.iam.gserviceaccount.com"
    ],

    "roles/iam.serviceAccountUser" : [
      "serviceAccount:workload-metrics-svc-acct@knative-tests.iam.gserviceaccount.com"
    ],


    "roles/logging.logWriter" = [
      "serviceAccount:${google_service_account.gke_nodes.email}",
    ]

    "roles/monitoring.metricWriter" = [
      "serviceAccount:${google_service_account.gke_nodes.email}",
    ]

    "roles/monitoring.viewer" = [ # Required for Managed Prometheus
      "serviceAccount:${google_service_account.gke_nodes.email}",
    ]

    "roles/pubsub.editor" : [
      "serviceAccount:prow-control-plane@knative-tests.iam.gserviceaccount.com"
    ],

    "roles/secretmanager.secretAccessor" : [
      "serviceAccount:kubernetes-external-secrets-sa@knative-tests.iam.gserviceaccount.com",
      "serviceAccount:prow-deployer@knative-tests.iam.gserviceaccount.com"
    ],

    "roles/secretmanager.viewer" : [
      "serviceAccount:kubernetes-external-secrets-sa@knative-tests.iam.gserviceaccount.com"
    ],

    "roles/stackdriver.resourceMetadata.writer" = [
      "serviceAccount:${google_service_account.gke_nodes.email}",
    ]

    "roles/storage.admin" = [
      "serviceAccount:knative-tests@appspot.gserviceaccount.com",
      "serviceAccount:prow-control-plane@knative-tests.iam.gserviceaccount.com",
      "serviceAccount:prow-job@knative-nightly.iam.gserviceaccount.com",
      "serviceAccount:prow-job@knative-releases.iam.gserviceaccount.com",
      "serviceAccount:prow-job@knative-tests.iam.gserviceaccount.com",
      "serviceAccount:pwg-admins@knative-tests.iam.gserviceaccount.com"
    ],

    "roles/storage.objectViewer" = [
      "serviceAccount:${google_service_account.gke_nodes.email}",
    ]

    "roles/viewer" = [
      "serviceAccount:prow-job@knative-tests.iam.gserviceaccount.com",
      "serviceAccount:pwg-admins@knative-tests.iam.gserviceaccount.com"
    ]
  }
}

resource "google_service_account" "gke_nodes" {
  account_id   = "gke-nodes"
  display_name = "GKE Nodes"
  project      = module.project.project_id
}