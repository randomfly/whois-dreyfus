SimpleNavigation::Configuration.run do |navigation|  
    navigation.items do |primary|
        primary.item :records, 'Lookup a Whois', lookup_records_path
        primary.item :records, 'Check in bulk', check_records_path
        primary.item :records, 'Do a surveillance', surveil_records_path
    end
end