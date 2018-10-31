require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/curator'
require './lib/photograph'
require './lib/artist'

class CuratorTest < Minitest::Test
  def test_that_it_exists
    curator = Curator.new

    assert_instance_of Curator, curator
  end

  def test_that_it_has_an_empty_array_of_artist
    curator = Curator.new

    assert_equal [], curator.artists
  end

  def test_that_it_starts_with_an_empty_array_of_photographs
    curator = Curator.new

    assert_equal [], curator.photographs
  end

  def test_that_it_can_add_photographs
    curator = Curator.new
    photo_1 = Photograph.new({
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    })
    photo_2 = Photograph.new({
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    })
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    assert_equal 2, curator.photographs.count
  end

  def test_that_it_can_find_the_first_photograph_with_attribute
    curator = Curator.new
    photo_1 = Photograph.new({
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    })
    photo_2 = Photograph.new({
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    })
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    assert_instance_of Photograph, curator.photographs[0]
    assert_equal "1", curator.photographs.first.id
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", curator.photographs.first.name
  end

  def test_that_it_can_add_artists
    curator = Curator.new
    artist_1 = Artist.new({
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    })
    artist_2 = Artist.new({
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    })
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_instance_of Artist, curator.artists[0]
    assert_equal 2, curator.artists.count
    assert_equal "Henri Cartier-Bresson", curator.artists.first.name
  end

  def test_that_it_can_find_artist_by_id
    curator = Curator.new
    artist_1 = Artist.new({
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    })
    artist_2 = Artist.new({
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    })
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    selection = curator.find_artist_by_id(artist_2.id)

    assert_equal [artist_2], selection
  end

  def test_that_it_can_find_photograph_by_id
    curator = Curator.new
    photo_1 = Photograph.new({
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    })
    photo_2 = Photograph.new({
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    })
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    selection = curator.find_photograph_by_id(photo_1.id)

    assert_equal [photo_1], selection
  end
end
