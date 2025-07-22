---
title : "Testing the functions"
date: "2023-07-15"
weight : 6
chapter : false
pre : " <b> 3.1.6 </b> "
---

**Now try the following workflow:**

- Manually trigger the New Post Lambda function
- It stores the data in DynamoDB and sends a message to the SNS topic
- SNS triggers the Convert to Audio function, using Polly to generate the audio file and store it in the S3 bucket

1.Select **Functions** in the upper left corner.

Note: You may need to expand the navigation pane by selecting the menu icon.

1.Select the **PostReader_NewPost** function.

2.Select **Test**.

You should see the message: Execution result: **success** .

![FWD](/images/lambda6.png)

This indicates that the function has been executed. Now you confirm that the other steps have also completed successfully.

1.At the top of the **AWS Management Console**, in the search bar, search for and select **.DynamoDB**

2.In the left navigation pane, select **Explore Items** .

3.Select **Posts** .

You will see two entries because you ran the test twice. The second execution will also trigger the Convert to Audio Lambda function, so there is also an entry for the url .

![FWD](/images/lambda7.png)

1.At the top of the **AWS Management Console**, in the search bar, search for and select **.Lambda**

2.Select the **ConvertToAudio** function.

3.Select the **Monitoring** tab.

The monitoring graph should indicate that the function was called.
![FWD](/images/lambda8.png)

1.Select View logs **CloudWatch**

2.Select the Log Stream displayed in the list

3.Expand the log entries to explore the error message

For example, if you receive the error The specified bucket does not exist , you need to confirm that the bucket name you entered in the Environment Variable matches the S3 bucket name you created earlier in the lab.
![FWD](/images/lambda9.png)

If the Convert to Audio function was successful, you should see an MP3 file in your S3 bucket.

1.At the top of the **AWS Management Console**, in the search bar, search for and select .**S3**

2.Select your audio post bucket .

You should see an MP3 file. Download and listen — you'll hear Polly's Joanna say "This works!"
![FWD](/images/lambda10.png)