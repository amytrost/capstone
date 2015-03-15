#!/usr/bin/env python

# Import package and client
import pymongo
# from pymongo import MongoClient

# Initialize Mongo client
client = pymongo.MongoClient()

# Access database
db = client["oldWeather3-production-live"]

# Get list of collections
db.collection_names()

# Output one record from entities collection
db.entities.find_one()
