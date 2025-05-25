{
  urls = [
    # Weekly NixOS news and some other stuff
    {
      title = "NixOS Weekly";
      tags = ["news" "twitter"];
      url = "https://weekly.nixos.org/feeds/all.rss.xml";
    }
    # https://hackaday.com/blog/feed/
    {
      title = "Hacker News";
      url = "https://hnrss.org/newest";
      tags = ["tech"];
    }
    {
      title = "Hacker News Daily";
      url = "https://www.daemonology.net/hn-daily/index.rss";
      tags = ["tech"];
    }
    # Reddit
    {
      title = "/r/neovim";
      url = "https://www.reddit.com/r/neovim/.rss";
      tags = ["neovim" "reddit"];
    }
    {
      title = "/r/unixporn";
      url = "https://www.reddit.com/r/unixporn/.rss";
      tags = ["unix" "ricing" "style" "reddit"];
    }
    {
      title = "/r/experienced_devs";
      url = "https://www.reddit.com/r/ExperiencedDevs/.rss";
      tags = ["tech" "reddit" "engineering"];
    }
    # Computerphile
    {
      title = "Computerphile";
      url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC9-y-6csu5WGm29I7JiwpnA";
      tags = ["tech" "youtube"];
    }
    # Security Blogs
    {
      title = "Krebson Security";
      url = "https://krebsonsecurity.com/feed/";
      tags = ["tech" "security"];
    }

    {
      title = "The Register";
      url = "https://www.theregister.com/security/headlines.atom";
      tags = ["tech" "security"];
    }

    {
      title = "Schneier on Security";
      url = "https://www.schneier.com/feed/";
      tags = ["tech" "security"];
    }

    {
      title = "Troy Hunt";
      url = "https://www.troyhunt.com/feed/";
      tags = ["tech" "security"];
    }

    {
      title = "Axio";
      url = "https://axio.ms/feed.xml";
      tags = ["tech" "hobby"];
    }

    {
      title = "Pragmatic Engineer";
      url = "https://feeds.feedburner.com/ThePragmaticEngineer";
      tags = ["tech" "hobby"];
    }

    # Programming.dev
    {
      title = "Command Line Programming Dev";
      url = "https://programming.dev/feeds/c/commandline.xml?sort=Active";
      tags = ["tech" "hobby"];
    }
  ];
}
