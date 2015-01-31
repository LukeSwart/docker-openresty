##How to Deploy

```
cd duwamish-gunicorn
docker run \
         --name "duwamish-gunicorn" \
         -v $(pwd)/staticfiles:/duwamish/static \
         -p 8002:8002 \
         -it lukeswart/duwamish-gunicorn 
```

```
cd duwamish-nginx
docker build -t lukeswart/duwamish-nginx .
docker run \
         --name "duwamish-nginx" \
         --volumes-from duwamish-gunicorn \
         --link duwamish-gunicorn:duwamish-gunicorn \
         -p 80:80 \
         -it lukeswart/duwamish-nginx
```

