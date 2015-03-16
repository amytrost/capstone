#!/usr/bin/env ruby -U

# Extend Enumerable with method to generate formatted JSON
module Enumerable
  def to_pretty_json
    JSON.pretty_generate(self)
  end
end

# Extend String with method to transform into BSON ObjectId
class String
  def to_bson_id
    BSON.ObjectId(self)
  end
end
