---
layout: post
title:  Scraping the most listened podcast in France, GDIY
description: Data scraping project
author: "Mahamadi NIKIEMA"
thumbnail-img: profile.jpg
tags: [Python, Scraping, Podcast]
date:   2024-12-29 21:55:51 +0200
categories: scraping
---

The podcast Generation Do It Yourself is one of the most listen in France.
I listen this podcast every weekend and I decide to use my programming skill to scrap audio data from the web [site][gdiy]. This post will also guide you to download audio from your favorite podcasts.


## Prerequisites

Before we dive into the details, you need to install the prerequisites by running:
`pip install requests beautifulsoup4 tqdm`

## Understanding the Python Script
Let's delve into the Python script that automates the process of downloading podcast episodes. I will introduce you to a class named `AudioLoader` that is equipped with methods to perform various tasks such as loading, updating, downloading, and processing audio data.

### Class Initialization
The AudioLoader class initializes with a data_path parameter which is the path to save the downloaded audio files and keep track of loaded episodes. The loaded_episodes set stores the loaded episode names.

```python
class AudioLoader(object):
    def __init__(self, data_path):
        self.data_path = data_path
        self.loaded_episodes = self.load_loaded_episodes()
```
### Loading and Updating Episode Details

The `load_loaded_episodes` method checks for the existence of a loaded_episodes.json file and creates one if it doesn't exist, to store the details of loaded episodes.

The `update_loaded_episodes` method updates the loaded_episodes set and JSON file with new episode details.

```python    
def load_loaded_episodes(self):
        if not os.path.exists(os.path.join(self.data_path,'loaded_episodes.json')):
            with open(os.path.join(self.data_path,'loaded_episodes.json'), 'w') as f:
                json.dump([], f)
        with open(os.path.join(self.data_path,'loaded_episodes.json'), 'r') as f:
            return set(json.load(f))
        
def update_loaded_episodes(self, episode_id):
    self.loaded_episodes.add(episode_id)
    with open(os.path.join(self.data_path,'loaded_episodes.json'), 'w') as f:
        json.dump(list(self.loaded_episodes), f)
```
### Fetching and Processing Data
The `load_data` method fetches all episodes from the podcast's RSS feed using the requests and BeautifulSoup libraries.

The `process_data` method iterates over all episodes and filters out those with certain phrases in the title (like "[EXTRAIT]"). It also prevents downloading episodes that have already been loaded.

```python
def load_data(self, feed_url):
        page = requests.get(feed_url)
        soup = BeautifulSoup(page.content, "xml")
        return soup.find_all('item')
    
def process_data(self):
    all_name = set()
    audio_info = {}
    audio_to_skip = ["[EXTRAIT]","[EXTRACT]","[REDIFF]"]
    data = self.load_data("https://rss.art19.com/generation-do-it-yourself")
    for episode in data:
        link = episode.find("enclosure")["url"]
        title = episode.find("title").text
        episode_id = " ".join(title.split(" - ")[:-1]).replace("#", "")
        episode_id = re.sub(r'[%/!@#\*\$\?\+\^\\\\\\]', '', episode_id)
        
        skip = [skip_audio for skip_audio in audio_to_skip if skip_audio in title]
        if not skip:

            if episode_id not in self.loaded_episodes:
                try:
                    episode_id = self.simplify_name(episode_id)
                except:
                    print(title)

                if episode_id in all_name:
                    episode_id = episode_id+"-1"
                audio_info[episode_id] = title
                all_name.add(episode_id)
                self.download_episode(link, episode_id)
                self.update_loaded_episodes(episode_id)
    
    return audio_info
```

### Downloading Episodes
The `download_episode` method downloads an episode's audio file and saves it with a simplified name derived from the title.

```python
def download_episode(self, episode_url, audio_name):
    audio = requests.get(episode_url)
    with open(os.path.join(self.data_path, audio_name+".mp3"), "wb") as fp:
        fp.write(audio.content)
```

### Simplifying File Names
The `simplify_name` method simplifies episode names based on certain conditions to create a clean and concise file name for each downloaded audio file.

```python
def simplify_name(self, file_name:str):
    file_name = file_name.strip()
    if file_name.startswith("COVID"):
        new_filename = "-".join(file_name.split()[:2])
    elif file_name.lower().startswith("hors"):
        new_filename = file_name.split()
        new_filename = "-".join(new_filename[:2])
    elif file_name.startswith("Early"):
        new_filename = "-".join(file_name.split()[:3])
    else:
        new_filename = file_name.split()[0]
    return new_filename
```
## Conclusion
With this Python script, you can automatically load and download episodes of the Generation Do It Yourself podcast, saving you time and effort. You can customize the script to work with other podcasts by modifying the RSS feed URL and adjusting the naming conventions in the `simplify_name` method.

Feel free to extend this script with more features, such as adding metadata to the audio files.

[gdiy]: https://gdiy.fr

