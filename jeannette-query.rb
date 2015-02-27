#!/usr/bin/env ruby -U

## Ruby script to retrieve Jeannette records from oldWeather3 MongoDB backend

## Initial setup

# Import required gems
require 'rubygems'
require 'mongo'
require 'fileutils'
require 'json'
include Mongo

# Initialize Mongo client
client = MongoClient.new

# Access database
db = client.db('oldWeather3-production-live') # Database

# Get path to this script
script_path = File.dirname(__FILE__)

# Array of collection names we'll use
collections = ['annotations', 'assets', 'entities', 'ships', 'transcriptions', 'voyages']
# Full list of collection names: ["annotations", "system.indexes", "assets", "collection_sources", "entities", "ships", "system.users", "templates", "transcriptions", "voyages", "zooniverse_users"]

# For each collection name in the above array, check if a directory for that collection exists; if not, make one
collections.each do |coll_name|
  FileUtils.mkdir_p("#{script_path}/#{coll_name}")
end

# Declare ship and voyage IDs so we can access Jeannette records using them (I just went in and found these manually)
j_ship_id = BSON::ObjectId('50a27fd77438ae05bd000002')
j_voyage_id = BSON::ObjectId('50874f4d09d4090755026717')

puts 'Initial setup complete' # Output status to shell


## Ships

# Retrieve Jeannette record by name (1 record)
ships = db['ships'].find('name' => 'Jeannette').to_a

# For each ship named Jeannette, write a formatted JSON file and name it with voyage ID
ships.each do |record|
  id = record['_id']
  File.open("#{script_path}/ships/#{id.to_s}.json", 'w') do |f|
    f.write(JSON.pretty_generate(record))
  end
end

puts 'Ships complete' # Output status to shell


## Voyages

# Retrieve Jeannette voyages by ship_id (1 record)
voyages = db['voyages'].find('ship_id' => j_ship_id).to_a

# For each voyage, write a formatted JSON file and name it with voyage ID
voyages.each do |record|
  id = record['_id']
  File.open("#{script_path}/voyages/#{id.to_s}.json", 'w') do |f|
    f.write(JSON.pretty_generate(record))
  end
end

puts 'Voyages complete' # Output status to shell


## Assets

# Retrieve all Jeannette assets by voyage ID (27,525 records)
assets = db['assets'].find('voyage_id' => j_voyage_id).to_a

# For each asset, write a formatted JSON file and name it with asset ID
assets.each do |record|
  id = record['_id']
  File.open("#{script_path}/assets/#{id.to_s}.json", 'w') do |f|
    f.write(JSON.pretty_generate(record))
  end
end

puts 'Assets complete' # Output status to shell


## Entities

# Retrieve all entities, period (8 records)
entities = db['entities'].find.to_a

# For each entity, write a formatted JSON file and name it with entity ID
entities.each do |record|
  id = record['_id']
  File.open("#{script_path}/entities/#{id.to_s}.json", 'w') do |f|
    f.write(JSON.pretty_generate(record))
  end
end

puts 'Entities complete' # Output status to shell


## Transcriptions

# Retrieve Jeannette transcriptions by voyage ID (17,105 records)
transcriptions = db['transcriptions'].find('voyage_id' => j_voyage_id).to_a

# Instantiate array for transcription IDs to key on when retrieving annotations
transcription_ids = Array.new

# For each transcription, write a formatted JSON file and name it with transcription ID
transcriptions.each do |record|
  id = record['_id']
  transcription_ids << id # Add transcription_id to array as string
  File.open("#{script_path}/transcriptions/#{id.to_s}.json", 'w') do |f|
    f.write(JSON.pretty_generate(record))
  end
end

puts 'Transcriptions complete' # Output status to shell


## Annotations

# Loop through transcription_ids array, query DB for annotations keyed to each transcription ID, and export the annotations as JSON files (warning: this comes out to 145,923 records; it will take a while!)
transcription_ids.each do |tr_id|
  subset = db['annotations'].find('transcription_id' => tr_id).to_a # Find annotations keyed to this transcription ID
  subset.each do |record|
    File.open("#{script_path}/annotations/#{record['_id'].to_s}.json", 'w') do |f|
      f.write(JSON.pretty_generate(record))
    end
  end
end

puts 'Annotations complete' # Output status to shell


## Export complete

puts 'All records complete' # Output status to shell
