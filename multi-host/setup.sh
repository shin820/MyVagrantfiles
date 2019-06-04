#/bin/sh

# 使用阿里云的yum源
sudo mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
sudo curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
sudo yum clean all
sudo yum makecache

# 安装一些工具
sudo yum install -y vim 

# 安装docker
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker

cat > /etc/docker/daemon.json << EOF
{
     "registry-mirrors": ["https://8vtb3cuu.mirror.aliyuncs.com"]
}
EOF

groupadd docker
gpasswd -a vagrant docker
systemctl restart docker

