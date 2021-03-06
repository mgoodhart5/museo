require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/curator'
require './lib/photograph'
require './lib/artist'
require './lib/file_io'
require 'csv'
# require '../photographs.csv'

# why did i forget how to load csv files!?!?!?

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
    photo_1 = ({
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    })
    photo_2 = ({
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
    photo_1 = ({
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    })
    photo_2 = ({
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
    artist_1 = ({
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    })
    artist_2 = ({
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
    artist_1 = ({
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    })
    artist_2 = ({
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    })
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    selection = curator.find_artist_by_id(artist_2[:id])

    assert_equal "Ansel Adams", selection.attributes[:name]
  end

  def test_that_it_can_find_photograph_by_id

    curator = Curator.new
    photo_1 = ({
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    })
    photo_2 = ({
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    })
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    selection = curator.find_photograph_by_id(photo_1[:id])

    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", selection.attributes[:name]
  end

  def test_that_it_can_find_photos_by_artist

    curator = Curator.new
    photo_1 = ({
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    })
    photo_2 = ({
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    })
    photo_3 = ({
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    })
    photo_4 = ({
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    })
    artist_1 = ({
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    })
    artist_2 = ({
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    })
    artist_3 = ({
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    })
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    diane_arbus = curator.find_artist_by_id("3")
    selected_photos = curator.find_photographs_by_artist(diane_arbus)

    assert_equal 2, selected_photos.length
  end

  def test_that_it_can_return_all_artists_with_more_than_one_photo

    curator = Curator.new
    photo_1 = ({
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    })
    photo_2 = ({
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    })
    photo_3 = ({
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    })
    photo_4 = ({
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    })
    artist_1 = ({
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    })
    artist_2 = ({
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    })
    artist_3 = ({
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    })
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)

    assert_equal 1, curator.artists_with_multiple_photographs.length
    assert_equal "Diane Arbus", curator.artists_with_multiple_photographs.first.name
  end

  def test_that_it_can_find_photos_by_artists_countries

    curator = Curator.new
    photo_1 = ({
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    })
    photo_2 = ({
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    })
    photo_3 = ({
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    })
    photo_4 = ({
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    })
    artist_1 = ({
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    })
    artist_2 = ({
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    })
    artist_3 = ({
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    })
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    selected_photos_1 = curator.photographs_taken_by_artists_from("United States")

    assert_equal 3, selected_photos_1.length

    selected_photos_2 = curator.photographs_taken_by_artists_from("Argentina")

    assert_equal 0, selected_photos_2.length
  end

  def test_that_it_can_add_photos_from_a_csv_file
    skip
    curator = Curator.new


    assert_instance_of Photograph, curator.load_photographs('../data/photographs.csv')
  end
end
