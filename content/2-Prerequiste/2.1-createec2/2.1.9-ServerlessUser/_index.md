---
title : "Create a Serverless UI"
date: "2023-07-15"
weight : 9
chapter : false
pre : " <b> 3.1.9 </b> "
---

**Although the application is fully functional, it is only exposed as a RESTful web service. You now deploy a small website to Amazon S3, a great option for hosting static websites. This website uses JavaScript to connect to the API and provide text-to-speech functionality within the website.**

1.Download these files to your computer, right-click and select "Save link as...".

- [index.html](/files/index.html)
- [scripts.js](/files/scripts.js)
- [styles.css](/files/styles.css)

Note: Make sure each file retains its original file name, including the extension.

2. Edit your **scripts.js** file using a Text Editor, replacing YOUR_API_GATEWAY_ENDPOINT (on the first line) with the **Invoke URL** you copied earlier.

Expected output:

                var API_ENDPOINT = "https://xxxxx.execute-api.us-west-2.amazonaws.com/Dev"

#### Now upload these files to your Amazon S3 bucket.

1.At the top of the **AWS Management Console**, in the search bar, search for and select **S3.**

2.Select **Create Bucket** and configure the following details:

- Bucket name: **www-BUCKET**
- Replace BUCKET with the name of your audio post bucket
- Copy the bucket name into a text editor. You will use the bucket name later.
- Change the permissions of the bucket so that everyone can access the site.
- Under **Object Ownership**, select **ACL enabled**
- Under **Settings to block public access for this bucket**, uncheck the Block all public access option, then uncheck all other options.

**Note:** Note that all individual options remain unchecked. When you uncheck all public access, you must select the individual options that apply to your situation and security goals. In production, it is recommended to use the least permission setting possible.

A warning box appears that reads: Disabling the option to block all public access may make this bucket and its objects public. AWS recommends that you leave the option to block all public access enabled unless public access is required for specific and verified use cases, such as hosting a static website.

- Select the checkbox next to **I acknowledge that the current settings may make this bucket and its objects public.**

- Select **Create Bucket**

1.After you have created the bucket, select it from the bucket list and upload three files to your new www bucket.

**Note:** The files must be named: **index.html** , **scripts.js** , and **styles.css**

1.On the bucket page, select the Permissions tab at the top.

2.Scroll down to the **Group Policy** section and select **Edit.**

3.Paste this policy into the editor:

        {
        "Version": "2012-10-17",
        "Statement": [
        {
        "Sid": "PublicReadGetObject",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
        "s3:GetObject"
        ],
        "Resource": [
        "arn:aws:s3:::www-BUCKET/*"
        ]
        }
        ]
        }

1.Replace **www-BUCKET** with your **www-audioposts** group name.

2.Select **Save Changes**.

**WARNING:** If you receive an error The policy has an invalid resource, confirm that you have edited the Resource line to match your group name.

**Note:** You can ignore the This bucket has public access warning. This is intentional.

Finally, you enable **static website hosting**, which makes the bucket act like a static website.

1.Select the **Properties** tab.

2.Ignore the **AWS CloudTrail Permissions** error.

3.Scroll down to the **Static Website Hosting** section and select **Edit**.

4.Select **Enable** for the static website hosting service.

- Index document: index.html
- Error document: index.html

**Note:** We are currently using the index.html file as the error document.

- Select: **Save Changes.**

1.Copy the endpoint URL to your clipboard.

That's it! You can now test if the website is live.

1.Open a new web browser tab and paste the Endpoint URL you just copied.

You should see a page that looks like this:

![FWD](/images/lambda14.png)

If you write something in the text area and select **Speak**, an event will be sent to your app. The app will convert the text into an audio file asynchronously. Depending on the size of the text you provide, the conversion may take a few seconds or a few minutes.

To view posts and their audio files, enter the post ID or * in the Search box:
![FWD](/images/lambda15.png)

1.Press the Play button to hear the audio.