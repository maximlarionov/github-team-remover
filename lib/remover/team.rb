module Remover
  class Team
    attr_accessor :github_client, :github_team

    def initialize(github_client, github_team)
      @github_client, @github_team = github_client, github_team
    end

    def used?
      with_members? && with_repositories?
    end

    def name
      github_team.name
    end

    def members_url
      if with_members?
        hash = Hash(*github_client.team_members(github_team.id))
         hash[:html_url]
      else
        'no members'
      end
    end

    def repositories_url
      if with_repositories?
        hash = Hash(*github_client.team_repositories(github_team.id))
        hash[:html_url]
      else
        'no repositories'
      end
    end

    def members_amount
      if with_members?
        github_client.team_members(github_team.id).size
      else
        0
      end
    end

    def repositories_amount
      if with_repositories?
        github_client.team_repositories(github_team.id).size
      else
        0
      end
    end

    private

    def with_members?
      github_client.team_members(github_team.id).size > 0
    end

    def with_repositories?
      github_client.team_repositories(github_team.id).size > 0
    end
  end
end
