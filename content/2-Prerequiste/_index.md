---
title : "Preparation and implementation steps"
date: "2023-07-15"
weight : 3
chapter : false
pre : " <b> 3. </b> "
---

{{% notice info %}}
You will need to prepare an AWS account with administrative rights that can access the AWS Management Console to start the project

{{% /notice %}}

**Launch the CloudFormation Stack**

The AWS CloudFormation template is used to set up lab resources in the AWS Region you choose. This step is required because the following instructions will rely on these resources. The CloudFormation template provides the following resources:

- IAM roles.

- Amazon DynamoDB tables.

- AWS Step Function State Machine.

1.Download the CloudFormation template

2.Store the YAML template file in a folder on your local machine.

3. Navigate to CloudFormation in the AWS Management Console.

4. On the CloudFormation console, select Upload Template File.

5. Select the template you just downloaded, and then select Next.

![FWD](/images/anh1.png)

6. Give the stack a name, such as polly-serverless-stack

7. For the Stack Configuration option, leave the default value and select Next.

8. Under Capabilities and Transformations, acknowledge all.

![FWD](/images/anh2.png)

9. To deploy the template, select Submit.

10. Once the template is deployed, to review the resources you created, navigate to CloudFormation Resources and then select the CloudFormation stack you created.

Cloud Formation deployment takes about 1–2 minutes to complete.