## The 2014 EA Survey

In May 2014, a team from .impact released a survey to better understand the EA community. Before this, we’ve mostly been using our first-hand, anecdotal impressions to describe the community. A few EA organizations have done surveys of their own supporters, but this  particular survey supplies a more systematic understanding of EAs.

[The full analysis was published on the EA forum](http://effective-altruism.com/ea/gb/the_2014_survey_of_effective_altruists_results/) on March 2015.


## Replicating the Analysis

The core code for analysis is in [imsurvey.R](https://github.com/impct/imsurvey/blob/master/imsurvey.R).  It reads in data from `imdata.csv` and `imdata-more-results.csv`, which were two downloads of data collected from running the EA survey.  It also reads data in from `ace-results.csv`, which was a specific survey run by Animal Charity Evaluators targeted at their audience, which included all of our questions along with some additional questions.  All of that data is combined, throughly cleaned, and then analyzed.

The tech of the analysis relies heavily on the R packages [magrittr](https://github.com/smbache/magrittr), [dplyr](https://github.com/hadley/dplyr), and [surveytools2](https://github.com/peterhurford/surveytools2).

To run the analysis, clone this repo, open up R within the repo folder, and then either `source("imsurvey.R")` or run individual parts of `imsurvey.R`.

Comparison with the LessWrong survey was done in [lesswrong.R](https://github.com/impct/imsurvey/blob/master/lesswrong.R) using the [2013 LessWrong survey](http://lesswrong.com/lw/jj0/2013_survey_results/) data set, `lwpublic2013.csv`, for analysis.  To run that analysis, `source("lesswrong.R")` within this repo.
