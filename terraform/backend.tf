terraform {
  cloud {
    organization = "emerconnelly"

    workspaces {
      name = "aks-proget-poc"
    }
  }
}
