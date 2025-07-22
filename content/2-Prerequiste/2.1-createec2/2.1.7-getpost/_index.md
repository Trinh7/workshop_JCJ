---
title : "Create a getpost Lambda Function"
date: "2023-07-15"
weight: 7
chapter : false
pre: " <b> 3.1.7 </b> "
---

Finally, the *Get Post Lambda* function provides a way to get information about posts from a database.

1.At the top of the AWS Management Console, in the search bar, search for and select Lambda.

2. Choose **Create Function**.

3. Choose **Author from scratch** and use the following settings:

- Function name: **PostReader_GetPost**
- Runtime: **Python 3.12**
- Expand width Change default execution role
- Execution role: Select **Use existing role**
- Current role: Select **Lab-Lambda-Role**

1.Scroll down and select **Create function.**

2.Import code: Delete existing code and encode the following:

          import boto3
          
          import operating system
          import keyword boto3.dynamodb.conditions, Attr
          
          def lambda_handler(event, context):
          
          postId = event["postId"]
          
          dynamodb = boto3.resource('dynamodb')
          table = dynamodb.Table(os.environ['DB_TABLE_NAME'])
          
          if postId=="*":
          item = table.scan()
          else:
          item = table.query(
          KeyConditionExpression=Key('id').eq(postId)
          )
          
          return item["Item"]

This time, the code is very short. This function is expected to take the post ID (DynamoDB item ID) and based on this ID, it will retrieve all the information (including the S3 link to the audio file if available) and return it. To be more user friendly if the input parameter is an asterisk (*), the Lambda function will return all the items from the database. For databases with many items, avoid using this method as it can reduce performance and can take a long time.

1. Choose **Deploy.**

Again, you need to provide the table name **DynamoDB** as the environment variable for the function.

1. Choose the **Configuration** tab to configure the environment variable.

2.In the left navigation pane, select **Environment Variables** .

3.In the **Field Variables** section, select **Edit**.

- Select **Add Environment Variable**

- Key: Import **DB_TABLE_NAME**
- Value: Import **post**

1. Select **Save**.

![FWD](/images/lambda11.png)

Now you can test this function!

1.In tab 88, create your test event with the following parameters:

- Event name **AllPosts**
- Enter code: Replace the current code with the following:

         {
            "postId": "*"
         }

1. Select **Save**.

2. Select **Test** to run the event test.

You will see the message: Execution result: **success**

If you expand the **Details** section, you will see a list of all records from the **DynamoDB.** table
![FWD](/images/lambda12.png)