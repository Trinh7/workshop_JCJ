---
title : "Create DynamoDB Table"
date: "2023-07-15"
weight : 1
chapter : false
pre : " <b> 3.1.1 </b> "
---

#### Create DynamoDB Table **Lab DynamoDB**
1. At the top of the AWS Management Console, in the search bar, search for and select DynamoDB.

2. Select **create table**.

3. Create a new DynamoDB table with:

Table name: **posts**

Partition key: (String)**id**

Table settings: **Default settings**

4. Select : **Create table**

There is no need to define the entire table structure now. After completing the application setup, the following information will be stored in the DynamoDB table:

- id: The ID of the post.
- status: UPDATED or PROCESSING, depending on whether the MP3 file has been generated.

- text: The text of the post where the audio file is being generated.

- voice: The Amazon Polly voice used to generate the audio file.

- url: The link to the S3 bucket where the audio file is stored.