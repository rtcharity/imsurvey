### Load Libraries
if (!require(magrittr)) install.packages('magrittr'); require(magrittr)
if (!require(dplyr)) install.packages('dplyr'); require(dplyr)
if (!require(devtools)) install.packages('devtools'); require(devtools)
if (!require(surveytools2)) install_github('peterhurford/surveytools2'); require(surveytools2)
if (!require(summarizeR)) install_github('peterhurford/summarizeR'); require(summarizeR)

'~/dev/imsurvey' %>% setwd()           # Set wd to where CSVs are
'transform_lookups.R' %>% source()     # Source lookup tables (we'll need them later)

# Cleaning functions for the CSVs
shared_cleaning_steps <- function(df)  # Cleaning functions shared among all CSVs
  df %>% select(
    -In.which.year.did.you.first.hear.the.term..Effective.Altruism..,
    -Your.email.address,
    -Which.of.the.following.groups.are.you.a.member.of..if.any...Other.,
    -Your.gender..Other.
  )

cleaning_steps <- function(df)  # Cleaning functions specifically for imdata
  df %>% shared_cleaning_steps %>% select(
    -Group.time..This.survey.is.for.everyone,
    -Question.time..ah1
  ) %>% mutate(age = as.numeric(Your.age)) %>% select(-Your.age) %>%
  mutate(id = as.character(Response.ID)) %>% select(-Response.ID)

cleaning_steps_for_ace_data <- function(df)  # Cleaning functions specifically for ace data
  df %>% shared_cleaning_steps %>% mutate(id = paste0('A', Response.ID)) %>% select(-Response.ID)

list('imdata.csv', 'imdata-more-results.csv') %>%
  lapply(., function(l) l %>% read.csv %>% cleaning_steps) %>%
  Reduce(rbind.fill, .) -> data  # Load imdata

