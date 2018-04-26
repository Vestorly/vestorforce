module Vestorforce
  module Queries
    def self.campaign_by_name(campaign_name)
      "SELECT Id, Name, NumberOfContacts, NumberOfLeads FROM Campaign where " \
        "name='#{campaign_name}'"
    end

    def self.child_campaigns(parent_id)
      "SELECT Id, Name, NumberOfContacts, NumberOfLeads From Campaign where " \
        "ParentId='#{parent_id}'"
    end

    def self.campaign_members(campaign_id)
      "SELECT " \
        "Id, ContactId, LeadId, Contact.Email, Lead.Email, Contact.FirstName, Lead.FirstName, Contact.LastName, Lead.LastName " \
        "FROM CampaignMember " \
        "where CampaignId='#{campaign_id}'"
    end
  end
end
