module Tokyorails::GithubMethods

  def self.included(base)
    base.class_eval do
      include HTTParty
      base_uri 'https://api.github.com'
    end
  end

  # List all the github projects for this member
  #
  # @return [Array] An array of hashes where each hash represents one project.
  #   Check the link below for hash keys
  # @see http://developer.github.com/v3/repos/ API Documentation including
  #   project fields
  def github_projects
    return [] unless self.github_username
    @repositories ||= get_github_repositories
  end

  protected

  def get_github_repositories
    response = self.class.get("/users/#{github_username}/repos")
    response.ok? ? response : []
    rescue => e
      Airbrake.notify(e)
      []
  end

end
