words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']
result = {}

words.each do |w|
    t = w.split('').sort.join
#    if result.has_key?(t)
       result[t].push(w)
#    else
#       result[t]= [w]
#    end
end

result.each do |k,v|
    puts "#{k}--->#{v}"
end
    
