package main

import (
	"fmt"
	"log"
	"os"
	"time"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3"
)

func main() {
	if len(os.Args) != 4 {
		fmt.Println("USAGE: s3-get-presigned-url REGION BUCKET KEY")
		os.Exit(1)
	}

	region := os.Args[1]
	bucket := os.Args[2]
	key := os.Args[3]

	sess := session.New(&aws.Config{Region: aws.String(region)})
	svc := s3.New(sess)

	req, _ := svc.GetObjectRequest(&s3.GetObjectInput{
		Bucket: aws.String(bucket),
		Key:    aws.String(key),
	})

	urlStr, err := req.Presign(5 * time.Minute)
	if err != nil {
		log.Fatalln(err)
	}

	fmt.Print(urlStr)
}
