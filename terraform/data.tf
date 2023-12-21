data "external" "azure_service_principal" {
  program = ["bash", "-c", "echo '{ \"arm_client_secret\": \"$(echo $ARM_CLIENT_SECRET)\", \"arm_client_id\": \"$(echo $ARM_CLIENT_ID)\" }'"]
}
