defmodule FeederEx.Parser do

  def event({:feed,
             {:feed, author, id, image, language, link, subtitle, summary, title, updated}},
            {_, entries}) do
    feed = %FeederEx.Feed{
                 author: author,
                 id: id,
                 image: image,
                 language: language,
                 link: link,
                 subtitle: subtitle,
                 summary: summary,
                 title: title,
                 updated: updated
             }
    {feed, entries}
  end

  def event({:entry,
             {:entry, author, duration, enclosure, id, image, link, subtitle, summary, title, updated}},
            {feed, entries}) do
    entry = %FeederEx.Entry{
                 author: author,
                 duration: duration,
                 enclosure: enclosure,
                 id: id,
                 image: image,
                 link: link,
                 subtitle: subtitle,
                 summary: summary,
                 title: title,
                 updated: updated
             }
    {feed, [entry | entries]}
  end

  def event(:endFeed, {feed, entries}) do
    %{feed | entries: Enum.reverse(entries)}
  end

end
