/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


resource "google_kms_key_ring" "keyring" {
  project  = local.project_id
  name     = "flaskapp-keyring"
  location = local.project_default_region
}

resource "google_kms_crypto_key" "flaskapp-key" {
  name     = "flaskapp-key"
  key_ring = google_kms_key_ring.keyring.id

  /*lifecycle {
    prevent_destroy = true
  }*/
}

data "google_iam_policy" "flaskapp-policy" {
  binding {
    role = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

    members = [
      "serviceAccount:${google_service_account.default.email}",
      "serviceAccount:service-${local.project_number}@compute-system.iam.gserviceaccount.com",
    ]
  }
}

resource "google_kms_key_ring_iam_policy" "flaskapp-keyring-policy" {
  key_ring_id = google_kms_key_ring.keyring.id
  policy_data = data.google_iam_policy.flaskapp-policy.policy_data
}
