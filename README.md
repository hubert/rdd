# RDD

Command line scorer of repos using [Github Archive](https://www.githubarchive.org/)

## Installation

Clone this repo and build the gem:

    $ gem build rdd.gemspec

Or install it yourself as:

    $ gem install rdd-0.0.1.gem

If you're using rbenv, you need to create the shim for the rdd executable.

    $ rbenv rehash

## Usage

For usage help, run:
    
    $ rdd

Typical command would be something like:

    $ rdd score --top=500 --after=2015-10-13

Tested primarily on ruby 2.2.3 and jruby 9.0.0.0. Depending on your system and thread pool settings, jruby may really peg your CPU.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