'ace-results.csv' %>% read.csv %>% cleaning_steps_for_ace_data %>% # Load ACE data
  rbind.fill(data) %>% dplyr::filter(!is.na(id)) %>%               # Bind data together
  rename(
    describeEA = Could.you..however.loosely..be.described.as..an.EA..,
    metaethics = What.moral.philosophy.do.you.subscribe.to..if.any.,
    poverty = Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Global.poverty.,
    environmentalism = Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Environmentalism.,
    animals = Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Animal.welfare.,
    rationality = Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Improving.rationality.or.science.,
    politics = Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Political.reform.,
    ai = Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Existential.risk..artificial.intelligence..,
    xrisk = Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Existential.risk..other..,
    farfuture = Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Far.future.concerns..besides.existential.risk..,
    prioritization = Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Cause.prioritization.,
    metacharity = Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Meta.charities.which.direct.resources.to.these.causes.,
    causeother = Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Other.,
    diet = What.is.your.diet.,
    group = How.did.you.first.hear.about..Effective.Altruism..,
    factors_contact = Which.factors.were.important.in..getting.you.into..Effective.Altruism..or.altering.your.actions.in.its.direction...Personal.contact.with.an.EA.or.EAs.,
    factors_80K = Which.factors.were.important.in..getting.you.into..Effective.Altruism..or.altering.your.actions.in.its.direction...80.000.Hours.,
    factors_TLYCS = Which.factors.were.important.in..getting.you.into..Effective.Altruism..or.altering.your.actions.in.its.direction...The.Life.You.Can.Save.,
    factors_LW = Which.factors.were.important.in..getting.you.into..Effective.Altruism..or.altering.your.actions.in.its.direction...LessWrong.,
    factors_GWWC = Which.factors.were.important.in..getting.you.into..Effective.Altruism..or.altering.your.actions.in.its.direction...Giving.What.We.Can.,
    factors_givewell = Which.factors.were.important.in..getting.you.into..Effective.Altruism..or.altering.your.actions.in.its.direction...GiveWell.,
    factors_friends = Which.factors.were.important.in..getting.you.into..Effective.Altruism..or.altering.your.actions.in.its.direction...Friends.,
    factors_online = Which.factors.were.important.in..getting.you.into..Effective.Altruism..or.altering.your.actions.in.its.direction...The.online.EA.community.,
    factors_chapter = Which.factors.were.important.in..getting.you.into..Effective.Altruism..or.altering.your.actions.in.its.direction...Local.chapter.of.an.EA.organisation.,
    donate80K = Over.2013..which.charities.did.you.donate.to...80.000.Hours.,
    donateAMF = Over.2013..which.charities.did.you.donate.to...Against.Malaria.Foundation.,
    donateACE = Over.2013..which.charities.did.you.donate.to...Animal.Charity.Evaluators..formerly.Effective.Animal.Activism..,
    donateCEA = Over.2013..which.charities.did.you.donate.to...The.Centre.for.Effective.Altruism..unrestricted.donation..,
    donateCFAR = Over.2013..which.charities.did.you.donate.to...Center.For.Applied.Rationality.,
    donateDTW = Over.2013..which.charities.did.you.donate.to...Deworm.the.World.,
    donateGD = Over.2013..which.charities.did.you.donate.to...GiveDirectly.,
    donateGW = Over.2013..which.charities.did.you.donate.to...GiveWell..itself..,
    donateGWWC = Over.2013..which.charities.did.you.donate.to...Giving.What.We.Can..itself..,
    donateTHL = Over.2013..which.charities.did.you.donate.to...The.Humane.League.,
    donateLeverage = Over.2013..which.charities.did.you.donate.to...Leverage.Research.,
    donateMIRI = Over.2013..which.charities.did.you.donate.to...Machine.Intelligence.Research.Institute.,
    donatePHC = Over.2013..which.charities.did.you.donate.to...Project.Healthy.Children.,
    donateSCI = Over.2013..which.charities.did.you.donate.to...Schistosomiasis.Control.Initiative..SCI..,
    donateVO = Over.2013..which.charities.did.you.donate.to...Vegan.Outreach.,
    friendcount = Roughly.how.many.of.your.friends.would.describe.themselves.as.Effective.Altruists.,
    student = Are.you.a.full.time.student.,
    career = What.career.path.do.you.plan.to.follow.,
    donate2013 = Over.2013..how.much.in.total.did.you.donate.,
    income2013 = What.was.your.pre.tax.income.in.2013.,
    referrer = Referrer.URL,
    referrer2 = Postcode.Total.time.source,
    heardEA = Have.you.ever.heard.of.the.term..Effective.Altruism..or..EA..,
    gender = Your.gender,
    religion = Your.religious.beliefs,
    location = In.which.country.do.you.live.,
    sublocation = In.which.city.do.you.live.
  ) %>% # Give all the variables sensible names
  select(id, describeEA, metaethics, poverty, environmentalism, animals, rationality, politics, ai, xrisk, farfuture, prioritization, metacharity, causeother, diet, group, factors_contact, factors_80K, factors_TLYCS, factors_LW, factors_GWWC, factors_givewell, factors_friends, factors_online, factors_chapter, donate80K, donateAMF, donateACE, donateCEA, donateCFAR, donateDTW, donateGD, donateGW, donateGWWC, donateTHL, donateLeverage, donateMIRI, donatePHC, donateSCI, donateVO, friendcount, student, career, donate2013, income2013, referrer, referrer2, heardEA, gender, age, religion, location, sublocation) %>% # Select only the vars we want
  swap_by_value('metaethics', list(
    'Consequentialist/utilitarian' = 'consequentialist',
    'Deontology' = 'deontology',
    'Virtue ethics' = 'virtue',
    'Other' = 'other',
    'No opinion, or not familiar with these terms' = 'other'
  )) %>%     # Consolidate metaethics responses
  mutate(reducitarian = ifelse(diet == 'Meat-eating', FALSE, TRUE)) %>%  # Create a reducitarian var from diet data
  mutate(
    veg = ifelse(diet == 'Vegetarian', TRUE, ifelse(diet == 'Vegan', TRUE, FALSE))
  ) %>%      # Create a variable for just vegetarians and vegans
  swap_by_value('religion',
    list('Atheist, agnostic or non-religious' = 'atheist')
  ) %>%      # Clean up the response for religion
  swap_by_value('group', list(
    '80,000 Hours' = '80K',
    'Animal Charity Evaluators (formerly Effective Animal Activism)' = 'ACE',
    'Animal Charity Evaluators (formerly Effective Animal Activism)' = 'ACE',
    'Animal Charity Evaluators (formerlyåÊEffective Animal Activism)' = 'ACE',
    'Facebook' = 'FB',
    'Friend' = 'Friend',
    'GiveWell' = 'GiveWell',
    'Giving What We Can' = 'GWWC',
    'LessWrong' = 'LW',
    'Search engine' = 'Search',
    'TED Talk (Peter Singer)' = 'TED',
    'The Life You Can Save' = 'TLYCS',
    'local group' = 'Local Group'
  )) %>%    # Clean up group responses (Having ACE twice is because one has a space and one has a tab)
  swap_multiple_ids('factors_TLYCS',
    c(13, 31, 79, 110, 146, 367, 374, 383, 534, 577), 'Yes'
  ) %>%             # Impute into TLYCS factors
  swap_multiple_ids('factors_givewell', c(271), 'Yes') %>%  # Impute GiveWell factors
  swap_multiple_ids('factors_TLYCS',
    c(361, 374, 606), 'Yes'
  ) %>%             # Impute into online factors
  swap_by_value('sublocation', list(
    'San Francisco' = 'Bay Area',
    'Berkeley' = 'Bay Area',
    'New York City' = 'New York',
    'Cambridge, MA' = 'Boston',
    'Berkeley, CA' = 'Bay Area',
    'Palo Alto' = 'Bay Area',
    'Oakland, CA' = 'Bay Area',
    'San Francisco Bay Area, CA' = 'Bay Area',
    'Menlo Park' = 'Bay Area',
    'Mountain View' = 'Bay Area',
    'Los Altos, CA' = 'Bay Area',
    'Berkeley, California, USA' = 'Bay Area',
    'Berkeley CA' = 'Bay Area',
    'berkeley' = 'Bay Area',
    'Bay area' = 'Bay Area',
    'Sunnyvale' = 'Bay Area',
    'basel' = 'Basel',
    'Lonodn' = 'London',
    'london' = 'London',
    'chicago, IL' = 'Chicago',
    'Washington, DC' = 'Washington DC',
    'seattle' = 'Seattle',
    'oxford' = 'Oxford',
    'Oxford and Bath' = 'Oxford',
    'NYC' = 'New York City',
    'NY' = 'New York City',
    'New York ' = 'New York City',
    'nyc' = 'New York City',
    'Melbourne/Taree' = 'Melbourne',
    'Melbourne (or near enough)' = 'Melbourne',
    'Melbourne ' = 'Melbourne',
    'Boston, MA' = 'Boston',
    'Washington, D.C.' = 'Washington DC',
    'Washington D.C.' = 'Washington DC',
    'Vancouver, BC, Canada' = 'Vancouver',
    'Vancouver ' = 'Vancouver'
  )) %>%    # Clean up city responses
  swap_by_value('career', list(
    "Direct charity/non-profit work" = "Direct",
    "Earning to Give" = "ETG",
    "None of these" = "None",
    "Research" = "Research",
    "Other" = "None"
  )) %>%    # Clean up career responses
  left_join(., count_vars(., c('donateAMF', 'donateSCI', 'donateGD', 'donateMIRI', 'donateCFAR',
    'donateGW', 'donateDTW', 'donateVO', 'donateTHL', 'donate80K', 'donateCEA',
    'donatePHC', 'donateGWWC', 'donateACE', 'donateLeverage'),
     response = 'Yes', colname = 'charity_count')) %>%   # Append number of charities donated
  swap_by_ids('career', career_transform) %>%       # Imputation with career responses
  swap_by_ids('donate2013', donate_transform) %>%   # Imputation with donation responses
  swap_by_ids('income2013', income_transform) %>%   # Imputation with income responses
  { make_p_inc_donate <- function(donate, income) {
      mapply(function(d, i) {
        d <- as.numeric(d)
        i <- as.numeric(i)
        if (is.na(i)) return("")
        if (is.na(d)) return("")
        (d / i) * 100
      }, donate, income)
    }
    mutate(., p_inc_donate = make_p_inc_donate(donate2013, income2013))
  } %>% {
    is.annoying <- function(x) is.na_like(x) | is.nan(x) | is.infinite(x) | x == "NaN" | x == "Inf"
    mutate(., p_inc_donate = ifelse(is.annoying(p_inc_donate), NA, p_inc_donate))
  } %>% # Get data on percentage of income donated
  mutate(
    income2013 = as.numeric(income2013),
    donate2013 = as.numeric(donate2013),
    p_inc_donate = as.numeric(p_inc_donate)
  ) %>%     # Transform income / donation data to numeric
  mutate(
    is.ETG = ifelse(income2013 >= 60000 & p_inc_donate >= 0.1, TRUE, FALSE)
  ) %>%     # Is this person "earning to give"?
  { referrer_transform <- function(r) {
      r[grepl('\\?', r)] <- sapply(strsplit(r[grepl('\\?', r)], '\\?'), '[', 2)
      r[nchar(r) > 12] <- ""
      r[substring(r, 1, 1) == 't' & !is.na(r)] <- "t"
      r
    }
    mutate(., referrer = referrer_transform(referrer))
  } %>% swap_by_value('referrer', list(
    's=1' = '',
    's=9' = 'EAFB',
    's=14' = 'LW',
    's=18' = 'OtherFB',
    's=19' = 'Special',
    'rockstar' = 'Personal',
    'eah-profiles' = 'EA Profiles',
    't' = 'Personal',
    'p' = 'Personal'
  )) %>% swap_multiple_ids('referrer', data$id[grepl("A", data$id)], 'ACE') %>%
  { referrer_transform <- function(r) { r[nchar(r) < 5] <- ""; r }
    mutate(., referrer2 = referrer_transform(referrer2))
  } %>% swap_multiple_ids('referrer2', data$id[grepl("A", data$id)], 'ACE') %>%
  swap_by_value('referrer2', list(
    'An EA Facebook group' = 'EAFB',
    'EA organisation' = 'EA Org?',
    'Local group or chapter' = 'Local group',
    'LessWrong' = 'LW',
    'Elsewhere on Facebook or social media' = 'FB elsewhere',
    'Animal Charity Evaluators (email, blog, etc.)' = 'ACE'
  )) %>%    # Clean referrer data
  mutate(in_random_fb_sample = id %in% random_sample_ids) -> imdata


