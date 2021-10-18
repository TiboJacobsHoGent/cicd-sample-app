#!/bin/bash
set -euo pipefail

mkdir tempdi
mkdir tempdi/templates
mkdir tempdi/static

cp sample_app.py tempdi/.
cp -r templates/* tempdi/templates/.
cp -r static/* tempdi/static/.

cat > tempdi/Dockerfile << _EOF_
FROM python
RUN pip install flask
COPY  ./static /home/myapp/static/
COPY  ./templates /home/myapp/templates/
COPY  sample_app.py /home/myapp/
EXPOSE 5050
CMD python /home/myapp/sample_app.py
_EOF_

cd tempdi || exit
docker build -t sampleapp .
docker run -t -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a 
