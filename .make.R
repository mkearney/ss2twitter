## make script for ss2twitter

source("R/post.R")
source("R/select.R")

media <- get_recent_ss("60 mins")

txt <- "Use of Twitter by politicians during the 2014 Indian general election by Ahmeda, Choa, Jaidka https://doi.org/10.1016/j.tele.2017.09.005"

tweet_with_media(txt, media)


media <- get_recent_ss("2 mins")
media

txt <- "How different social media influence political participation, by Halpern, Valenzuela, and Katz http://onlinelibrary.wiley.com/doi/10.1111/jcc4.12198/"

tweet_with_media(txt, media)

media <- get_recent_ss("2 mins")
media

txt <- "Americans are more exposed to difference than we think, by Eveland, Appiah, and Beck https://doi.org/10.1016/j.socnet.2017.08.002"
nchar(txt)

tweet_with_media(txt, media)

