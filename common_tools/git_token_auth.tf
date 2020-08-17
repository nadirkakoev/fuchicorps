resource "null_resource" "git_token_auth" {
  depends_on = [
    "null_resource.helm_init"]
    
  provisioner "local-exec" {
    command = "curl -H 'Authorization: token ${var.jenkins["git_token"]}' -X GET 'https://api.github.com/users' -I |grep 'HTTP/1.1 200 OK'"
  }
}

