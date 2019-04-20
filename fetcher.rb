#!/usr/bin/env ruby
require 'open-uri'
require 'json'
require 'yaml'

records = JSON.load(open("https://www.praha7.cz/api/desk/all"))

records.group_by{|a| a['official_desk_date'][0..3]}.each{|rok,records|
  filename = "source/uredni_deska_#{rok}.json"
  File.open(filename,"w"){|f| f <<
    JSON.pretty_generate(records.sort{|a,b| a['id']<=>b['id']})
  }
}