# Exclude NonEAs and no answers
imdata_with_non_eas <- imdata
imdata %<>% dplyr::filter(describeEA == "Yes")

## Demographics
imdata_with_non_eas %>% num_respondants
imdata_with_non_eas %>% num_answers('describeEA', na = 'N/A')
imdata_with_non_eas %>% response_rate('describeEA', na = 'N/A')
imdata_with_non_eas %>% dplyr_table(heardEA)
imdata_with_non_eas %>% dplyr_table(describeEA)
imdata_with_non_eas %>% dplyr_table(heardEA, describeEA, percent = TRUE)
imdata %>% num_respondants

imdata %>% dplyr_table(group, percent = TRUE)

factors <- c('contact', '80K', 'TLYCS', 'LW', 'GWWC', 'givewell', 'friends', 'online', 'chapter')
factors %>% sapply(function(x) imdata %>% select_(.dots = paste0("factors_", x)) %>% table)

imdata %>% dplyr_table(location)
imdata %>% dplyr_table(sublocation)

imdata_with_non_eas %>% num_answers('donate2013', na = '')
imdata %>% num_answers('donate2013', na = '')
imdata_with_non_eas %>% dplyr::filter(donate2013 == 0) %>% select(donate2013) %>% num_respondants
imdata %>% dplyr::filter(donate2013 == 0) %>% select(donate2013) %>% num_respondants
imdata %>% gather(donate2013) %>% var_summary
imdata %>% dplyr::filter(student == "No") %>% gather(donate2013) %>% var_summary
imdata %>% dplyr::filter(student == "Yes") %>% gather(donate2013) %>% var_summary
t.test(imdata$donate2013, imdata$student == "Yes")
imdata %>% gather(donate2013) %>% quantile(probs = seq(0.1, 1, len = 10), na.rm = TRUE)
imdata %>% gather(donate2013) %>% quantile(probs = seq(0.91, 1, len = 10), na.rm = TRUE)
imdata %>% dplyr::filter(income2013 >= 10000) %>% gather(p_inc_donate) %>% var_summary
imdata %>% dplyr::filter(income2013 >= 10000 & student == "No") %>% gather(p_inc_donate) %>% var_summary
imdata %>% dplyr::filter(income2013 >= 10000) %>% num_respondants
imdata %>% dplyr::filter(income2013 >= 10000) %>% breakdown('p_inc_donate', c(seq(3), seq(5, 20, by = 5), seq(30, 100, by = 10)))
cuts <- c(1, seq(0, 50, by = 5)[-1])
imdata %>% dplyr::filter(income2013 >= 10000) %>% numeric_breakdown('p_inc_donate', cuts) %>% {
  plot.new()
  plot(., ylab = '', xaxt = 'n')
  axis(side = 1, at = seq_along(cuts), labels = cuts)
}
imdata %>% gather(p_inc_donate) %>% cut(rev(cuts), right = FALSE) %>% table %>% cumsum %>% plot 

