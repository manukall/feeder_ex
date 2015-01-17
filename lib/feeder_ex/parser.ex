defmodule FeederEx.Parser do

  def event({:feed,
             {:feed, author, id, image, language, link, subtitle, summary, title, updated}},
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
                 updated: undefined_to_nil(updated)
             }
    {feed, entries}
  end

  def event({:entry,
             {:entry, author, duration, enclosure, id, image, link, subtitle, summary, title, updated}},
            {feed, entries}) do
    entry = %FeederEx.Entry{
                 author: undefined_to_nil(author),
                 duration: undefined_to_nil(duration),
                 enclosure: undefined_to_nil(enclosure),
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

  def event(:endFeed, {feed, entries}) do
    %{feed | entries: Enum.reverse(entries)}
  end

  defp undefined_to_nil(value) do
    case value do
      :undefined -> nil
      anything -> anything
    end
  end

end
