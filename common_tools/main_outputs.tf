data "template_file" "success_output" {
  template = "${file("terraform_templates/output.txt")}"

  vars {

    ## Jenkins information 
    jenkins_username           = "${var.show_passwords == "true" ? var.jenkins["admin_user"]       : "Not Enabled" }"
    jenkins_password           = "${var.show_passwords == "true" ? var.jenkins["admin_password"]   : "Not Enabled" }"

    ## Grafana information
    grafana_username           = "${var.show_passwords == "true" ? var.grafana["grafana_username"] : "Not Enabled" }" 
    grafana_password           = "${var.show_passwords == "true" ? var.grafana["grafana_password"] : "Not Enabled" }" 

    ## Nexus information 
    nexus_username             = "${var.show_passwords == "true" ? "admin"                         : "Not Enabled" }" 
    nexus_password             = "${var.show_passwords == "true" ? var.nexus["admin_password"]     : "Not Enabled" }" 
    
    ## Main domain name
    deployment_endpoint        = "${var.google_domain_name}"
  }
}

output "Success" {
  value = "${data.template_file.success_output.rendered}"
}
