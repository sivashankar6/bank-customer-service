#!/bin/bash
sudo yum update -y
sudo yum remove *java* -y
sudo yum install wget java-1.8.0-openjdk java-1.8.0-openjdk-devel -y
wget http://54.91.221.244:8081/nexus/content/repositories/maven_release/org/springframework/boot/spring-boot-starter-parent/0.0.1/spring-boot-starter-parent-0.0.1.jar
nohup java -jar spring-boot-starter-parent-0.0.1.jar &
