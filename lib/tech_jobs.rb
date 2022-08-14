# frozen_string_literal: true

require_relative "tech_jobs/version"
require_relative "tech_jobs/clients/rapidapi"
require_relative "tech_jobs/enrichment/apollo"
require_relative "tech_jobs/jobs/indeed"
require_relative "tech_jobs/jobs/linkedin"
require_relative "tech_jobs/jobs/google"
require_relative "tech_jobs/models/job"
require_relative "tech_jobs/models/person"

require "faraday"
require "faraday/net_http"
Faraday.default_adapter = :net_http

module TechJobs
  class Error < StandardError; end
  # Your code goes here...
end
