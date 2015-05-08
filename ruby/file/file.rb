feedzilla_articles =[]
File.open("feedzilla.json", "r") do |f|
    items = JSON.parse(f.read)
    feedzilla_articles= items['articles'].map { |a|
        {
            title: a['title'],
            link: a['url'],
            summary: a['summary']
        }
    }
end
