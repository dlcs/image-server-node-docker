# image-server-node-docker

This contains a single lighttpd process with FastCGI support and IIPSrv with Kakadu. It is exposed outside of the container on port 8080.

The entry point is the operations.sh shell script. It will attempt to download a file from a specified S3 bucket which should contain the compiled version of Kakadu. In the version of the fcgi-bin.tar.gz, the IIPSrv has been built against Kakadu binaries that lived in /opt/kakadu/kakadu-7.5, with an .tar.gz created from the /opt folder.

So, kakadu.tar.gz is expected to contain:
+- kakadu
	+- kakadu-7.5

When running the Docker container, the AWS credentials to access the S3 bucket must be injected via environment variables.
The location in S3 of the kakadu.tar.gz is passed as another environment variable.
See below instructions regarding running the Docker container.

When I have installed and run this container on Gatsby, I can get to IIPSrv with:
```
http://gatsby:8080/fcgi-bin/iipsrv.fcgi
```

Build in the usual fashion:
```
sudo docker build -t <DOCKER CONTAINER NAME AND VERSION> .
```

Runs with:
```
sudo docker run \
        -d \
        -v /nas:/nas \    <- or whatever mount you need for filesystem access
        -p=8080:8080 \
        --env AWS_ACCESS_KEY_ID=<YOUR AWS KEY ID> \
        --env AWS_SECRET_ACCESS_KEY=<YOUR AWS SECRET ACCESS KEY> \
        --env KAKADULOCATION=<YOUR S3 BUCKET FOR KAKADU BINARIES>/kakadu.tar.gz \
        <DOCKER CONTAINER NAME AND VERSION> \
        ./operations.sh
```
