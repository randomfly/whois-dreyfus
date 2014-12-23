require 'rubygems'
require 'couch_potato'

# official plain-text whois class using the unix whois command line
# will NOT use the ruby whois gem by any means !!! check the record.rb file for that

# keep in mind that this class should never be serialized
# it only a stample for quick whois check-ups

class Whois

    URL_DATABASE = 'http://127.0.0.1:5984/dev_whois'
    ID_DOC_TLDS = "tlds"

    CouchPotato::Config.database_name = URL_DATABASE

    # returns the Whois::Record object for a plain text response display
    def lookup(domain)
        # should speciy here how other parameters (initial, ending) are gathered from BD
        format = searchformat(domain)
        return crop(domain, format.initial, format.ending)
    end

    def searchformat(domain)
        tldList = CouchPotato.database.load_document ID_DOC_TLDS
        if tldList!= nil
            tldList.tlds.each do |tld|
                # if there is an occurence of the current tld inside the domain
                # note : tld is not a string but an object containing the tld
                if domain =~ /#{tld.name}/ # or something like that
                    return tld
                end
            end
            # failed to find a corresponding tld and will use the default behavior
            return nil
        end
    end

    def crop(domain)
        a = %x{whois -H #{domain}}
            if (initial == nil)
		# default case when no options are specified and no regex is required or implemented for it
		return a
	    else
                start = false
		found = false
		# in ruby regex statements cannot be multi-lined
		# this is why we must split each line from the response into an array before applying the regex
		*base = a.split(/\n/)
		array = Array.new
		base.each do |line|
                    # checks for an occuration of the initial specified and if so starts building the new array
		    if ((line =~ /^(#{initial})/ || start) && !found)
			if !start
			    start = true
			end
                        if (ending != nil && (line =~ /^(#{ending})/))
			    found = true
			end
                        array.push(line)
		    end
		    if (ending != nil && line =~ /^(#{ending})/ && found)
			array.push(line)
		    end
		end
	    return array.join("\n")
	end
    end
    
    
    

end