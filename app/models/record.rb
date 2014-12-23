require 'rubygems'
require 'couch_potato'
require 'whois'

# the Record class is directly inspired from Simone Carletti's Whois::Record object (it's a ruby gem)
# it is for instance the model implementing such object into the couch database

class Record
  
    URL_DATABASE = 'http://127.0.0.1:5984/dev_whois'
    
    # include the CouchPotato gem
    # best way to use CouchDB with Rails to date
    include CouchPotato::Persistence
    CouchPotato::Config.database_name = URL_DATABASE
    
    # --- PROPERTIES --- #
    # the properties must be declared in order to be inserted in couchdb
    
    attr_accessor :domain_id, :domain_name, :status, :available, :registered
    attr_accessor :created_on, :updated_on, :expires_on, :last_update
    attr_accessor :registrant, :admin, :tech, :nameservers
    
    #property :_id
    property :domain_id
    property :domain_name
    property :status
    property :available
    property :registered
    property :created_on
    property :updated_on
    property :expires_on
    property :last_update
    property :registrant, :cast_as => 'Contact'
    property :admin, :cast_as => 'Contact'
    property :technical, :cast_as => 'Contact'
    property :registrar, :cast_as => 'Registrar'
    property :nameservers, :cast_as => 'Nameservers'
    property :watchlist, :cast_as =>'Watchlist'

    
    # Constructor for the class
    # Empty since the properties are loaded in the create method
    def initialize
    end
    
    
    # method using the ruby whois gem and returns a Whois::Record response object
    def whoisgem(domain)
        client = Whois::Client.new
        return client.lookup(domain) # returns the Whois::Record relevant to the domain
    end
    
    
    # inputs the parsed values from a whois response Whois::Record [gem] in the record object
    # please do not mistake the Whois::Record [gem] with our Record object
    def create(domain)
        
        r = whoisgem(domain) # returns the ruby whois response aka the Whois::Record object
        
        # preparing the contact objects
        registrant = Contact.new(r.registrant_contact)
        admin = Contact.new(r.admin_contact)
        tech = Contact.new(r.technical_contact)
        
        # preparing the nameservers
        dns = Nameservers.new(r.nameservers)
        
        # building the record that will be inserted in couch
        #@_id = domain
        @domain_id = r.domain_id
        @domain_name = r.domain
        @status = r.status
        @available = r.available?
        @registered = r.registered?
        @created_on = r.created_on
        @updated_on = r.updated_on
        @expires_on = r.expires_on
        @last_update = r.last_update
        @registrar = Registrar.new(r.registrar.id,
                                    r.registrar.name,
                                    r.registrar.organization)
        @registrant = registrant
        @admin = admin
        @technical = tech
        @nameservers = dns
        
        # not implemented yet
        @watchlist = nil
        
        CouchPotato.database.save_document! self
        
        # the boolean is an indicator wether the insertion succeeded or not
        # return boolean
    end
    
    def delete(id)
        # not implemented
    end
    
    def deleteHash(hash)
        # not implemented
    end
    
    # substitute to the find method from ActiveRecord in rails
    # reminder : the domain is the id for a record under survey
    def findRecord(domain)
        return CouchPotato.database.load_document domain
    end
    
 
    # response
    def lookup(domain)
        response = whoisgem(domain)
        return response
    end
        
    # returns a hash of domains and their availability & registrations
    # low priority
    def check(hash)
        # not implemented
    end
end