# 卸载node
sudo apt-get remove --purge npm && \
sudo apt-get remove --purge nodejs && \
sudo apt-get remove --purge nodejs-legacy && \
sudo apt-get autoremove


# 安装node
https://github.com/nodesource/distributions

curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - &&\
sudo apt-get install -y nodejs && \
sudo npm install -g @vue/cli
vue create test-web-access