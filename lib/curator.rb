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

end
