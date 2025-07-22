---
title : "Create a Lambda Function to Convert to Audio"
date: "2023-07-15"
weight : 5
chapter : false
pre : " <b> 3.1.5 </b> "
---

**Now you create a Lambda function to convert text stored in a DynamoDB table to an audio file.**

1. Select **Functions** in the upper left navigation pane.

Note: You may need to expand the navigation pane by selecting the menu icon.

1.Select **Create Function.**
2.Select **Author from scratch** and use the following settings:

- Function name: ConvertToAudio
- Runtime: Python 3.12
- Expand Change default execution role
- Execution role: Select Use existing role
- Current role: Select Lab-Lambda-Role

1.Scroll down and select **Create Function.**
2.Enter code: Delete the existing code and paste the following code:

       import boto3
       import os
       from contextlib import closing
       from boto3.dynamodb.conditions import Key, Attr
       
          def lambda_handler(event, context):
          
              postId = event["Records"][0]["Sns"]["Message"]
          
              print ("Text to Speech function. Post ID in DynamoDB: " + postId)
          
              # Retrieving information about the post from DynamoDB table
              dynamodb = boto3.resource('dynamodb')
              table = dynamodb.Table(os.environ['DB_TABLE_NAME'])
              postItem = table.query(
                  KeyConditionExpression=Key('id').eq(postId)
              )
          
          
              text = postItem["Items"][0]["text"]
              voice = postItem["Items"][0]["voice"]
          
              rest = text
          
              # Because single invocation of the polly synthesize_speech api can
              # transform text with about 3000 characters, we are dividing the
              # post into blocks of approximately 2500 characters.
              textBlocks = []
              while (len(rest) > 2600):
                  begin = 0
                  end = rest.find(".", 2500)
          
                  if (end == -1):
                      end = rest.find(" ", 2500)
          
                  textBlock = rest[begin:end]
                  rest = rest[end:]
                  textBlocks.append(textBlock)
              textBlocks.append(rest)
          
              # For each block, invoke Polly API, which transforms text into audio
              polly = boto3.client('polly')
              for textBlock in textBlocks:
                  response = polly.synthesize_speech(
                      OutputFormat='mp3',
                      Text = textBlock,
                      VoiceId = voice
                  )
          
                  # Save the audio stream returned by Amazon Polly on Lambda's temp
                  # directory. If there are multiple text blocks, the audio stream
                  # is combined into a single file.
                  if "AudioStream" in response:
                      with closing(response["AudioStream"]) as stream:
                          output = os.path.join("/tmp/", postId)
                          if os.path.isfile(output):
                              mode = "ab"  # Append binary mode
                          else:
                              mode = "wb"  # Write binary mode (create a new file)
                          with open(output, mode) as file:
                              file.write(stream.read())
          
              s3 = boto3.client('s3')
              s3.upload_file('/tmp/' + postId,
                os.environ['BUCKET_NAME'],
                postId + ".mp3")
              s3.put_object_acl(ACL='public-read',
                Bucket=os.environ['BUCKET_NAME'],
                Key= postId + ".mp3")
          
              location = s3.get_bucket_location(Bucket=os.environ['BUCKET_NAME'])
              region = location['LocationConstraint']
          
              if region is None:
                  url_beginning = "https://s3.amazonaws.com/"
              else:
                  url_beginning = "https://s3-" + str(region) + ".amazonaws.com/"
          
              url = url_beginning \
                      + str(os.environ['BUCKET_NAME']) \
                      + "/" \
                      + str(postId) \
                      + ".mp3"
          
              # Updating the item in DynamoDB
              response = table.update_item(
                  Key={'id':postId},
                    UpdateExpression=
                      "SET #statusAtt = :statusValue, #urlAtt = :urlValue",
                    ExpressionAttributeValues=
                      {':statusValue': 'UPDATED', ':urlValue': url},
                  ExpressionAttributeNames=
                    {'#statusAtt': 'status', '#urlAtt': 'url'},
              )
          
              return


Check the code. The Lambda function performs the following functions:

- Retrieve the ID of the DynamoDB item (post ID) that needs to be converted to an audio file from the input message (SNS event)
- Get the item from DynamoDB
- Convert the text to an audio stream
- Put the audio file (MP3) into an S3 bucket
- Update the DynamoDB table with a reference to the S3 bucket and the new state

The **synthesize_speech** method takes the text to be converted and the voice used. In return, it provides the **audio stream** . The problem is that the input text is limited to 3000 characters. Since a post can be very long, the posts need to be split into blocks of about 2500 characters, depending on the ending position of the last word in the block. After converting the blocks to audio streams, they are concatenated together.

1. Select **Deploy**.
![FWD](/images/lambda4.1.png)
![FWD](/images/lambda4.png)

Similar to the New Post function, you need to tell this Lambda function which services it can interact with via Environment variables.

1.Select the **Configuration** tab to configure the environment variables.

2.In the left navigation pane, select **Environment Variables** .

3.In the **Environment Variables** section, select **Edit**.

- Select Add Environment Variable

- Key: **EnterDB_TABLE_NAME**
- Value: Enter **posts**

- Select **Add Environment Variable**
- Key: Enter **BUCKET_NAME**

- Value: Enter the name of the bucket you created earlier. The name will look similar to this: **audioposts-123**

1.Select **Save**.

The posts to be converted can be quite large, so you need to extend the maximum execution time of a code to 5 minutes.

1.In the **General Configuration** section, select **Edit**.

- Update the timeout to 5 minutes.

1.Select **Save**.

Now you configure the function to automatically fire when a message is sent to the SNS topic you created earlier.

1.In the **Triggers** section, select **Add Trigger** and then configure:

- Select source: **SNS**
- SNS topic: Choose from the available topics **.new_posts**

1.Select **Add**.

Now you are ready to test if the two Lambda functions communicate successfully over SNS and generate the Polly audio file.
![FWD](/images/lambda5.png)