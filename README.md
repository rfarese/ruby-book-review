# Ruby Book Reviews
## Ruby Version
*2.2.3*

## Technical Specifications
* Ruby on Rails
* Ruby
* PostgreSQL
* JavaScript / jQuery
* React
* HTML
* SASS
* Foundation
* Twitter API
* AWS
* Heroku
* Testing Tools
..* Rspec
..* Capybara
..* FactoryGirl
..* Jasmine
..* Poltergeist
..* Database Cleaner

## Description
Ruby Book Review is a basic book review site where a user can research books
about programming in the Ruby language and other associated technologies. Users
can add new books to review, review existing books, vote on other users reviews,
give a numerical ranking to a book, and more.

The site was built using a Test Driven Development and Continuous Deployment process.
The primary workflow was as follows:
  * Create a feature user story in Pivotal Tracker
  * Create a new feature branch in Git
  * Create a new feature test (model tests, controller tests, etc. where applicable)
  * Follow TTD principals (red, green, refactor)
  * Once the new feature test was passing, run all other tests from a regression perspective
  * Merge changes into master branch
  * Run all tests again
  * Run git push origin master to push master to Github
  * Push all changes to production server running on Heroku

## Features
* CRUD operations for:
..* Users
..* Books
..* Reviews
..* Ranks
..* Votes
* User Authentication with Devise
* Devise Admin Role - ability to delete other user accounts, books, reviews, etc.
* Average Book Rank
* Search for a Book by Title
* Pagination of Reviews leveraging the Kaminari gem
* Email Alerts when a new review is created (Mandrill)
* Remote storage for book cover photo's on AWS
* Book list automatically updates every second through React Components built in JSX and internal API Books Controller  
* Voting functionality updates in real time through AJAX requests and the API Votes Controller
