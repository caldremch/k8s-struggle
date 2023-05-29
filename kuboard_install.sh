# 命令记录

docker run -d \
	--restart=unless-stopped \
	--name=kuboard \
	-p 10080:80/tcp \
	-p 10081:10081/tcp \
	-e KUBOARD_ENDPOINT="http://192.168.107.119:10080" \
	-v /Users/caldremch/kuboard-data:/data \
	eipwork/kuboard:v3
