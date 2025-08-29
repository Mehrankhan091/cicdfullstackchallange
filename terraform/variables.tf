variable "environment" {
    type = map(string)
    default = {
      "main" = "main"
      "devel" = "devel"
      "stage" = "stage"
    }
  
}