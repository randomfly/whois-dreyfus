class RecordsController < ApplicationController

    # should display all records saved
    # when authentication is implemented, will consider only showing the 10 last resquests made or so
    def index
        #code
    end
  
    # displays a specific record registered in the database
    def show
        #code
    end
    
    # displays a form to input one or many domain(s) 
    def new
        #code
    end
    
    
    # creates a new record from a selected domain and saves it in the database
    # format indicates if the app must render a html, json or xml response - default is html
    # this function should be the only way to insert records in the database
    # + used by human or API interaction
    def create
        domain = params[:domain]
        @record = Record.new.create(domain)
	respond_to do |format|
            format.html {render :new}    
                #case format
                #when "json"
                #    # renders a json response (useful for APIs)
                #when "xml"
                #    # renders an xml response (useful for APIs)
                #when "html"
                #    # renders a html response
                #else
                #    # same behavior as default
                #end
            
                # throws an error message
            
        end
    end
  
  
    # the lookup action requests a whois lookup and returns a plain-text response with no data persistence
    def lookup
        domain = params[:domain]
        @whois = Record.new.lookup(domain)
              
        respond_to do |format|
            if @whois != nil
                format.html
                format.json {render :json => @whois}
                #format.xml {render :xml => @whois}
                #redirect_to :controller => 'requests', :action => :show, :request => '#@whois'
            else
                format.html { render :new }
                format.json { render json: @request.errors, status: :unprocessable_entity }
            end
        end
    end
    

    def newlookup
        #code
    end  
  

    # the check action only retrieves availability and registration for various domains from differant tlds with no data persistence
    def check(hash)
        #code
    end


    def newcheck
        #code
    end

end
