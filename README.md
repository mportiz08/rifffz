# rifffz

my senior project, a browser based media player

## screenshots

### library

[![browsing library](http://mportiz08.github.com/rifffz/screenshots/thumbnails/rifffz_screenshot-02.png)](http://mportiz08.github.com/rifffz/screenshots/hires/rifffz_screenshot-02.png)

[![library stats](http://mportiz08.github.com/rifffz/screenshots/thumbnails/rifffz_screenshot-03.png)](http://mportiz08.github.com/rifffz/screenshots/hires/rifffz_screenshot-03.png)

### albums

[![listening to an album 1](http://mportiz08.github.com/rifffz/screenshots/thumbnails/rifffz_screenshot-01.png)](http://mportiz08.github.com/rifffz/screenshots/hires/rifffz_screenshot-01.png)

[![listening to an album 2](http://mportiz08.github.com/rifffz/screenshots/thumbnails/rifffz_screenshot-05.png)](http://mportiz08.github.com/rifffz/screenshots/hires/rifffz_screenshot-05.png)

[![listening to an album 3](http://mportiz08.github.com/rifffz/screenshots/thumbnails/rifffz_screenshot-07.png)](http://mportiz08.github.com/rifffz/screenshots/hires/rifffz_screenshot-07.png)

[![listening to an album 4](http://mportiz08.github.com/rifffz/screenshots/thumbnails/rifffz_screenshot-09.png)](http://mportiz08.github.com/rifffz/screenshots/hires/rifffz_screenshot-09.png)

[![listening to an album 5](http://mportiz08.github.com/rifffz/screenshots/thumbnails/rifffz_screenshot-15.png)](http://mportiz08.github.com/rifffz/screenshots/hires/rifffz_screenshot-15.png)

### playlists

[![creating a new playlist](http://mportiz08.github.com/rifffz/screenshots/thumbnails/rifffz_screenshot-12.png)](http://mportiz08.github.com/rifffz/screenshots/hires/rifffz_screenshot-12.png)

[![adding songs to a playlist](http://mportiz08.github.com/rifffz/screenshots/thumbnails/rifffz_screenshot-13.png)](http://mportiz08.github.com/rifffz/screenshots/hires/rifffz_screenshot-13.png)

[![listening to a playlist](http://mportiz08.github.com/rifffz/screenshots/thumbnails/rifffz_screenshot-14.png)](http://mportiz08.github.com/rifffz/screenshots/hires/rifffz_screenshot-14.png)

## installation

### dependencies

First, make sure you have [ruby](http://www.ruby-lang.org/en/) installed on your system.

The only non-ruby based dependencies are [sqlite](http://www.sqlite.org/) and [taglib](http://developer.kde.org/~wheeler/taglib.html). If you have [homebrew](http://mxcl.github.com/homebrew/) on your system, installing them is as easy as this:

    brew install sqlite
    brew install taglib

(You're on your own if not)

### rifffz

clone the repo:

    cd wherever
    git clone https://github.com/mportiz08/rifffz.git
    cd rifffz

if you don't have [bundler](http://gembundler.com/) installed:

    gem install bundler

install the dependencies:

    bundle install

setup the database:

    touch db/library.db
    rake db:migrate

You should be good to go now (I think). To run the application, simply start the server and check it out on your web browser:

    thin start

Another optional but suggested step is to symlink the path to where your mp3 files are stored, because that will give you some sweet autocompletion features that's helpful for importing albums.

    ln -s /path/to/music/folder library
