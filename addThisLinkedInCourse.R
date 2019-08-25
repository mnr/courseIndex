# scrape the LinkedIn Learning website for links to each video file

install.packages("xml2")
library(xml2)


# Setup -------------------------------------------------------------------

# I expect URLToCourse to be something akin to https://www.linkedin.com/learning/r-programming-in-data-science-dates-and-times/calculating-times-and-dates-with-r
URLToCourse <- "https://www.linkedin.com/learning/r-programming-in-data-science-dates-and-times/calculating-times-and-dates-with-r"


# run this ----------------------------------------------------------------

load("infoAboutLILCourses.rds")

thisPage <- read_html(URLToCourse)
findthisxpath <- "//ul['class=course-toc__list']//div['class=course-toc__item']//a['data-control-name=course_video_route']"
findthisxpath <- "//a['data-control-name=course_video_route']"
findthisxpath <- '//div[@class=/"course-toc__item/"]'
alldivs <- xml_find_all(thisPage, findthisxpath)
# xml_attr(alldivs[[128]], "href") = "https://www.linkedin.com/learning/r-programming-in-data-science-dates-and-times/the-fmdates-package?autoplay=true&trk=course_tocItem"

for( aVideo in alldivs ) {
  print(xml_attrs(aVideo))
  #print(xml_structure(aVideo))
  # print(xml_attr(aVideo, "a.toc__item__link"))
 # justTheURL <- xml_attr(aVideo, "href")
 # if (grepl("/learning/", justTheURL)) {
  #  urlSplit <- strsplit(x = url_parse(justTheURL)$path, "/")
    # print(urlSplit[[1]][4])
   # }
}

save(infoAboutLILCourses, file = "infoAboutLILCourses.rds")

