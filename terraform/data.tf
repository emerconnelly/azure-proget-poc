data "external" "azure_service_principal" {
  program = ["bash", "-c", "echo '{ \"arm_client_secret\": \"$ARM_CLIENT_SECRET\", \"arm_client_id\": \"$ARM_CLIENT_ID\" }'"]
}
