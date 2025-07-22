---
title : "Create a Lambda Function "
date: "2023-07-15"
weight : 4
chapter : false
pre : " <b> 3.1.4 </b> "
---

#### Create a Lambda Function for New Posts

The first Lambda function you create is the entry point for the application. It receives information about new posts that need to be converted to audio files.

1.At the top of the **AWS Management Console**, in the search bar, search for and select **Lambda**.

2.Select **Create Function**.

3. Select **Author from scratch** and use the following settings:

- Function name: **PostReader_NewPost**
- Runtime: **Python 3.12**
- Extension **Change default execution role**
- Execution role: Select **Use existing role**
- Current role: Select **Lab-Lambda-Role**

1. Select Create function.

2.Enter code: Delete the existing code and paste the following code:


      import boto3
      
      import os
      
      import uuid
      
      def lambda_handler(event, context):
      
          recordId = str(uuid.uuid4())
          voice = event["voice"]
          text = event["text"]
      
          print('Generating new DynamoDB record, with ID: ' + recordId)
          print('Input Text: ' + text)
          print('Selected voice: ' + voice)
      
          # Creating new record in DynamoDB table
          dynamodb = boto3.resource('dynamodb')
          table = dynamodb.Table(os.environ['DB_TABLE_NAME'])
          table.put_item(
              Item={
                  'id' : recordId,
                  'text' : text,
                  'voice' : voice,
                  'status' : 'PROCESSING'
              }
          )
      
          # Sending notification about new post to SNS
          client = boto3.client('sns')
          client.publish(
              TopicArn = os.environ['SNS_TOPIC'],
              Message = recordId
          )
      
          return recordId

![FWD](/images/lambda2.png)

Check the code. The Lambda function performs the following functions:

- Takes two input parameters:

- Voice: One of dozens of voices supported by Amazon Polly.

- Text: The text of the post that we want to convert to an audio file.

- Creates a new record in the DynamoDB table with information about the new post.

- Publishes information about the new post to SNS (the item ID/DynamoDB post ID is published there as a message).

- Returns the DynamoDB item ID to the user.

1. Select **Deploy**.

**Note**: The Lambda function needs to know the DynamoDB table name and SNS topic. To provide these values, you use environment variables. This is a great way to pass information to a function without hard-coding the values into the function itself.

1. Select the **Configuration** tab to configure environment variables.

2. In the left navigation pane, select **Environment Variables** .

3. In the Environment Variables section, select **Edit** .

- Select **Add Environment Variable.** .

- Key: Enter **DB_TABLE_NAME** . - Value: Enter **posts** .

1. Select **save** .

2. In the left navigation pane of the Configuration tab, select **General Configuration** .

- Update the timeout to 10 seconds .

1. Select **save** .

The **New Post Lambda** function is ready! Now you can test if the function works.

1.Select the Test tab and configure the following details:

- Event name: Joanna
- Enter code: Delete the existing code and paste the following code:

        {
           "voice": "Joanna",
           "text": "This is working!"
        }

1.Select **Save**.

2.Select **Test** to run your test event.

You will see the message: **Execution result: successful** .

You can expand the **Details** section to see the execution log.

![FWD](/images/lambda3.png)

The **New Post Lambda** function returns an ID and you can see the input values in the **Log** output.