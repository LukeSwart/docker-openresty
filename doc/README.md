##How to Deploy

Make sure `.env` is up to date with API and site keys
```
docker pull lukeswart/duwamish-nginx
docker pull lukeswart/duwamish
./docker-deploy-flavors demo1
./docker-deploy-flavors demo2
# etc
./docker-deploy-nginx
```

Redeployment:
```
docker stop demo1
docker rm demo1
./docker-deploy-flavors demo1
# etc
docker stop nginx
docker rm nginx
./docker-deploy-nginx.sh
```

