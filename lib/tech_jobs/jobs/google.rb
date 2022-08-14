# frozen_string_literal: true
require 'zip-codes'

class Google < Rapidapi
  URL = 'google-jobs-search.p.rapidapi.com'
  def initialize(location, query)
    super(uri: "google-jobs-search.p.rapidapi.com", query: "#{query} in #{location}")
  end

  def config
    { keys:
        {
          root: 'data',
          job_url: 'job_apply_link',
          job_title: 'job_title',
          company_name: 'employer_name',
          company_url: 'employer_website',
          posted_date: 'job_posted_at_datetime_utc',
          query: 'query',
        },
      
        request_url: "#{URL}/search",
        action: :get,
    }
  end
end
