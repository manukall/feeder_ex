defmodule FeederExTest do
  use ExUnit.Case

  @sample_file "test/sample-rss-2.xml"

  test "parsing a file" do
    {:ok, feed, _} = FeederEx.parse_file(@sample_file)
    assert feed.author == nil
    assert feed.id == nil
    assert feed.image == nil
    assert feed.link == "http://liftoff.msfc.nasa.gov/"
    assert feed.language == "en-us"
    assert feed.subtitle == nil
    assert feed.summary == "Liftoff to Space Exploration."
    assert feed.title == "Liftoff News"
    assert feed.updated == "Tue, 10 Jun 2003 04:00:00 GMT"
    assert feed.url == "http://liftoff.msfc.nasa.gov/feed/"
    assert length(feed.entries) == 4

    [entry | _] = feed.entries
    assert entry.author == nil
    assert entry.duration == nil
    assert entry.enclosure == nil
    assert entry.categories == ["Current Events", "News"]
    assert entry.id == "http://liftoff.msfc.nasa.gov/2003/06/03.html#item573"
    assert entry.image == nil
    assert entry.link == "http://liftoff.msfc.nasa.gov/news/2003/news-starcity.asp"
    assert entry.subtitle == nil
    assert entry.summary == "How do Americans get ready to work with Russians aboard the International Space Station? They take a crash course in culture, language and protocol at Russia's <a href=\"http://howe.iki.rssi.ru/GCTC/gctc_e.htm\">Star City</a>."
    assert entry.title == "Star City"
    assert entry.updated == "Tue, 03 Jun 2003 09:39:21 GMT"

  end

  test "parsing a binary" do
    bin_feed = File.read! @sample_file
    {:ok, feed, _} = FeederEx.parse(bin_feed)
    assert feed.title == "Liftoff News"
  end

  test "parse! returns just the parsed results on success" do
    parsed_feed = FeederEx.parse!(File.read!(@sample_file))
    assert parsed_feed.title == "Liftoff News"
  end

  test "parse! raises an error on failure" do
    assert_raise MatchError, fn ->
      FeederEx.parse!("<xml>")
    end
  end
end
