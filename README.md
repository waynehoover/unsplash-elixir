# Unsplash

Unsplash API in Elixir.


## To Use

`Unsplash.photos`

or

`Unsplash.categories`

more examples coming soon.

## Todo

* Oauth for authenticating users
* Deal with errors
* Documentation

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add unsplash to your list of dependencies in `mix.exs`:

        def deps do
          [{:unsplash, "~> 0.0.1"}]
        end

  2. Ensure unsplash is started before your application:

        def application do
          [applications: [:unsplash]]
        end
