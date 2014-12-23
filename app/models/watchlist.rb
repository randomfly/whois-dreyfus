require 'rubygems'
require 'couch_potato'

# list of the properties to be watched on the domain it is attached to

class Watchlist
    include CouchPotato::Persistence
    attr_reader :preferences
    
    property :preferences
    def initialize(preferences)
        @preferences = preferences
    end
    
    def update(choices)
        @preferences = choices
    end
end