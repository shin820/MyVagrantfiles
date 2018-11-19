#/bin/sh

# 安装Docker
yum install container-selinux libseccomp libtool-ltdl -y
rpm -ivh https://mirrors.ustc.edu.cn/docker-ce/linux/centos/7/x86_64/stable/Packages/docker-ce-18.06.1.ce-3.el7.x86_64.rpm
systemctl start docker && systemctl enable docker
cat > /etc/docker/daemon.json << EOF
{
     "registry-mirrors": ["https://8vtb3cuu.mirror.aliyuncs.com"]
}
EOF
groupadd docker
gpasswd -a vagrant docker
systemctl restart docker

# 启动RabbitMQ容器
docker run -d -p 5671:5671 -p 5672:5672 -p 15671:15671 -p 15672:15672 -p 25672:25672 -v /data/rabbitmq-data/:/var/rabbitmq/lib --hostname my-rabbitmq --name my-rabbitmq rabbitmq:3-management