---  
title : "Table of Contents"  
date : "2023-07-15"  
weight : 1  
chapter : false  
pre : " <b> 1. </b> "  
---  

**Objectives**  
By completing this workshop, you will be able to:  

Create an Amazon DynamoDB table to store data  
Create a RESTful API using Amazon API Gateway  
Create AWS Lambda functions triggered by the API Gateway  
Connect AWS Lambda functions with Amazon Simple Notification Service (SNS)  
Use Amazon Polly to synthesize speech in multiple languages and voices  

Duration  
This workshop takes approximately 90 minutes to complete.  

Environment and Direction  
You will build a serverless application, meaning you do not need to work with servers — no provisioning, no patching, no scaling. AWS Cloud will handle this automatically, allowing you to focus on your application.  

The application provides two methods – one to send information about new posts, which is then converted into an MP3 file, and one to retrieve information about posts (including links to the MP3 files stored in Amazon S3).
![FWD](/images/0.tablecontent/architecture.png)

**When the application sends information about a new post:**

1.The information is received by a RESTful web service provided by Amazon API Gateway. This web service is called by a static web page hosted on Amazon Simple Storage Service (Amazon S3).

2.Amazon API Gateway triggers an AWS Lambda function, New Post , which initiates the creation of the MP3 file.

3.The Lambda function inserts the post information into an Amazon DynamoDB table, where information about all posts is stored.

4.To run the entire process asynchronously, you use Amazon Simple Notification Service (Amazon SNS) to separate the process of receiving information about new posts and starting to convert them to audio.

5.Another Lambda function, Convert to Audio , is subscribed to your SNS topic and is triggered whenever a new message arrives (meaning a new post will be converted to an audio file).

6.The Convert to Audio Lambda function uses Amazon Polly to convert text into an audio file in the specified language (the same language as the text).

7.The new MP3 file is stored in a dedicated S3 bucket.

8.The post information is updated in a DynamoDB table. The URL to the audio file stored in the S3 bucket is saved along with the previously stored data.

**When the application retrieves post information:**

1.The RESTful web service is implemented using Amazon API Gateway. Amazon API Gateway provides methods for retrieving information about posts. These methods contain the post content and a link to the S3 repository where the MP3 file is stored. The web service is called by a static web page hosted on Amazon S3.

2.Amazon API Gateway calls the Get Post Lambda function, which implements the logic for retrieving post data.

3.The Get Post Lambda function will retrieve information about the post (including a reference to Amazon S3) from a DynamoDB table and return the information.