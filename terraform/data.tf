data "external" "arm_client_id" {
  program = ["bash", "-c", "echo -n $ARM_CLIENT_ID"]
}

data "external" "arm_client_secret" {
  program = ["bash", "-c", "echo -n $ARM_CLIENT_SECRET"]
}
