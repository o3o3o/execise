def surround
    puts '--->{'
    yield
    puts '}<<<--'
end

surround { puts 'hello world' }
