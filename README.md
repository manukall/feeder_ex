FeederEx
========
[![Build Status](https://travis-ci.org/manukall/feeder_ex.svg?branch=master)](https://travis-ci.org/manukall/feeder_ex)

Simple wrapper for https://github.com/michaelnisi/feeder

## Usage

```
iex> HTTPoison.start
iex> {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get("http://www.rssboard.org/files/sample-rss-2.xml")
iex> {:ok, feed, _} = FeederEx.parse(body)
...
iex> feed.title
"Liftoff News"
iex> Enum.map feed.entries, fn(entry) -> entry.title end
["Star City", :undefined, "The Engine That Does More",
 "Astronauts' Dirty Laundry"]
```

## Results

### FeederEx.Feed

- author
- id
- image
- link
- language
- subtitle
- summary
- title
- updated
- url
- entries

### FeederEx.Entry

- author
- categories
- duration
- enclosure
- id
- image
- link
- subtitle
- summary
- title
- updated


### FeederEx.Enclosure

- url
- size
- type
