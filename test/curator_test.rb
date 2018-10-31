require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/curator'
require './lib/photograph'

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

    assert_equal "1", curator.photographs.first.id
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", curator.photographs.first.name
  end
end
