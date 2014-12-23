# Nameservers are the list of dns servers related to the searched domain

class Nameservers
    include CouchPotato::Persistence
    
    attr_reader :servers
    property :servers, :cast_as => 'DataItem'
    
    def initialize(response)
        array = []
        response.each do |n|
            array << DataItem.new(n.name, n.ipv4, n.ipv6)
        end
        @servers = array
    end
    
end

class DataItem
    include CouchPotato::Persistence

    attr_reader :name, :ipv4, :ipv6
    property :name
    property :ipv4
    property :ipv6
    
    def initialize(name=nil, ipv4=nil, ipv6=nil)
        @name = name
        @ipv4 = ipv4
        @ipv6 = ipv6
    end
end