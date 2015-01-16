defmodule FeederExTest do
  use ExUnit.Case

  @sample_file "test/sample-rss-2.xml"

  test "parsing a file" do
    {:ok, feed, _} = FeederEx.parse_file(@sample_file)
    assert feed.title == "Liftoff News"
  end

  test "parsing a binary" do
    bin_feed = File.read! @sample_file
    {:ok, feed, _} = FeederEx.parse(bin_feed)
    assert feed.title == "Liftoff News"
  end
end
