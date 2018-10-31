class Curator
  attr_reader :artists, :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      id == artist.id
    end
  end

  def find_photograph_by_id(id)
    @photographs.find do |photograph|
      id == photograph.id
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.select do |photo|
      photo.artist_id == artist.attributes[:id]
    end
  end

  def artists_with_multiple_photographs
    @artists.find_all do |artist|
      person = find_photographs_by_artist(artist)
      if person.count > 1
        person
      end
    end
  end

  def photographs_taken_by_artists_from(country)
    artist_identification = []
      @artists.find_all do |artist|
        if artist.country == country
          artist_identification << artist.id
        end
      end
    artist_photos = []
    artist_identification.each do |id|
      @photographs.map do |photo|
        if photo.artist_id == id
          artist_photos << photo
        end
      end
    end
    artist_photos
  end

end
