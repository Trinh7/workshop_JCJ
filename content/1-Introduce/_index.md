---
title : "Introduction"
date : "2023-07-15"
weight : 2
chapter : false
pre : " <b> 2. </b> "
---
**Building a Serverless Text-to-Speech App with Amazon Polly**

Speech synthesis is not easy in general. You can't assume that when an app reads each letter of a sentence, the output will make sense. Some common challenges for text-to-speech apps include:

Words that are spelled the same but pronounced differently: I live in Las Vegas vs. This presentation is broadcast live from Las Vegas .
Text normalization: Distinguish between abbreviations, acronyms, and units: St. , which can expand to Street or Saint .
Text-to-phoneme conversion in languages with complex mappings, such as in English, tough , through , and though . In this example, similar parts of different words can be pronounced differently depending on the word and context.
Foreign words ( déjà vu ), proper names ( François Hollande ), and slang ( ASAP , LOL ).
Amazon Polly provides speech synthesis that overcomes these challenges, allowing you to focus on building text-to-speech applications instead of solving translation challenges.

Amazon Polly turns text into realistic speech. It enables you to create apps that speak naturally, allowing you to build entirely new categories of voice-enabled products. Amazon Polly is an AI service from Amazon that uses advanced deep learning technology to synthesize voices that sound like human speech. It currently includes dozens of realistic voices in over 20 languages, so you can choose your ideal voice and build voice-enabled applications that work in many different countries.

In addition, Amazon Polly provides the fast, consistent response times needed to support real-time interactive conversations. You can cache and store Polly audio files for offline playback or redistribution. In other words, what you convert and store is yours. There are no additional text-to-speech conversion fees when using voice. Polly is also easy to use. Simply send the text you want to convert to speech to the Amazon Polly API. Amazon Polly instantly returns the audio stream to your application, which can be played live or stored in a standard audio file format such as MP3.

In this workshop, you will create a basic, serverless application that uses Amazon Polly to convert text to speech. The application has a simple user interface, accepts text in a variety of languages, and then converts it to an audio file that you can play from your web browser. This workshop uses blog posts, but you can use any type of text. For example, you could use the app to read recipes while you prepare a meal, or read the news or a book while you drive or bike.