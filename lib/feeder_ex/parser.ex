defmodule FeederEx.Parser do

  def event({:feed,
            {:feed, author, id, image, language, link, subtitle, summary, title, updated, url}},
            {_, entries}) do
    feed = %FeederEx.Feed{
      author: undefined_to_nil(author),
      id: undefined_to_nil(id),
      image: undefined_to_nil(image),
      language: undefined_to_nil(language),
      link: undefined_to_nil(link),
      subtitle: undefined_to_nil(subtitle),
      summary: undefined_to_nil(summary),
      title: undefined_to_nil(title),
      updated: undefined_to_nil(updated),
      url: undefined_to_nil(url)
    }
    {feed, entries}
  end

  def event({:entry,
            {:entry, author, categories, duration, enclosure, id, image, link, subtitle, summary, title, updated}},
            {feed, entries}) do
    entry = %FeederEx.Entry{
      author: undefined_to_nil(author),
      categories: undefined_to_list(categories),
      duration: undefined_to_nil(duration),
      enclosure: parse_enclosure(enclosure),
      id: undefined_to_nil(id),
      image: undefined_to_nil(image),
      link: undefined_to_nil(link),
      subtitle: undefined_to_nil(subtitle),
      summary: undefined_to_nil(summary),
      title: undefined_to_nil(title),
      updated: undefined_to_nil(updated)
    }
    {feed, [entry | entries]}
  end

  def event(:endFeed, {nil, entries}), do: %FeederEx.Feed{entries: entries}
  def event(:endFeed, {feed, entries}) do
    %{feed | entries: Enum.reverse(entries)}
  end

  defp undefined_to_list(:undefined), do: []
  defp undefined_to_list(value), do: value

  defp undefined_to_nil(:undefined), do: nil
  defp undefined_to_nil(value), do: value

  defp parse_enclosure(:undefined), do: nil
  defp parse_enclosure({:enclosure, url, size, type}) do
    %FeederEx.Enclosure{
      url: undefined_to_nil(url),
      size: undefined_to_nil(size),
      type: undefined_to_nil(type)
    }
  end

end
