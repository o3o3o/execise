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
    MaxTime = 5*60
    def SongList.siTooLong(aSong)
        return aSong.duration > MaxTime
    end
end
#asong = Song.new("Bicylops", "Fleck", 260)

