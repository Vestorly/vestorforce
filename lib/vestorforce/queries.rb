module Vestorforce
  module Queries
    def self.campaign_by_name(campaign_name)
      "SELECT Id FROM Campaign where name='#{campaign_name}'"
    end

    def self.child_campaigns(parent_id)
      "SELECT Id, Name, NumberOfContacts, NumberOfLeads From Campaign where " \
        "ParentId='#{parent_id}'"
    end

    def self.campaign_members(campaign_id)
      "SELECT Id, Email, FirstName, LastName FROM CampaignMember " \
        "where CampaignId='#{campaign_id}'"
    end
  end
end
