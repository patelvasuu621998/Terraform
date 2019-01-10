provider "aws" {
  access_key = "AKIAJVZEIWEY5MUZX33Q"
  secret_key = "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"
  region     = "ap-south-1"
}

resource "aws_instance" "instance" {
  ami           = "ami-04ea996e7a3e7ad6b"
  instance_type = "t2.micro"
  count = "1"
  key_name = "ansible"
  security_groups = ["Server1"]
  tags{
    Name = "created using terra"
}
provisioner "remote-exec" {
  inline = [
   "cd /opt",
   "sudo wget -O splunk-6.6.8-6c27a8439c1e-Linux-x86_64.tgz 'https://www.splunk.com/page/download_track?file=6.6.8/linux/splunk-6.6.8-6c27a8439c1e-Linux-x86_64.tgz&ac=&wget=true&name=wget&platform=Linux&architecture=x86_64&version=6.6.8&product=splunk&typed=release'",
   "sudo tar xvzf splunk-6.6.8-6c27a8439c1e-Linux-x86_64.tgz",
   "sudo /opt/splunk/bin/splunk start --accept-license --answer-yes",
   "sudo  /opt/splunk/bin/splunk login -auth admin:changeme"
]
}
connection {
  type = "ssh"
  user = "ubuntu"
  password = ""
  private_key = "${file("/home/ubuntu/vasu/ansible.pem")}"
}
}