c(
  'AMF', 'SCI', 'GD', 'MIRI', 'CFAR', 'GW', 'DTW', 'VO', 'THL', '80K', 'CEA', 'PHC', 'GWWC', 'ACE', 'Leverage'
) %>% paste0('donate', .) %>% sapply(function(x) table(imdata[[x]]))

imdata %>% breakdown('charity_count', seq(7))

c('poverty', 'metacharity', 'rationality', 'prioritization', 'ai', 'xrisk', 'environmentalism', 'animals', 'politics', 'farfuture') %>%
  sapply(function(x) table(imdata[[x]]))

imdata %>% dplyr_table(metacharity, rationality, prioritization, percent = TRUE, freq = TRUE)

imdata %>% dplyr_table(diet)
imdata %>% dplyr_table(reducitarian, percent = TRUE)
imdata %>% dplyr_table(veg, percent = TRUE)
imdata %>% dplyr_table(diet, percent = TRUE)
imdata %>% dplyr_table(diet, animals, percent = TRUE)
chisq.test(imdata$diet, imdata$animals)

imdata %>% dplyr_table(career)
imdata %>% dplyr::filter(student == "No" & career == "ETG") %>% gather(donate2013) %>% var_summary
t.test(imdata$donate2013, imdata$career == "ETG")
t.test(imdata$p_inc_donate, imdata$career == "ETG")
imdata %>% dplyr::filter(is.ETG == TRUE) %>% num_respondants
imdata %>% dplyr::filter(is.ETG == TRUE) %>% gather(donate2013) %>% sum

