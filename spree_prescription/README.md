SpreePrescription
=========================

This extension allows users to attach their prescription to a product when they're added to the cart. Also allows for uploading prescriptions (as images or PDFs) and displaying them on the Shipment view in Spree admin.

## Installation

1. Add this extension to your Gemfile with this line:
  ```ruby
  gem 'spree_prescription', github: 'tzukuri/spree_prescription', branch: 'master'
  ```

  The `branch` option is important: it must match the version of Spree you're using.
  For example, use `3-1-stable` if you're using Spree `3-1-stable` or any `3.1.x` version.

2. Install the gem using Bundler:
  ```ruby
  bundle install
  ```

3. Copy & run migrations
  ```ruby
  bundle exec rails g spree_prescription:install
  ```

4. Restart your server

  If your server was running, restart it so that it can find the assets properly.

## Caveats

* For the time being, prescription fields only make sense when [dynamic variants](https://github.com/hefan/spree_dynamic_variants) are enabled (fields show when dropdowns are selected). Therefore, both `accepts_prescription` and `dynamic_variants` must be set on the product in admin.
* The dropdown being shown is dependent on having a `lens-type` option associated with the product. If there is no `lens-type` option the javascript will not know which field to bind to.
