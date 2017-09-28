## post selected screen shots to Twitter
tweet_with_media <- function(text, media) {
  stopifnot(is.character(text), is.character(media))
  rtweet::post_tweet(text, media)
}
