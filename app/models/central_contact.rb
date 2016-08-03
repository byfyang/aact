class CentralContact < StudyRelationship

  def self.create_all_from(opts)
    central_contacts = contacts(opts) + backup_contacts(opts)
    CentralContact.import(central_contacts)
  end

  def self.contacts(opts)
    opts[:xml].xpath('//overall_contact').collect{|xml|
      CentralContact.new.create_from({xml: xml, :nct_id=>opts[:nct_id], contact_type: 'primary'})}
  end

  def self.backup_contacts(opts)
    opts[:xml].xpath('//overall_contact_backup').collect{|xml|
      CentralContact.new.create_from({xml: xml,:nct_id=>opts[:nct_id], contact_type: 'backup'})}
  end

  def attribs
    {
      :contact_type => get_opt('contact_type'),
      :name => get('last_name'),
      :phone => get('phone') + get('phone_ext'),
      :email => get('email'),
    }
  end
end
