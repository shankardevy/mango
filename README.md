# Mango

This project contains the source code of the Ecommerce site that is built in the book _Mastering Phoenix Framework_,
as part of the _Phoenix Inside Out_ series.

## Additional files
You need some static image files and CSV files to get the same output as described in the book. These files can be downloaded here:

https://shankardevy.com/phoenix-book/book_files.zip

## Branches and Commits

Code for each chapter are in their respective branches named after the chapter number.

Master branch contains code from all branches merged.

## Setup

Steps to follow to run the code in your local machine:

```
git clone https://github.com/shankardevy/mango.git
cd mango

# optionally checkout to the chapter{n} using `git checkout chapter{n}``

mix deps.get
cd assets && npm install && cd ..
mix ecto.setup
mix phx.server
```
Now visit http://localhost:4000 to see the site.


## Run Test

Test code requires a running instance of Phantomjs for the Acceptance tests. Run the following command on one of the terminal windows

```
phantomjs --wd
```

and in another terminal window, run the test

```
mix test
```

