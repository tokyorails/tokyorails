Welcome to TOKYO Rails
=========================

The TOKYO Rails Meetup Group is for web engineers who are using, or are interested in learning more about the Ruby on Rails framework. You can find out more or join at http://tokyorails.org

This goal of this github project is to make a simple website for the group that can serve as a learning tool we can collaborate on, as well as a real site we can use as a focal point for group activities.

Getting Started
---------------

It's recommended to use the amazing [rvm][1] and as such an .rvmrc file
is checked in to the repo. To use this, install the following ruby and
create a gemset

  $ rvm install ruby-1.9.3-head
  $ rvm gemset create 'rails31-ruby193'

Next fork the repo and clone your fork to your dev machine:

  $ git clone git@github.com:[your github name]/tokyorails.git

Then simply bundle install and you should be good to go:

  $ cd tokyorails
  $ bundle install

Testing
-------

To run the tests:

  $ rspec spec

Contributing
------------

All contributions are warmly welcomed as pull requests. The basicflow is

1. Fork it.
2. Push your code (`git push origin tokyorails`)
3. Submit a [Pull Request][2]

[1]: http://beginrescueend.com/
[2]: https://github.com/tokyorails/tokyorails/pull/new/master
