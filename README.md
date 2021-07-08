# README

Students need food in order to code effectively!

Unfortunately, until now, Flatiron School hasn't had any method to log data on which lunches work best for Flatiron students.

Think about how many lunches were consumed without providing us with delicious data! Lost forever! That changes today.

Pulling from the Yelp Fusion API, our goal will be to build an app that allows students to provide feedback on their lunch

## What we have

Fortunately, we have Flatiron's standard auth and styling available to us, and a User model. Unfortunately, we have to build everything else!

## To start

Get a YELP API key if you're working on this from home. Make a file titled ".env" in your root directory, and add your API key in the format:
`YELP_KEY=YOUR_KEY_HERE`

This will allow you to store your API key for your app without pushing it up to GitHub accidentally and allowing you to get pwned. To access it in our app, we can now simply call `ENV['YELP_KEY']`. Test it out in `rails console` if you don't believe me!

Remember to bundle install!

## What we need

### Building the Models

First, we need a restaurants model (as well as a relevant controller) with the following columns:
* name
* url
* lat (float)
* long (float)
* image_url
* address
* kind_of_food

Second, we'll need a reviews model (as well as a relevant controller) that belongs to both user and restaurant with the following columns:
* content
* rating (int)
* any foreign keys

### Hitting the API

Next, we need to build a script to pull the nearest 1000 meters to 89 Prospect Street, Brooklyn, NY from Yelp.

> Note: Where you put your API calls is up to the programmer. As this is a simple app and we're only pulling restaurants on initialization, using the seed file for your API calls is reasonable. When you're building your own app, think about where you might want to add it.

The following link would be helpful to get started. We're looking to pull from "Business Search": https://www.yelp.com/developers/documentation/v3/get_started

Our API call should work in three steps:
- Make the initial query to the API
- Receive a list of 50 businesses (the maximum Yelp will serve)
- Take each business and add it to our database (for this, it may be helpful to create a method in Restaurant to create a restaurant by the data given in an item in the array of businesses provided by Yelp).

The following code will convert any business in the Yelp business array set to a variable "business" into a Restaurant in our database:
```.ruby
self.create(
    name: business["name"],
    url: business["url"],
    lat: business["coordinates"]["latitude"],
    long: business["coordinates"]["longitude"],
    image_url: business["image_url"],
    address: business["location"]["display_address"].join(", "),
    kind_of_food: business["categories"].map{|item| item["title"]}.join(", ")
    )
```

Feel free to throw a byebug in right after your response to play with the data to make it work! When you're done, you should have 50 restaurants in a database.

### Building the Controllers and Views
- First, let's make sure that people only see reviews and restaurants if they're logged in. Let's add `before_action :authorized` to the tops of our RestaurantsController and ReviewsController

#### Index
We should start by building our Restaurants Index action and view, so that our app doesn't break when we log in. It should:
- Render out all the restaurant names with links to their show pages.
- Include an image.

> For the sake of formatting, wrap the section where you render all restaurants in a div with a class called `cards` and wrap each individual restaurant in a div with a class called `card`. Do not use `<ul>` and `<li>`.

> To neatly render as cards, these are rendered in a flexbox in CSS.

#### Show
- The restaurant's show page should include an h1 at the top that shows the Restaurant's name and links to its website.
- It should have, underneath, a jumbotron of the image provided by the yelp API.
- It should list the kinds of food.
- It should include the restaurant's address.
- It should have a form to submit a review.
- It should have the average rating for the restaurant.
- It should have a list of all reviews of the restaurant. Note: this replaces our review index and review show, which we don't need!
> For the sake of formatting, wrap the entire view in a div with a class called `show`. Additionally, wrap the section where you render all reviews in a div with a class called `reviews` and wrap each individual restaurant in a div with a class called `review`. Do not use `<ul>` and `<li>`.

### Adding Validations

- We should make sure people can only make a review with a rating between 1 and 10! Otherwise some bad actors could completely throw off our mean! Make sure both our front and backend only accept 1 through 10.

### Adding a Quick Review Feature

- What if our users want to quickly review something on the go? Let's make a form on the index page to review. How will we let the users choose which restaurant we're reviewing in the form, though?
