defmodule FeederEx do
  defmodule Feed do
    defstruct author: nil, id: nil, image: nil, link: nil, language: nil,
      subtitle: nil, summary: nil, title: nil, updated: nil, entries: []
  end

  defmodule Entry do
    defstruct  author: nil, duration: nil, enclosure: nil, id: nil,
      image: nil, link: nil, subtitle: nil, summary: nil, title: nil,
      updated: nil
  end

  defmodule Enclosure do
    defstruct  url: nil, size: nil, type: nil
  end

  def parse_file(filename) do
    :feeder.file filename, opts
  end

  def parse(feed_bin) do
    :feeder.stream feed_bin, opts
  end

  def parse!(feed_bin) do
    case :feeder.stream feed_bin, opts do
      {:ok, feed, _} -> feed
      :error -> raise "feed could not be parsed"
    end
  end

  defp opts do
    [event_state:  {nil, []}, event_fun: &FeederEx.Parser.event/2]
  end

end
