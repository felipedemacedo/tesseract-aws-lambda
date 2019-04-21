# Hello World for Tesseract in AWS Lambda
Tesseract compiled for AWS Lambda usage.

## Quick Start

The code inside "myfunction.zip" is written in Python and successfully uses Tesseract 5.

## Does it work ? (Example)
The code inside myfunction.zip was uploaded into AWS Lambda and returned the following output:

![image](https://user-images.githubusercontent.com/7635127/56476881-2965cf00-6475-11e9-8612-e83c32fbf326.png)

![image](https://user-images.githubusercontent.com/7635127/56476913-9ed19f80-6475-11e9-887f-7393766506dd.png)

So the answer is ... YES! IT WORKS!

## How can I use it ?
1. Unzip the content of "myfunction.zip" and modify the code in "lambda_function.py" for your needs.
2. Then zip it up again and upload into AWS Lambda.

![image](https://user-images.githubusercontent.com/7635127/56476984-7bf3bb00-6476-11e9-9c72-6767808d0e18.png)



### myfunction.zip

The code structure may look like this.

![image](https://user-images.githubusercontent.com/7635127/56477020-279d0b00-6477-11e9-9657-609774db29cb.png)

### tesseract-standalone.zip

![image](https://user-images.githubusercontent.com/7635127/56477068-ccb7e380-6477-11e9-96b0-8cfa7ec58ad4.png)

### Credits

https://stackoverflow.com/questions/33588262/tesseract-ocr-on-aws-lambda-via-virtualenv
https://github.com/DanBloomberg/leptonica
http://gnu.mirrors.pair.com/autoconf-archive
https://github.com/tesseract-ocr/tesseract
