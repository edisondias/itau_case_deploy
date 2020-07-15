docker build -t packer_test:latest .
cd ..
docker run -itd -v $(pwd):'/opt/files' --name packer_instance packer_test:latest
docker exec -it packer_instance /bin/bash