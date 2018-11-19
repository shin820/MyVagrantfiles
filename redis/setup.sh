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

# 启动Redis容器
docker run -p 6379:6379 -v /data/redis-data/:/data -d --name redis-server redis --appendonly yes