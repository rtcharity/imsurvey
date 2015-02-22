### Load Libraries
if (!require(magrittr)) install.packages('magrittr'); require(magrittr)
if (!require(dplyr)) install.packages('dplyr'); require(dplyr)
if (!require(devtools)) install.packages('devtools'); require(devtools)
if (!require(surveytools2)) install_github('peterhurford/surveytools2'); require(surveytools2)
if (!require(summarizeR)) install_github('peterhurford/summarizeR'); require(summarizeR)

'~/dev/imsurvey' %>% setwd()
'lwpublic2013.csv' %>% read.csv %>%           # Load CSV
  rename(
    is.ea = EffectiveAltruism,
    metaethics = MoralViews,
    is.atheist = ReligiousViews
  ) %>%                                       # Rename vars
  select(
    is.ea, metaethics, is.atheist, WorkStatus,
    Vegetarian, Sex, Age, Income, Charity
  ) %>%                                       # Filter to only useful vars
  swap_by_value('metaethics', list(
    'Accept / lean toward consequentialism' = 'consequentialist',
    'Accept / lean toward deontology' = 'deontology',
    'Accept / lean toward virtue ethics' = 'virtue',
    'Other / no answer' = 'other',
    '0' = 'N/A'
  )) %>%                                      # Consolidate metaethics responses
  swap_by_value('is.atheist', list(
    'Agnostic' = 'atheist',
    'Atheist and not spiritual' = 'atheist',
    'Atheist but spiritual' = 'atheist',
    'Committed theist' = 'theist',
    'Deist/Pantheist/etc.' = 'theist',
    'Lukewarm theist' = 'theist'
  )) %>%                                      # Narrow down to atheism vs. theism
  mutate(
    student = ifelse(WorkStatus == 'Student', 'Yes', 'No')
  ) %>%                                       # Var for student status
  swap_by_value('Vegetarian', list('0' = '')) %>%
  swap_by_value('is.atheist', list('0' = '')) %>%
  swap_by_value('Sex', list('0' = '')) ->     # 0s are NAs in these vars
  lwdata                                      # Collect the data!
