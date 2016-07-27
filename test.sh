#!/bin/bash
curl $(./s3-get-presigned-url $1 $2 $3)
