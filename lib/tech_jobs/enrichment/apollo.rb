# frozen_string_literal: true

class Apollo
  URI       = "https://api.apollo.io/v1/mixed_people/search"
  MAX_PAGES = 1

  attr_reader :key, :domains, :titles

  def initialize(domains: [],
                 titles: [],
                 max_pages: MAX_PAGES)
    @uri       = URI
    @key       = ENV.fetch("APOLLO_API_KEY")
    @domains   = Array(domains)
    @titles    = Array(titles)

    @cache = Lightly.new
    @cache.dir = '/tmp/cache'
    @cache.life = '5d'

    @conn = Faraday.new(
      headers: { "Content-Type" => "application/json",
                 "Cache-Control" => "no-cache" }
    )
  end

  def process
    results = []
    MAX_PAGES.times do |page|
      people = @cache.get(cache_key(p)) do
        response = @conn.post(URI) do |req|
          req.params['page'] = page
          req.params['person_titles'] = titles
          req.params['q_organization_domains'] = domains.join("\n")
          req.params['api_key'] = key
        end
        JSON.parse(response.body)['people']
      end

      people.each do |item|
        person = Person.new
        person.first_name = item['first_name']
        person.last_name = item['last_name']
        person.linkedin_url = item['linkedin_url']
        person.email = item['email']
        person.photo_url = item['photo_url']

        results << person
      end
    end

    results
  end

  private
  def cache_key(page)
    "#{domains.join('-')}-#{titles.join('-')}-#{page}"
  end
end
