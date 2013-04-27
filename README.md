MongoLabiOSSDK
==============

Mongo Lab iOS SDK

Fast access for your iPhone projects to Mongo Lab's MongoDB Paas.

This is an Objective-C Library for MongoLab REST based MongoDB interface.

Simple usage and demo app
-------------------------

There is a sample demo app with usage.


You will need to get an APIKey from the MongoLab portal, create a free account and you can then obtain your Key to use this SDK.

You can create a database on the MongoLab portal, creating a Collection is simple, you just add in an object, inserting an object requires you to specify a database name (Created on the portal) as well as a Collection name, once the collection has at least one item inserted, it is created on the database, this is standard MongoDB usage.

You can get a list of Databases using the SDK, you probably already know what databases you have.

You can get a list of Collections in your database using the database name, this will contain system collection (That you probaly will not use) and your user defined collections.

You can get a list of all items in a collection, this can be the complete set or you can use a simple query such as "{"name": "smith"}", this is the same format as a query in MongoDB.

Once you have items inserted into a colleciton, you can query based on a query parameter as well as skips and limits, all the raw interfaces supported in the Mongo Lab REST API should be supported.

Location based queries are fully spoorted, this is a great way to get fast locations into an app.

Enjoy the SDK. 

