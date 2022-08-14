# frozen_string_literal: true

require "zip-codes"

class Indeed < Rapidapi
  def initialize(location, query)
    city_state = ZipCodes.identify(location)
    super(uri: "indeed11.p.rapidapi.com", query: query, location: "#{city_state[:city]}, #{city_state[:state_code]}")
  end

  def config
    {
      keys:
        {
          root: nil,
          job_url: "url",
          job_title: "job_title",
          company_name: "company_name",
          company_url: nil,
          posted_date: "posted_date",
          query: "search_terms"
        },
      action: :post
    }
  end
end
