puts "How old are you?"
age=gets.chomp
#
ary=[10,20,30,40]

for i in ary do
    print "\nIn #{i} years you will be: \n#{i + age.to_i}"
end
