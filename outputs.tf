# outputs.tf


    provisioner "local-exec" {
        # TODO create outputs.tf instead
        command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
    }
