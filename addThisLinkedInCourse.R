# scrape the LinkedIn Learning website for links to each video file

install.packages("xml2")
library(xml2)

install.packages("rvest")
library(rvest)

# Setup -------------------------------------------------------------------

# I expect URLToCourse to be something akin to https://www.linkedin.com/learning/r-programming-in-data-science-dates-and-times/calculating-times-and-dates-with-r
URLToCourses <- c(
  "https://www.linkedin.com/learning/code-clinic-r-2/welcome?u=2125562",
  "https://www.linkedin.com/learning/r-programming-in-data-science-setup-and-start/welcome?u=2125562",
  "https://www.linkedin.com/learning/r-programming-in-data-science-high-velocity-data/how-can-you-use-r-with-high-velocity-data?u=2125562",
  "https://www.linkedin.com/learning/r-programming-in-data-science-high-volume-data/wrangling-high-volume-data-with-r?u=2125562",
  "https://www.linkedin.com/learning/r-programming-in-data-science-high-variety-data/jumping-over-the-high-variety-hurdle?u=2125562",
  "https://www.linkedin.com/learning/r-for-data-science-lunchbreak-lessons/weighted-mean?u=2125562",
  "https://www.linkedin.com/learning/r-programming-in-data-science-dates-and-times/calculating-times-and-dates-with-r"
)

# run this ----------------------------------------------------------------

load("infoAboutLILCourses.rds")

for (URLToCourse in URLToCourses) {
  print(URLToCourse)
  thisPage <- read_html(URLToCourse)
  
  alldivs <- html_nodes(thisPage, '.toc__item__link')
  
  for (aVideo in alldivs) {
    # print(xml_attrs(aVideo))
    # print(xml_attr(aVideo, "href"))
    urlSplit <-
      strsplit(x = url_parse(xml_attr(aVideo, "href"))$path, "/")
    tmpDataFrame <- data.frame(
      course = urlSplit[[1]][3],
      video = urlSplit[[1]][4],
      stringsAsFactors = FALSE
    )
    infoAboutLILCourses <- rbind(infoAboutLILCourses, tmpDataFrame)
  }
}

infoAboutLILCourses <-  unique(infoAboutLILCourses)

save(infoAboutLILCourses, file = "infoAboutLILCourses.rds")

# example add this to files
affiliate <- "https://linkedin-learning.pxf.io/rwkly_dataSets"
video <- "r-built-in-data-sets"
topics <- "data()"


# stuff for later
course <- " "
video <- " "
infoAboutLILCourses <-
  data.frame(course = character(),
             video = character(),
             stringsAsFactors = FALSE)
