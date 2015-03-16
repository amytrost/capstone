#!/usr/bin/env ruby -U

# Import required gems
require 'rubygems'
require 'mongo'
require 'fileutils'
require 'json'
include Mongo

# Import our custom methods
require_relative 'lib/mixins'

# Initialize Mongo client
client = MongoClient.new

# Access database
db = client.db('oldWeather3-production-live') # Database

# Get path to this script
script_path = File.dirname(__FILE__)

transcriptions = db['transcriptions'].find("asset_id" => "50874f4f09d4090755026771".to_bson_id).to_a

puts "asset_id: 50874f4f09d4090755026771"

puts "Transcriptions: #{transcriptions.length}"

puts "Annotations for each transcription:"

transcriptions.each do |tr|
  id = tr['_id']
  ann = db['annotations'].find('transcription_id' => id).to_a
  puts "  #{id}: #{ann.length}"
end

# annotations = db['annotations'].find("transcription_id" => "50a05d597438ae65ca0024a9".to_bson_id).to_a

# assets = db['assets'].find("_id" => "50874f4f09d4090755026771".to_bson_id).to_a

# annotations.each { |i| File.open("#{i['_id']}.json", 'w') { |f| f.write(i.to_pretty_json) } }