imdata %>% dplyr_table(friendcount)
imdata %>% dplyr_table(friendcount, referrer, percent = TRUE)
imdata %>% dplyr_table(referrer, gender, percent = TRUE)

imdata %>% gather(age) %T>% hist %>% var_summary

imdata %>% dplyr_table(referrer, religion, percent = TRUE)
imdata %>% dplyr_table(referrer, student, percent = TRUE)
imdata %>% dplyr_table(referrer, metaethics, percent = TRUE)


### Methodological Appendix
imdata %>% dplyr_table(referrer)
imdata %>% dplyr_table(referrer2)
imdata %>% dplyr_table(referrer, referrer2, percent = TRUE)

# LessWrong comparison
joint_processing <- function(vars, type) {
  vars %>% lapply(function(x) imdata %>%
  filter_(.dots = paste0(x, " != ''")) %>% 
  comparison_table(x, 'referrer', type)) %>% {
    names(.) <- vars
    .
  }
}
c('age', 'income2013', 'donate2013', 'p_inc_donate') %>% joint_processing('continuous')
c('gender', 'metaethics', 'religion', 'veg', 'poverty', 'xrisk', 'student') %>% joint_processing('categorical')


### Compare with LW Survey
source('lesswrong.R')
lwdata %<>% dplyr::filter(is.ea == 'Yes')
imdata %>% dplyr::filter(referrer == "LW") %>%
  dplyr::filter(age != "") %>%
  dplyr::filter(gender != "") %>%
  dplyr::filter(metaethics != "") %>%
  dplyr::filter(religion != "") %>%
  dplyr::filter(veg != "") %>%
  dplyr::filter(student != "") -> imlwdata

