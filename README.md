# Jungle

A mini e-commerce application built with Rails 4.2 for purposes of teaching Rails by example.

## Sample Site
<https://evening-temple-13530.herokuapp.com/>

## Setup

1. Fork & Clone
2. Run `bundle install` to install dependencies
3. Create `config/database.yml` by copying `config/database.example.yml`
4. Create `config/secrets.yml` by copying `config/secrets.example.yml`
5. Run `bin/rake db:reset` to create, load and seed db
6. Create .env file based on .env.example
7. Sign up for a Stripe account
8. Put Stripe (test) keys into appropriate .env vars
9. Run `bin/rails s -b 0.0.0.0` to start the server

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* Stripe

## Contributions to Distribution Code
- Feature: Product Sold Out Badge
- Feature: Admin Routes
- Feature: Category Creation Routes (Admin Only)
- Feature: Admin Authentication
- User Signup & Authentication
- Bugfix: Checking out empty cart
- Feature: Product Ratings
- Feature: Model Testing
- Feature: Heroku Deployment
- Feature: Inventory Deductions & Testing
- Feature: Home Page Headless Browser Testing
- Feature: Headless Browser Testing Setup
- Feature: Product Details Link Headless Browser Testing
- Feature: Add-to-Cart Headless Browser Testing
- Feature: User Login Headless Browser Testing
