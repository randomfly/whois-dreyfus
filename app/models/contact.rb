class Contact
    
    include CouchPotato::Persistence
    
    attr_reader :id, :name, :organization, :address, :city, :state, :country
    attr_reader :email, :url, :zip, :created_on
    
    property :id
    property :name
    property :organization
    property :address
    property :city
    property :state
    property :country
    property :email
    property :url
    property :zip
    property :created_on
    
    def initialize (hash=nil)
        if !hash.nil?
            @id = hash.id
            @name = hash.name
            @organization = hash.organization
            @address = hash.address
            @city = hash.city
            @state = hash.state
            @country = hash.country
            @email = hash.email
            @url = hash.url
            @zip = hash.zip
            @created_on = hash.created_on
        end
    end
        
end