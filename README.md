# tesseract-aws-lambda
Tesseract compiled for AWS Lambda usage.

## How ?

1. Unzip the content of "tesseract-standalone.zip" on lambda root directory (/var/task)
2. Place your code on the same directory.
3. Run your AWS Lambda Function with environment variable TESSDATA_PREFIX pointing into /var/task/tessdata.
