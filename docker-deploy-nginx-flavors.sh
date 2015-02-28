docker run -d \
  --name "nginx" \
  --volumes-from demo1 \
  --link demo1:demo1 \
  --link demo2:demo2 \
  --link demo3:demo3 \
  -p 80:80 \
  -it lukeswart/flavors-nginx

