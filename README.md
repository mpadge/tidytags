
<!-- README.md is generated from README.Rmd. Please edit that file -->
tidytags <img src="man/figures/tidytags-logo.png" align="right" width="120" />
==============================================================================

Simple Collection and Powerful Analysis of Twitter Data

Overview
--------

The goal of **tidytags** is to sync together (a) the simplicity of collecting tweets over time with a [Twitter Archiving Google Sheet](https://tags.hawksey.info/) (TAGS), (b) the utility of the [rtweet package](https://rtweet.info/) for processing and preparing additional Twitter metadata, and (c) a collection of different analytic functions we have developed during our own social media research.

Installation
------------

Soon, you will be able to install the released version of **tidytags** from [CRAN](https://CRAN.R-project.org) with:

``` r
#install.packages("tidytags")
```

You can also install the development version of **tidytags** from GitHub with:

``` r
install.packages("devtools")
devtools::install_github("bretsw/tidytags")
```

Usage
-----

### read\_tags()

At its most basic level, **tidytags** allows you to work with a [Twitter Archiving Google Sheet](https://tags.hawksey.info/) (TAGS) in R. This is done with the [googlesheets package](https://cran.r-project.org/web/packages/googlesheets/vignettes/basic-usage.html). One requirement for using the **googlesheets** package is that your TAGS has been published to the web. To do this, with the TAGS page open in a browser, go to `File` &gt;&gt; `Publish to the web`. The `Link` field should be 'Entire document' and the `Embed` field should be 'Web page.' If everything looks right, then click the `Publish` button. Next, click the `Share` button in the top right corner of the Google Sheets window, select `Get shareable link`, and set the permissions to 'Anyone with the link can view.' Now you should be ready to go.

At this point you can view or read your TAGS archive into R using `read_tags()`.

### pull\_tweet\_data()

With a TAGS archive imported into R, **tidytags** allows you to gather quite a bit more information related to the collected tweets with the `pull_tweet_data()`. This function uses the [rtweet package](https://rtweet.info/) (via `rtweet::lookup_statuses()`) to query the Twitter API. Using **rtweet** requires a Twitter developer account; see the rtweet vignette [Obtaining and using access tokens](https://rtweet.info/articles/auth.html) as a guide to get started.

1.  the utility of the [rtweet package](https://rtweet.info/) for processing and preparing additional Twitter metadata, and (c) a collection of different analytic functions we have developed during our own social media research.

Learning more about tidytags
----------------------------

For a walkthrough of numerous additional **tidytags** functions, visit the [Using tidytags with a conference hashtag](https://bretsw.github.io/tidytags/articles/tidytags-with-conf-hashtags.html) vignette webpage.

Getting help
------------

**tidytags** is still a work in progress, so we fully expect that there are still some bugs to work out and functions to document better. If you find an issue, have a question, or think of something that you really wish **tidytags** would do for you, don't hesitate to [email Bret](mailto:bret@bretsw.com) or reach out on Twitter: \[@bretsw\](<https://twitter.com/bretsw>), \[@jrosenberg6432\](<https://twitter.com/jrosenberg6432>), and \[@spgreenhalgh\](<https://twitter.com/spgreenhalgh>).

You can also [file an issue on Github](https://github.com/bretsw/tidytags).

Future collaborations
---------------------

This is package is still in development, and we welcome new contributors. Just reach out through the same channels as "Getting help."

License
-------

The **tidytags** package is licensed under a *GNU General Public License v3.0*, or [GPL-3](https://choosealicense.com/licenses/lgpl-3.0/). For background on why we chose this license, read Hadley Wickham's take on [R package licensing](http://r-pkgs.had.co.nz/description.html#license).
