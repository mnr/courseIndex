# I expect this...

# idx_affiliate <- ""
# idx_video <- ""
# idx_task <- ""
# idx_topics <- ""
# idx_build(idx_affiliate, idx_video, idx_task, idx_topics)

idx_build <- function(idx_affiliate, idx_video, idx_task, idx_topics) {
  # adds an entry to a key:value table
  # key is the phrase to link to
  # value is the url
  
  if(length(idx_affiliate != 0)) 
    {useThisHREF <- idx_affiliate}
  else {
    courseURL <- infoAboutLILCourses[infoAboutLILCourses$video == idx_video,]
    useThisHREF <- paste0("(https://www.linkedin.com/learning/", courseURL, "/", videoURL, ")")
  }
    
    
  linkTopicToURL <- data.frame(theText = character(), theHREF = character(), stringsAsFactors = FALSE)
  
  for (showThis in idx_topics) {
    
    tmpDF <- data.frame(theText = showThis, theHREF = useThisHREF, stringsAsFactors = FALSE)
    linkTopicToURL <- rbind(linkTopicToURL, tmpDF)
    
    
  }
  
  masterIndexdf <<- rbind(masterIndexdf, linkTopicToURL)
  
}

# rebuild masterIndexDF
load("masterIndexdf.rds")
masterIndexdf <- data.frame(theText = character(), theHREF = character(), stringsAsFactors = FALSE)
save(masterIndexdf, file = "masterIndexdf.rds")