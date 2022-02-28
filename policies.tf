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


/*
resource "google_project_organization_policy" "requireOsLogin" {
  project    = local.project_id
  constraint = "compute.requireOsLogin"

  boolean_policy {
    enforced = false
  }
}

resource "google_project_organization_policy" "requireShieldedVm" {
  project    = local.project_id
  constraint = "compute.requireShieldedVm"

  boolean_policy {
    enforced = false
  }
}

resource "google_project_organization_policy" "vmExternalIpAccess" {
  project    = local.project_id
  constraint = "compute.vmExternalIpAccess"

  boolean_policy {
    enforced = false
  }
}


resource "google_project_organization_policy" "vmCanIpForward" {
  project    = local.project_id
  constraint = "compute.vmCanIpForward"

  boolean_policy {
    enforced = false
  }
}
*/
