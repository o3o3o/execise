contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
                ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]
                #["sally@email.COM(2)", "404 Found Dr.(2)", "3454"]]


contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}
#field = {:email => [] , :address => [], :phone => []}
field = [:email ,  :address , :phone ]

i=0
contacts.each do |name, hash|
    j = 0
    field.each do |field|
        hash[field] = contact_data[i][j]
        j += 1
    end
    i += 1
end

=begin
def parse_data(contacts, data)
    init_contacts(contacts)
    puts "After init contacts: #{contacts}\n\n"
    data.each do |d|
        contacts.each do |name,v|
            if name.downcase.gsub(/ .*/, "") ==  d[0].gsub(/@.*/, "") 
                puts "#{name} == #{d}"
                puts "Insert into #{d}....\n\n"

                v[:email].push(d[0])
                v[:address].push(d[1])
                v[:phone].push(d[2])
            end
        end
    end
end

def init_contacts(contacts)
    field = {:email => [] , :address => [], :phone => []}
    contacts.each do |c|
        c.last.merge!(field)
    end
end

parse_data(contacts, contact_data)
=end

puts "---------"
puts "After insert: #{contacts}"