lwdata %>% num_respondants
lwdata %>% gather(Age) %>% var_summary
t.test(imlwdata$age, lwdata$Age)
lwdata %>% dplyr_table(Sex, percent = TRUE)
t.test(imlwdata$gender == "Male", lwdata$Sex == "Male")
lwdata %>% dplyr_table(metaethics, percent = TRUE)
t.test(imlwdata$metaethics == "consequentialist", lwdata$metaethics == "consequentialist")
lwdata %>% dplyr_table(is.atheist, percent = TRUE)
t.test(imlwdata$religion == "atheist", lwdata$is.atheist == "atheist")
lwdata %>% dplyr_table(Vegetarian, percent = TRUE)
t.test(imlwdata$veg, lwdata$Vegetarian == "Yes")
lwdata %>% dplyr_table(student, percent = TRUE)
t.test(imlwdata$student == "Yes", lwdata$student == "Yes")

lwdata %>% dplyr::filter(student == "No") %>%
  gather(Income) %>% as.numeric -> lwincome
imdata %>% dplyr::filter(student == "No" & referrer == "LW") %>%
  gather(income2013) -> imincome
imincome %>% var_summary
lwincome %>% var_summary
t.test(imincome, lwincome)

lwdata %>% dplyr::filter(student == "No") %>%
  gather(Charity) %>% as.numeric -> lwcharity
imdata %>% dplyr::filter(student == "No" & referrer == "LW") %>%
  gather(donate2013) -> imcharity
lwcharity %>% var_summary
imcharity %>% var_summary
t.test(lwcharity, imcharity)


### Compare with EA FB Random Sample
imdata %>% dplyr::filter(in_random_fb_sample == TRUE) -> imdata_sample
imdata %>% dplyr::filter(referrer == "EAFB") -> imdata_fb
imdata_sample %>% gather(age) %>% var_summary
t.test(imdata_fb$age, imdata_sample$age)
imdata_sample %>% dplyr_table(gender, percent = TRUE)
t.test(imdata_fb$gender == "Male", imdata_sample$gender == "Male")
imdata_sample %>% dplyr_table(metaethics, percent = TRUE)
t.test(imdata_fb$metaethics == "consequentialist", imdata_sample$metaethics == "consequentialist")
imdata_sample %>% dplyr_table(religion, percent = TRUE)
t.test(imdata_fb$religion == "atheist", imdata_sample$religion == "atheist")
imdata_sample %>% dplyr_table(veg, percent = TRUE, na.rm = TRUE)
t.test(imdata_fb$veg, imdata_sample$veg)
imdata_sample %>% dplyr_table(poverty, percent = TRUE)
t.test(imdata_fb$poverty == "Yes", imdata_sample$poverty == "Yes")
imdata_sample %>% dplyr_table(environmentalism, percent = TRUE)
t.test(imdata_fb$environmentalism == "Yes", imdata_sample$environmentalism == "Yes")
imdata_sample %>% dplyr_table(xrisk, percent = TRUE)
t.test(imdata_fb$xrisk == "Yes", imdata_sample$xrisk == "Yes")
imdata_sample %>% dplyr_table(student, percent = TRUE)
t.test(imdata_fb$student == "Yes", imdata_sample$student == "Yes")
imdata_sample %>% gather(income2013) %>% var_summary
t.test(imdata_fb$income2013, imdata_sample$income2013)
imdata_sample %>% gather(donate2013) %>% var_summary
t.test(imdata_fb$donate2013, imdata_sample$donate2013)


# GiveWell comparison
imdata %>% dplyr::filter(donate2013 >= 1) %>% num_respondants -> t
c(100000, 50000, 10000, 5000, 1000, 1) %>% sapply(function(x) {
    restriction <- paste0('donate2013 >= ', x)
    if (x != 100000) restriction <- paste0(restriction, ' & donate2013 < ', prev_x)
    imdata %>% dplyr::filter_(restriction) %>% num_respondants -> o
    prev_x <<- x
    paste0(o, ' (', round(o / t, 3) * 100, '%)')
  })
imdata %>% dplyr::filter(donate2013 >= 2000) %>% dplyr::filter(age >= 20) %>% num_respondants -> t
seq(80, 20, by = -10) %>% sapply(function(x) {
    restriction <- paste0('age >= ', x)
    if (x != 80) restriction <- paste0(restriction, ' & age < ', prev_x)
    imdata %>% dplyr::filter(donate2013 >= 2000) %>% dplyr::filter_(restriction) %>% num_respondants -> o
    prev_x <<- x
    paste0(o, ' (', round(o / t, 3) * 100, '%)')
  })
