# frozen_string_literal: true

class Person
  attr_accessor :first_name, :last_name, :linkedin_url, :email, :photo_url

  def full_name
    "#{first_name} #{last_name}"
  end
end
