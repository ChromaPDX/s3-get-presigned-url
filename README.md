# s3-get-presigned-url

Generate pre-signed s3 get urls given region, bucket and key.

```bash
#!/bin/bash
curl $(./s3-get-presigned-url $1 $2 $3)
```
