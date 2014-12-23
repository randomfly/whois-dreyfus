class Registrar
    
    include CouchPotato::Persistence
    
    attr_reader :id, :name, :url
    
    property :id
    property :name
    property :url
    
    def initialize (id=nil, name=nil, url=nil)
        @id = id
        @name = name
        @url = url
    end
    
end