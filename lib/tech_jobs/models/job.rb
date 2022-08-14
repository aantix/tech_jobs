# frozen_string_literal: true

class Job
  attr_accessor :url, :title, :description,
                :company_name, :company_url,
                :location, :posted, :prospects

  def initialize
    @prospects = []
  end

  def company_domain
    return if company_url.nil?
    
    URI.parse(company_url).host.sub(/\Awww\./, "")
  end
end
