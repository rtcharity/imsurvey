### Libraries
if (!require(reshape2)) install.packages('reshape2'); require(reshape2)
if (!require(devtools)) install.packages('devtools'); require(devtools)
if (!require(surveytools)) install_github('peterhurford/surveytools'); require(surveytools)

### Read Data
setwd('~/dev/imsurvey')
lw <- read.csv('lwpublic2013.csv')  # Added an ID column
lw <- melt(lw, id='ID')

### Clean
# variable names
lw <- define_variables(list(
  'ea' = 'EffectiveAltruism',
  'metaethics' = 'MoralViews',
  'atheist' = 'ReligiousViews'
), data = lw)

# metaethics
lw <- swap_by_value(list(
  'Accept / lean toward consequentialism' = 'consequentialist',
  'Accept / lean toward deontology' = 'deontology',
  'Accept / lean toward virtue ethics' = 'virtue',
  'Other / no answer' = 'other',
  '0' = 'N/A'
), 'metaethics', data = lw)

# religion
lw <- swap_by_value(list(
  'Agnostic' = 'atheist',
  'Atheist and not spiritual' = 'atheist',
  'Atheist but spiritual' = 'atheist',
  'Committed theist' = 'theist',
  'Deist/Pantheist/etc.' = 'theist',
  'Lukewarm theist' = 'theist'
), 'atheist', data = lw)

# student
lw <- make_new_var('student', sapply(
    fetch_var('WorkStatus', data = lw, na.rm = FALSE),
    function(x) ifelse(x == 'Student', 'Yes', 'No')
  ), data = lw
)

# 0s are NAs, at least in the variables we care about.
sapply(
  c('Sex', 'atheist', 'Vegetarian'),
  function(varname)
    lw <<- swap_by_value(list('0' = 'N/A'), varname, data = lw)
)

# Exclude NonEAs
lw_overall <- lw
ea_ids <- fetch_var('ea', select = 'Yes', col = 1, data = lw)
lw <- lw[lw[[1]] %in% ea_ids,]


### Analyze
table(fetch_var('ea', data = lw_overall))

fn_on_df(fetch_var('Age', data = lw), mean)
fn_on_df(fetch_var('Age', data = lw), sd)
fetch_percent_table('Sex', data = lw)
table(fetch_var('metaethics', data = lw))
fetch_percent_table('atheist', data = lw)
fetch_percent_table('Vegetarian', data = lw)
fetch_percent_table('student', data = lw)
fn_on_df(fetch_var_by('Income', list('student' = 'No'), data = lw), median)
fn_on_df(fetch_var_by('Charity', list('student' = 'No'), data = lw), median)

fn_on_df(fetch_var('Age', data = lw_overall), mean)
fn_on_df(fetch_var('Age', data = lw_overall), sd)
fetch_percent_table('Sex', data = lw_overall)
table(fetch_var('metaethics', data = lw_overall))
fetch_percent_table('atheist', data = lw_overall)
fetch_percent_table('Vegetarian', data = lw_overall)
fetch_percent_table('student', data = lw_overall)
fn_on_df(fetch_var_by('Income', list('student' = 'No'), data = lw_overall), median)
fn_on_df(fetch_var_by('Charity', list('student' = 'No'), data = lw_overall), median)
