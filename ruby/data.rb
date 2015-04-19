class Contact
    contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
                    ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

    contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

    def parse_data(contacts, data)
        data.each do |d|
            insert_contacts(contacts, d)
        end
    end

    def insert_contacts(contacts, data)
        contacts.each do |k,v|
            #puts "compare #{k} with #{data[0]}"
            if k.downcase.gsub(/ .*/, "") ==  data[0].gsub(/@.*/, "") 
                puts "Insert into #{data}...."
                contacts[k]=v
            end
        end
    end

    parse_data(contacts, contact_data)

    puts "After insert: #{contacts}"
end
