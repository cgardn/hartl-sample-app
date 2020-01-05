# Ruby on Rails sample application

This is the sample application for Michael Hartl's Ruby On Rails tutorial, from his "Learn Enough To Be Dangerous" series.

All the source code is licensed under MIT and Beerware.

## Getting Started

To get started with the app, clone the repo and then install the necessary gems:

```
$ bundle install --without-production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

For more information, see the
[*Ruby On Rails Tutorial* book](https://www.railstutorial.com/book)
