---
title : "Exposing Lambda Functions as RESTful Web Services"
date: "2023-07-15"
weight : 8
chapter : false
pre : " <b> 3.1.8 </b> "
---

The last thing you need to do is develop your logic application as a RESTful web service that can be easily called using the standard HTTP protocol. To do this, you use Amazon API Gateway.

1.At the top of the **AWS Management Console**, in the search bar, search for and select **.API Gateway**

2.In the Rest API console, select **Build.**

3.In the **Create REST API** section, for API details, use the following parameters:

- Select **New API**
- API Name: **PostReaderAPI**
- Description: **API for PostReader Application**
- Endpoint Type: **Region**

1. Select **Create API.**

After creating the API, you need to create two **HTTP methods.**

#### You start by configuring the **POST** method to call the Lambda function **PostReader_NewPost** .

1.In the Method section, select **Create Method.**

2. For the **Method** type, select **POST** .

3. For the Lambda Function, select the function that has **PostReader_NewPost** in its name.

4. Choose **Create Method.**

#### For the **GET** method, the API will call the Lambda function PostReader_GetPost .

1. In the **Resource** blank, select the **/** icon above **POST** .

2. In the method range, select **Create Method**.

3. For the **Method** type, select **GET** .

4. For the Lambda Function, select the function that has **PostReader_GetPost** in its name.

5. Choose **Create Method.**

#### The last method to configure is CORS (Cross-origin resource sharing). This method allows calling the API from a website with a different nameserver.

1.In the **Resources** pane, select the **/** icon above **GET** .

2.In the Resource section, select **Enable CORS** .

3. For Gateway response, select Default **4XX** and Default **5XX** .

4. For **Access-Control-Allow-Methods** , select **GET and POST** .

5. Select **Save.**
![FWD](/images/lambda13.png)

#### Now you configure the GET method for the query postId parameter, which provides information about the id of the post to respond to.

1. Choose the **GET** method.

2.In the **Settings** request method, select **Edit** .

3.Expand the URL query string parameter extension.

4. Choose **Add Query String**.

5. For Name , enter .**postId**

6. Select **Save.**

#### The Lambda PostReader_GetPost function is expected to receive input data in JSON format, so the API needs to be configured to map parameters to this format. To do this, you can add the mapping to the Integration Request configuration.

1. Choose the **Integration Request** tab.

2.In the **Integration Request** settings, select **Edit.**

3. For **Request Forwarding Content**, select **When no template is defined (can be exported).**

4.Expand **Map Templates.**

5. Choose **Add Template Model.**

6. For **Remove Content**, enter **.application/json**

7. For **Body Template**, enter:

        {
            "postId" : "$input.params('postId')"
        }

1. Select **Save.**

#### The API is now available for declarative development!

1. ChooseDeploy API.

- **Stage**: Select **New Stage**

- **Name**: Dev
- ChooseDeploy

1.Copy the **Call URL** value and save it to the editor for later use.

**Note:** The URL is used later to interact with the application.