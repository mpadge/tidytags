#' Filter a Twitter dataset to only include statuses of a particular type
#'
#' Starting with a dataframe of Twitter data imported to R with
#'   `read_tags()` and additional metadata retrieved by
#'   `pull_tweet_data()`, `filter_by_tweet_type()` processes the
#'   statuses by calling `process_tweets()` and then removes any statuses
#'   that are not of the requested type (e.g., replies, retweets, quote tweets,
#'   and mentions). `filter_by_tweet_type()` is a useful function in
#'   itself, but it is also used in `create_edgelist()`.
#' @param df A dataframe returned by `pull_tweet_data()`
#' @param type The specific kind of statuses that will be kept in the dataset
#'   after filtering the rest. Choices for `type`include "reply",
#'   "retweet", "quote", or "mention."
#' @return A dataframe of processed statuses and fewer rows that the input
#'   dataframe. Only the statuses of the specified type will remain.
#' @examples
#'
#' \dontrun{
#'
#' example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tmp_df <- pull_tweet_data(read_tags(example_url))
#'
#' only_replies <- filter_by_tweet_type(tmp_df, "reply")
#' only_retweets <- filter_by_tweet_type(tmp_df, "retweet")
#' only_quote_tweets <- filter_by_tweet_type(tmp_df, "quote")
#' only_mentions <- filter_by_tweet_type(tmp_df, "mention")
#' }
#' @importFrom rlang .data
#' @export
filter_by_tweet_type <-
  function(df, type) {

    processed_df <- process_tweets(df)

    ifelse(type %in% c("reply", "retweet", "quote"),
           filtered_df <-
             dplyr::filter(processed_df,
                           !!as.symbol(paste0("is_", type)) == TRUE),
           ifelse(type == "mention",
                  filtered_df <-
                    dplyr::filter(processed_df,
                                  .data$mentions_count > 0),
                  filtered_df <- processed_df
           )
    )

    filtered_df
  }


#' Create an edgelist where senders and receivers are defined by different types
#'   of Twitter interactions
#'
#' Starting with a dataframe of Twitter data imported to R with
#'   `read_tags()` and additional metadata retrieved by
#'   `pull_tweet_data()`, `create_edgelist()` processes the
#'   statuses by calling `process_tweets()` and then removes any statuses
#'   that are not of the requested type (e.g., replies, retweets, quote tweets,
#'   and mentions) by calling `filter_by_tweet_type()`. Finally,
#'   `create_edgelist()` pulls out senders and receivers of the specified
#'   type of statuses, and then adds a new column called `edge_type`.
#' @param df A dataframe returned by `pull_tweet_data()`
#' @param type The specific kind of statuses used to define the interactions
#'   around which the edgelist will be built. Choices include "reply",
#'   "retweet", "quote", or "mention." Defaults to "all."
#' @return A dataframe edgelist defined by interactions through the type of
#'   statuses specified. The dataframe has three columns: `sender`,
#'   `receiver`, and `edge_type`.
#' @examples
#'
#' \dontrun{
#'
#' example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tmp_df <- pull_tweet_data(read_tags(example_url))
#'
#' full_edgelist <- create_edgelist(tmp_df)
#' full_edgelist
#'
#' reply_edgelist <- create_edgelist(tmp_df, type = "reply")
#' retweet_edgelist <- create_edgelist(tmp_df, type = "retweet")
#' quote_edgelist <- create_edgelist(tmp_df, type = "quote")
#' mention_edgelist <- create_edgelist(tmp_df, type = "mention")
#' }
#' @importFrom rlang .data
#' @export
create_edgelist <-
  function(df, type = "all") {

    filtered_df <- filter_by_tweet_type(df, type)

    if(type == "reply") {col_screen_name <- "reply_to_screen_name"}
    if(type == "retweet") {col_screen_name <- "retweet_screen_name"}
    if(type == "quote") {col_screen_name <- "quoted_screen_name"}

    if(type == "mention") {
      col_screen_name <- "mentions_screen_name"
      filtered_df <-
        tidyr::unnest(filtered_df, !!as.symbol(col_screen_name)
        )
    }

    if(type %in% c("reply", "retweet", "quote", "mention")) {
      ifelse(nrow(filtered_df) > 0,
             el <-
               dplyr::select(filtered_df,
                             sender =
                               `$`(.data, screen_name),
                             receiver =
                               `$`(.data, !!as.symbol(col_screen_name))
               ),
             el <-
               tibble::tibble(sender = as.character(),
                              receiver = as.character()
               )
      )
      el <- dplyr::mutate(el, edge_type = type)
    }

    if(type == "all") {
      el <-
        tibble::tibble(sender = as.character(),
                       receiver = as.character(),
                       edge_type = as.character()
        )

      el <-
        dplyr::bind_rows(el,
                         create_edgelist(df, "reply"),
                         create_edgelist(df, "retweet"),
                         create_edgelist(df, "quote"),
                         create_edgelist(df, "mention")
        )
    }

    el
  }
