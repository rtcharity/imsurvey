### Libraries
if (!require(reshape2)) install.packages('reshape2'); require(reshape2)
if (!require(devtools)) install.packages('devtools'); require(devtools)
if (!require(surveytools)) install_github('peterhurford/surveytools'); require(surveytools)

### Read Data
setwd('~/dev/imsurvey')
lw <- read.csv('lwpublic2013.csv')  # Added an ID column
lw <- melt(lw, id='ID')
