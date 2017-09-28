## select which screen shots to post
SS_PAT <- function() {
  do.call("file.path", as.list(strsplit(system(
    "defaults read com.apple.screencapture location", intern = TRUE
  ), "(?<=[^\\/]{1})\\/", perl = TRUE)[[1]]))
}

ss_save_as <- function() {
  filename <- paste0(
    format(Sys.time(), "screenshot-%Y%m%d%H%M%S"),
    ".png"
  )
  file.path(SS_PAT(), filename)
}

read_ss_timestamp <- function(x) {
  as.POSIXct(
    gsub("[^[:digit:]]", "", x),
    format = "%Y%m%d%H%M%S",
    tz = Sys.timezone()
  )
}

list_ss_files <- function(full = FALSE) {
  list.files(SS_PAT(), pattern = "^screenshot-|^Screen Shot", full.names = full)
}


get_recent_ss <- function(x = "60 secs", from_newest = TRUE) {
  ## get files and organize by newest to oldest
  screenshots <- list_ss_files()
  timestamps <- read_ss_timestamp(screenshots)
  names(timestamps) <- list_ss_files(full = TRUE)
  timestamps <- sort(timestamps, decreasing = TRUE)

  ## if unit of time provided, then grab all within that range
  if (is.character(x)) {
    x <- strsplit(x, " ")[[1]]
    amount <- as.numeric(x[1])
    unit <- as.character(x[2])
    if (grepl("sec", unit)) {
      unit <- 1
    } else if (grepl("min", unit)) {
      unit <- 60
    } else if (grepl("hour", unit)) {
      unit <- 60 * 60
    } else if (grepl("day", unit)) {
      unit <- 60 * 60 * 24
    }
    ## determine time relative to newest screen shot
    if (from_newest) {
      newest <- timestamps[1]
    } else {
      ## or based on current time
      newest <- Sys.time()
    }
    kp <- as.numeric(timestamps) > (as.numeric(newest) - amount * unit)
  } else if (is.numeric(x) || is.integer(x)) {
    ## if a numeric/integer is provided,then return the most recent n
    ## screen shots
    kp <- seq_len(as.integer(x))
  }
  names(timestamps[kp])
}
