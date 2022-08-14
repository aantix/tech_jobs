# frozen_string_literal: true

def to_array(str)
  str&.split(/,/)&.collect(&:strip)&.compact
end

technology = ARGV[0]
location   = ARGV[1]
titles     = to_array(ARGV[2])

if technology.nil? || titles.empty?
  puts "Usage: tech_jobs <technology> <prospect titles>"
  puts "  E.g. tech_jobs \"node.js\" \"94132\" \"cto,vp of engineering,director of engineering\""
  exit(1)
else
  puts "Technology: #{technology}"
  puts "Prospect titles: #{titles.join(',')}"
  puts
end

puts "Searching Google Jobs for #{technology} jobs in #{location}"
results = Google.new(location, technology).process

results.each do |result|
  puts "Search Apollo.io for #{titles.join(",")} for : #{result.company_domain}"
  result.prospects = Apollo.new(titles: titles, domains: result.company_domain).process

  puts "#{result.title}\t#{result.url}\t#{result.company_name}\t#{result.company_url}"

  result.prospects.each do |prospect|
    puts "  #{prospect.full_name}\t#{prospect.email}"
  end
end
