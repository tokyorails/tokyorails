Welcome to TOKYO Rails
=========================

The TOKYO Rails Meetup Group is for web engineers who are using, or are
interested in learning more about the Ruby on Rails framework. You can
find out more or join at http://tokyorails.org

This goal of this github project is to make a simple website for the group
that can serve as a learning tool we can collaborate on, as well as a real
site we can use as a focal point for group activities.

What Can I Do?
--------------

Since this is a community project, any ideas/features that are useful to
others are welcome.

We're using http://trello.com to organize user stories. some
initial stories are added to get us going so please email
tokyorails@gmail.com if you want to get access.

The first milestone is to get to a point where we can have the
tokyorails.org domain resolve to our own site rather than meetup.com

Getting Started
---------------

It's recommended to use the amazing [rvm][1] so either install:

    http://beginrescueend.com/rvm/install/

or if you already have it installed,  make sure you are up to date

    $ rvm get latest

An .rvmrc file is checked in to the repo. To use this, install the
following ruby and create a gemset

    $ rvm install ruby-1.9.3-p0
    $ rvm gemset create 'rails31-ruby193'

Next fork the repo and clone your fork to your dev machine:

    $ git clone git@github.com:[your github name]/tokyorails.git

We're using capybara-webkit which depends on QT. To install QT, refer to
the article here (OSX/Linux):

    https://github.com/thoughtbot/capybara-webkit/wiki/Installing-QT

The project uses ImageMagick for image manipulation

To install on Debian based Linux distributions:

    $ sudo apt-get install imagemagick

To install on Mac:

   TODO

To install on Windows: 

    http://www.imagemagick.org/script/binary-releases.php#windows


The project uses bundler, so if you dont have this installed already:

    $ gem install bundler

Then simply bundle install and you should be good to go:

    $ cd tokyorails
    $ bundle install

If bundler fails because of problems regarding the 'pg' gem then you can 
either install the relevant libraries required on your system or use:

    $ bundle install --without production

The 'pg' gem is for Postgresql database support which is only needed on
production in Heroku, not our development environments

Testing
-------

To run the tests:

    $ rspec spec

Contributing
------------

All contributions are warmly welcomed as pull requests. The basic flow is:

1. Fork it.
2. Push your code (`git push origin tokyorails`)
3. Submit a [Pull Request][2]

[1]: http://beginrescueend.com/
[2]: https://github.com/tokyorails/tokyorails/pull/new/master
