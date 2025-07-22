---
title : "Create SNS Topic"
date: "2023-07-15"
weight : 3
chapter : false
pre : " <b> 3.1.3 </b> "
---

#### Create SNS Topic

As you may have seen in the architecture diagram, the logic for converting a post (text) to an audio file is split into two AWS Lambda functions. This is done for a couple of reasons.

First, it allows the application to use asynchronous calls so that when a user submits a new post to the application, it immediately receives the ID of the new DynamoDB item, so the application knows what to request next without having to wait for the conversion to complete. For small posts, the conversion to an audio file can take a few milliseconds, but for larger posts (100,000 words or more), the text conversion can take much longer. In other use cases, such as real-time streaming, size is not an issue because Amazon Polly starts streaming voice as soon as the first byte is available.

Second, the system uses a Lambda function to convert the posts.

Since the process has been split into two processes, there needs to be a way to integrate them together. You use Amazon SNS to send notifications about new posts from the first function to the second function.

1. At the top of the AWS Management Console, in the search bar, search for and select .Simple Notification Service

2. In the left navigation pane, select **Topics** .

**Note**: You may need to expand the navigation pane by selecting the menu icon.
1.Select Create Topic and configure the following details:

- Type: **Select Standard**

- Name: **new_posts**

- Display Name: **New Posts**

1.At the bottom of the page, select **Create Topic**.

2.Copy the Topic ARN and paste it into a text editor for later use.

**Expected Output:**
arn:aws:sns:us-west-2:123456789012:new_posts

**Note**: You will configure your Lambda functions to use this Topic ARN later in the lab.
![FWD](/images/sns.png)