region          = "us-east-1"
env             = "prod"
profile         = "prod"
profile2        = "pci"
key_pair        = "wirecard-production"
backup          = "sim"
zone_id         = "Z25H2CL2S6GLQ8"
ext_zone_id     = "Z3H6BW1F9MM740"
domain          = "wirecard.in"
azs             = ["us-east-1b", "us-east-1c"]
account_id      = "134937327130"


terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }
}
