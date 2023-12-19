terraform {
  cloud {
    organization = "emerconnelly"

    workspaces {
      name = "azure-proget-poc"
    }
  }
}
