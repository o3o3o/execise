class Song
    attr_reader :name, :artist, :duration
    attr_writer :duration
    @@plays = 0

    def initialize(name, artist, duration)
        @name = name
        @artist = artist
        @duration = duration
        @play = 0
    end
    def play
        @play += 1
        @@plays += 1
        p "This Song: #@play plays. Total #@@plays plays."
    end
end

class SongList
    def initialize
        @songs= Array.new
    end
    def append(aSong)
        @songs.push(aSong)
        self
    end
    def deleteFirst(aSong)
        @songs.shift
    end
    def deleteLast
        @songs.pop
    end

    def [](key)
        return @songs[key] if key.kind_of?(Integer)
        return @songs.find { |aSong| aSong.name == key}
    end
end

asong = Song.new("Bicylops", "Fleck", 260)

list = SongList.new
list.
    append(Song.new('title1', 'artist1', 1)).
    append(Song.new('title2', 'artist2', 2)).
    append(Song.new('title3', 'artist3', 3)).
    append(Song.new('title4', 'artist4', 4))
