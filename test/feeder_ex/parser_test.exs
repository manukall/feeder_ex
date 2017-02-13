defmodule FeederEx.ParserExTest do
  use ExUnit.Case

  test "feed event" do
    event_data = {
      :feed,
      "the author",
      "the id",
      "the image",
      "the language",
      "the link",
      "the subtitle",
      "the summary",
      "the title",
      "the updated date",
      "the feed url"
    }
    {feed, :entries} = FeederEx.Parser.event({:feed, event_data}, {nil, :entries})

    assert feed.author   == "the author"
    assert feed.id       == "the id"
    assert feed.image    == "the image"
    assert feed.language == "the language"
    assert feed.link     == "the link"
    assert feed.subtitle == "the subtitle"
    assert feed.summary  == "the summary"
    assert feed.title    == "the title"
    assert feed.updated  == "the updated date"
    assert feed.url      == "the feed url"
  end

  test "entry event without enclosure" do
    event_data = {
      :entry,
      "the author",
      ["News"],
      "the duration",
      :undefined,
      "the id",
      "the image",
      "the link",
      "the subtitle",
      "the summary",
      "the title",
      "the updated date"
    }
    entries = [:entry_1, :entry_2]
    {:feed, [entry, :entry_1, :entry_2]} =
      FeederEx.Parser.event({:entry, event_data}, {:feed, entries})

    assert entry.author    == "the author"
    assert entry.duration  == "the duration"
    assert entry.enclosure == nil
    assert entry.id        == "the id"
    assert entry.image     == "the image"
    assert entry.link      == "the link"
    assert entry.subtitle  == "the subtitle"
    assert entry.summary   == "the summary"
    assert entry.title     == "the title"
    assert entry.updated   == "the updated date"
  end

  test "entry event with enclosure" do
    event_data = {
      :entry,
      "the author",
      ["News"],
      "the duration",
      {:enclosure, "http://www.example.com/enclosure.mp3", "123456", "audio/mpeg"},
      "the id",
      "the image",
      "the link",
      "the subtitle",
      "the summary",
      "the title",
      "the updated date"
    }
    {:feed, [entry]} =
      FeederEx.Parser.event({:entry, event_data}, {:feed, []})

    assert entry.enclosure == %FeederEx.Enclosure{url: "http://www.example.com/enclosure.mp3",
                                                 size: "123456", type: "audio/mpeg"}
  end

end
