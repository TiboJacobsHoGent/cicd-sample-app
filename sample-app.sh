#!/bin/bash
set -euo pipefail

mkdir tempdirr
mkdir tempdirr/templates
mkdir tempdirr/static

cp sample_app.py tempdirr/.
cp -r templates/* tempdirr/templates/.
cp -r static/* tempdirr/static/.

cat > tempdirr/Dockerfile << _EOF_
FROM python
RUN pip install flask
COPY  ./static /home/myapp/static/
COPY  ./templates /home/myapp/templates/
COPY  sample_app.py /home/myapp/
EXPOSE 5050
CMD python /home/myapp/sample_app.py
_EOF_

cd tempdirr || exit
docker build -t sampleapp .
docker run -t -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a 
