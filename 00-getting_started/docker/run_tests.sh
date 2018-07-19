#!/usr/bin/env bash

# utils
go test -v -run TestBufReader
go test -v -run TestWriteBroadcaster

# filesystem
mkdir -p docker/images/{ubuntu,test}
sudo go test -v -run TestFilesystem

# conatiner
sudo go test -v -run TestStart
sudo go test -v -run TestStop

# docker
go test -v -run TestCreate
go test -v -run TestDestroy
go test -v -run TestGet
