# apt mirror update
sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
# essential package install
apt-get update -y
apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    htop \
    git \
    locales \
    neofetch \
    net-tools \
    openssh-server \
    ruby \
    ruby-colorize \
    ruby-dev \
    tmux \
    unzip \
    vim \
    wget \
    x11-apps\
    xauth \
    zsh
gem install colorls
# locale setting (set to ko_KR_UTF8)
localedef -f UTF-8 -i ko_KR ko_KR.UTF-8 && localedef -f UTF-8 -i en_US en_US.UTF-8
# zsh settings
chsh -s `which zsh`
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
zsh -c setopt correct
git clone https://github.com/djui/alias-tips.git /root/.oh-my-zsh/plugins/alias-tips
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /root/.oh-my-zsh/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions /root/.oh-my-zsh/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.oh-my-zsh/themes/powerlevel10k
# mkdir ssh dir
mkdir /var/run/sshd

# Copy dot files that pip, zsh, vim, tmux settings
curl -L -O https://github.com/kairos03/Ocean-public/raw/main/scripts/dot_files.zip
unzip -o dot_files.zip -d /root/
rm -f dot_files.zip

# set passwd
echo 'root:P@s$w0rd' | chpasswd
# replace sshd_config
sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
sed -ri 's/^#?AllowTcpForwarding\s+.*/AllowTcpForwarding yes/' /etc/ssh/sshd_config
sed -ri 's/^#?X11DisplayOffset\s+.*/X11DisplayOffset 10/' /etc/ssh/sshd_config
sed -ri 's/^#?PrintLastLog\s+.*/PrintLastLog yes/' /etc/ssh/sshd_config
sed -ri 's/^#?TCPKeepAlive\s+.*/TCPKeepAlive yes/' /etc/ssh/sshd_config
sed -ri 's/^#?#ClientAliveInterval\s+.*/#ClientAliveInterval 300/' /etc/ssh/sshd_config
sed -ri 's/^#?X11UseLocalhost\s+.*/X11UseLocalhost no/' /etc/ssh/sshd_config
# make .ssh
mkdir /root/.ssh
# clean up
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# init conda 
/opt/conda/bin/conda init
# python packages
pip install matplotlib scipy pandas sacred pymongo

# start sshd deamon
/usr/sbin/sshd -D
