# frozen_string_literal: true
#
require 'pry'
require 'lightly'

class Rapidapi
  MAX_PAGES = 1

  attr_reader :uri, :key, :query, :location

  def initialize(uri:, query:, location: nil, max_pages: MAX_PAGES)
    @uri = uri
    @key = ENV.fetch("RAPID_API_KEY")
    @query = query
    @location = location
    @max_pages = max_pages
    @cache = Lightly.new
    @cache.dir = '/tmp/cache'
    @cache.life = '5d'

    @conn = Faraday.new(
      headers: headers
    ) do |f|
      f.request  :json
      f.response :json
      f.response :raise_error
    end
  end

  def process
    results = []
    @max_pages.times do |page|
      p = page + 1
      json = @cache.get(cache_key(p)) do
        send(config[:action], p)
      end

      json.each do |item|
        job = Job.new
        job.url = item[keys[:job_url]]
        job.title = item[keys[:job_title]]
        job.company_name = item[keys[:company_name]]
        job.company_url = item[keys[:company_url]]
        job.posted = Date.parse(item[keys[:posted_date]])

        results << job
      end
    end
    
    results
  end

  private

  def post(p)
    response = @conn.post("https://#{config[:request_url] || uri}") do |req|
      req.body = params(p).to_json
    end
    json(response)
  end

  def get(p)
    response = @conn.get("https://#{config[:request_url] || uri}", params(p))
    json(response)
  end

  def json(response)
    json = response.body
    json = JSON.parse(response.body) if response.body.is_a?(String)
    json = json[keys[:root]] unless keys[:root].nil?
    json
  end

  def headers
    { "content-type" => "application/json",
      "X-RapidAPI-Key" => @key,
      "X-RapidAPI-Host" => @uri }
  end

  def cache_key(page)
    "#{uri}-#{query}-#{location}-#{page}"
  end

  def params(page)
    p = {}
    p[keys[:query]] = query
    p[keys[:location]] = location unless location.nil?
    p[:page] = page

    p
  end

  def keys
    config[:keys]
  end
end
