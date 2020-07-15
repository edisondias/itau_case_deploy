FROM centos:7

RUN yum install wget unzip -y

RUN wget https://releases.hashicorp.com/packer/1.5.4/packer_1.5.4_linux_amd64.zip

RUN unzip packer_1.5.4_linux_amd64.zip -d /usr/local/bin/

RUN wget https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip

RUN unzip terraform_0.12.20_linux_amd64.zip -d /usr/local/bin/

WORKDIR opt/files/
