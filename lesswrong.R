### Libraries
if (!require(reshape2)) install.packages('reshape2'); require(reshape2)
if (!require(devtools)) install.packages('devtools'); require(devtools)
if (!require(surveytools)) install_github('peterhurford/surveytools'); require(surveytools)

### Read Data
setwd('~/dev/imsurvey')
lw <- read.csv('lwpublic2013.csv')  # Added an ID column
lw <- melt(lw, id='ID')
set_data(lw)

### Clean
# variable names
lw <- define_variables(list(
  'ea' = 'EffectiveAltruism',
  'metaethics' = 'MoralViews',
  'atheist' = 'ReligiousViews'
))

# metaethics
lw <- swap_by_value(list(
  'Accept / lean toward consequentialism' = 'consequentialist',
  'Accept / lean toward deontology' = 'deontology',
  'Accept / lean toward virtue ethics' = 'virtue',
  'Other / no answer' = 'other',
  '0' = 'N/A'
), 'metaethics')

# religion
lw <- swap_by_value(list(
  'Agnostic' = 'atheist',
  'Atheist and not spiritual' = 'atheist',
  'Atheist but spiritual' = 'atheist',
  'Committed theist' = 'theist',
  'Deist/Pantheist/etc.' = 'theist',
  'Lukewarm theist' = 'theist'
), 'atheist')

# student
lw <- make_new_var('student', sapply(
    fetch_var('WorkStatus', na.rm = FALSE),
    function(x) ifelse(x == 'Student', 'Yes', 'No')
  )
)

# 0s are NAs, at least in the variables we care about.
sapply(
  c('Sex', 'atheist', 'Vegetarian'),
  function(varname)
    lw <<- swap_by_value(list('0' = 'N/A'), varname)
)

# Exclude NonEAs
lw_overall <- lw
ea_ids <- fetch_var('ea', select = 'Yes', col = 1)
lw <- lw[lw[[1]] %in% ea_ids,]
set_data(lw)


### Analyze
table(fetch_var('ea', data = lw_overall))

fn_on_df(fetch_var('Age'), mean)
fn_on_df(fetch_var('Age'), sd)
fetch_percent_table('Sex')
table(fetch_var('metaethics'))
fetch_percent_table('atheist')
fetch_percent_table('Vegetarian')
fetch_percent_table('student')
fn_on_df(fetch_var_by('Income', list('student' = 'No')), median)
fn_on_df(fetch_var_by('Charity', list('student' = 'No')), median)

set_data(lw_overall)
fn_on_df(fetch_var('Age'), mean)
fn_on_df(fetch_var('Age'), sd)
fetch_percent_table('Sex')
table(fetch_var('metaethics'))
fetch_percent_table('atheist')
fetch_percent_table('Vegetarian')
fetch_percent_table('student')
fn_on_df(fetch_var_by('Income', list('student' = 'No')), median)
fn_on_df(fetch_var_by('Charity', list('student' = 'No')), median)
