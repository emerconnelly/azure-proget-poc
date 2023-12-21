data "external" "arm_client_secret" {
  program = ["bash", "-c", "echo '{ \"arm_client_secret\": \"$ARM_CLIENT_SECRET\" }'"]
}

data "external" "arm_client_id" {
  program = ["bash", "-c", "echo '{ \"arm_client_id\": \"$ARM_CLIENT_ID\" }'"]
}
