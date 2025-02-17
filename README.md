e-maxx-eng algorithms book
==========================

[![Build Status](https://travis-ci.org/algmyr/e-maxx-eng-book.svg?branch=master)](https://travis-ci.org/algmyr/e-maxx-eng-book)

Scripts to build the articles in the https://github.com/e-maxx-eng/e-maxx-eng project into book form. A preview can be found at: http://algmyr.se/upload/e-maxx.pdf

Prerequisites
-------------

* some LaTeX distribution
* pandoc
* perl
* bash
* grep, sed, ...
* wget
* make

Build process
-------------

Clone or update the submodule using

```bash
git submodule update --init --recursive --remote  # If first time
git submodule update --recursive --remote         # Otherwise
```

then

```bash
make -j8  # 8 specifies the number of threads/spanning factor.
```

Page layout
-----------

Two layouts are available for easy use: `oneside` and `twoside`. Switch between the two by editing the first line of `template.tex`.

### oneside
The default and is a good fit for on-screen reading.

* no extra blank pages
* symmetric margins
* headers have page numbering on the right side

### twoside
A good fit for books.

* blank pages are added to make parts and chapters start on even pages
* margins are non-symmetric for a nicer experience with an open book (slimmer inner margins)
* headers have page numbering on the outside
