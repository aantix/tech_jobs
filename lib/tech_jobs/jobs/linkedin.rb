# frozen_string_literal: true

class Linkedin < Rapidapi
  def initialize(location, query)
    super(uri: "linkedin-jobs-search.p.rapidapi.com", query: query, location: location)
  end

  def config
    {
      keys:
        {
          root: nil,
          job_url: "linkedin_job_url_cleaned",
          job_title: "job_title",
          company_name: "company_name",
          company_url: "company_url",
          posted_date: "posted_date",
          query: "search_terms"
        },
      action: :post
    }
  end
end
