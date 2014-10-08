### Open Data
setwd('~/dev/imsurvey')
imdata <- read.csv('imdata.csv')


### Clean Data
# Response ID
id <- imdata$Response.ID


# Metaethics
metaethics <- rep(NA, 1856)
metaethicsfeed <- imdata$What.moral.philosophy.do.you.subscribe.to..if.any. 
metaethics[metaethicsfeed == 'Consequentialist/utilitarian'] <- 'consequentialist'
metaethics[metaethicsfeed == 'Deontology'] <- 'deontology'  
metaethics[metaethicsfeed == 'Other' | metaethicsfeed == 'No opinion, or not familiar with these terms'] <- 'other'
metaethics[metaethicsfeed == 'Virtue ethics'] <- 'virtue'
metaethics[id == 17 | id == 45 | id == 122 | id == 201 | id == 217 | id == 377 | id == 425 | id == 524 | id == 571 | id == 971 | id == 974 | id == 994 | id == 1029 | id == 1054 | id == 1060 | id == 1035 | id == 1438 | id == 1459 | id == 1548 | id == 1572 | id == 1678 | id == 1707] <- 'consequentialist'  # Interpolate other, lump 'non-utilitarian consequetialist', 'non-realist consequentialist' and 'consequentialist in theory and deontology in practice' into consequentialist


# Causes
poverty = rep(NA, 1856)
povertyfeed = imdata$Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Global.poverty.
poverty[povertyfeed == 'No'] <- 0
poverty[povertyfeed == 'Yes'] <- 1

environmentalism = rep(NA, 1856)
environmentalismfeed = imdata$Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Environmentalism.
environmentalism[environmentalismfeed == 'No'] <- 0
environmentalism[environmentalismfeed == 'Yes'] <- 1

animals = rep(NA, 1856)
animalsfeed = imdata$Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Animal.welfare.
animals[animalsfeed == 'No'] <- 0
animals[animalsfeed == 'Yes'] <- 1

rationality = rep(NA, 1856)
rationalityfeed = imdata$Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Improving.rationality.or.science.
rationality[rationalityfeed == 'No'] <- 0
rationality[rationalityfeed == 'Yes'] <- 1

politics = rep(NA, 1856)
politicsfeed = imdata$Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Political.reform.
politics[politicsfeed == 'No'] <- 0
politics[politicsfeed == 'Yes'] <- 1

ai = rep(NA, 1856)
aifeed = imdata$Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Existential.risk..artificial.intelligence.
ai[aifeed == 'No'] <- 0
ai[aifeed == 'Yes'] <- 1

xrisk = rep(NA, 1856)
xriskfeed = imdata$Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Existential.risk..other..
xrisk[xriskfeed == 'No'] <- 0
xrisk[xriskfeed == 'Yes'] <- 1

farfuture = rep(NA, 1856)
farfuturefeed = imdata$Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Far.future.concerns..besides.existential.risk..
farfuture[farfuturefeed == 'No'] <- 0
farfuture[farfuturefeed == 'Yes'] <- 1

prioritization = rep(NA, 1856)
prioritizationfeed = imdata$Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Cause.prioritization.
prioritization[prioritizationfeed == 'No'] <- 0
prioritization[prioritizationfeed == 'Yes'] <- 1

metacharity = rep(NA, 1856)
metacharityfeed = imdata$Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Meta.charities.which.direct.resources.to.these.causes.
metacharity[metacharityfeed == 'No'] <- 0
metacharity[metacharityfeed == 'Yes'] <- 1

causeother = rep(0, 1856)
causeotherfeed = imdata$Which.of.the.following.causes.do.you.think.you.should.devote.resources.to...Other.
causeother[causeotherfeed != ""] <- 1


# Diet
diet <- imdata$What.is.your.diet.
diet2 = rep(NA, 1856)
diet2[diet == 'Meat-eating'] <- 0
diet2[diet != 'Meat-eating' & !is.na(diet)] <- 1


# Group
groupfeed = imdata$How.did.you.first.hear.about..Effective.Altruism..
group = rep(NA, 1856)
group[groupfeed == "80,000 Hours"] <- "CEA"
group[groupfeed == "Animal Charity Evaluators (formerly Effective Animal Activism)"] <- "ACE"
group[groupfeed == "Facebook"] <- "FB"
group[groupfeed == "Friend"] <- "Friend"
group[groupfeed == "GiveWell"] <- "GiveWell"
group[groupfeed == "Giving What We Can"] <- "CEA"
group[groupfeed == "LessWrong"] <- "LW"
group[groupfeed == "Search engine"] <- "Search"
group[groupfeed == "TED Talk (Peter Singer)"] <- "TED"
group[groupfeed == "The Life You Can Save"] <- "TLYCS"
#Impute other
group[id == 11] <- "Felicifia"
group[id == 35] <- "Friend"
group[id == 37] <- "CEA"
group[id == 38] <- "Swiss"
group[id == 39] <- "TLYCS"
group[id == 49] <- "CEA"
group[id == 51] <- "Swiss"
group[id == 60] <- "Swiss"
group[id == 65] <- "CEA"
group[id == 71] <- "Local Group"
group[id == 78] <- "Friend"
group[id == 96] <- "Swiss"
group[id == 99] <- "Swiss"
group[id == 110] <- "Felicifia"
group[id == 135] <- "LW"
group[id == 146] <- "CEA"
group[id == 143] <- "Local Group"
group[id == 149] <- "Friend"
group[id == 171] <- "Local Group"
group[id == 173] <- "Local Group"
group[id == 213] <- "Local Group"
group[id == 220] <- "Friend"
group[id == 226] <- "Search"
group[id == 230] <- "TLYCS"
group[id == 239] <- "Leverage"
group[id == 260] <- "Friend"
group[id == 279] <- "Search"
group[id == 284] <- "Swiss"
group[id == 318] <- "Local Group"
group[id == 325] <- "Friend"
group[id == 330] <- "CEA"
group[id == 358] <- "Local Group"
group[id == 366] <- "Local Group"
group[id == 372] <- "Friend"
group[id == 373] <- "CEA"
group[id == 458] <- "TLYCS"
group[id == 467] <- "Leverage"
group[id == 506] <- "CEA"
group[id == 516] <- "Leverage"
group[id == 610] <- "LW"
group[id == 685] <- "GiveWell"
group[id == 695] <- "CFAR"
group[id == 724] <- "TLYCS"
group[id == 776] <- "TLYCS"
group[id == 836] <- "CEA"
group[id == 847] <- "TLYCS"
group[id == 848] <- "LW"
group[id == 864] <- "TLYCS"
group[id == 894] <- "Search"
group[id == 917] <- "GiveWell"
group[id == 935] <- "Leverage"
group[id == 942] <- "Search"
group[id == 948] <- "Local Group"
group[id == 959] <- "Local Group"
group[id == 970] <- "TLYCS"
group[id == 1003] <- "CFAR"
group[id == 1060] <- "GiveWell"
group[id == 1130] <- "CEA"
group[id == 1175] <- "TLYCS"
group[id == 1176] <- "SSC"
group[id == 1198] <- "SSC"
group[id == 1207] <- "SSC"
group[id == 1246] <- "Friend"
group[id == 1299] <- "TLYCS"
group[id == 1132] <- "TLYCS"
group[id == 1131] <- "THINK"
group[id == 1413] <- "Swiss"
group[id == 1414] <- "Friend"
group[id == 1441] <- "Swiss"
group[id == 1474] <- "THINK"
group[id == 1488] <- "Felicifia"
group[id == 1513] <- "Felicifia"
group[id == 1517] <- "TLYCS"
group[id == 1592] <- "CFAR"
group[id == 1606] <- "Friend"
group[id == 1611] <- "Friend"
group[id == 1661] <- "Friend"
group[id == 1689] <- "CEA"
group[id == 1804] <- "Local Group"

# Which factors were important in 'getting you into' Effective Altruism, or altering your actions in its direction? 
factors_contact = imdata$Which.factors.were.important.in..getting.you.into..Effective.Altruism..or.altering.your.actions.in.its.direction...Personal.contact.with.an.EA.or.EAs.
factors_80K = imdata$Which.factors.were.important.in..getting.you.into..Effective.Altruism..or.altering.your.actions.in.its.direction...80.000.Hours.
factors_TLYCS = imdata$Which.factors.were.important.in..getting.you.into..Effective.Altruism..or.altering.your.actions.in.its.direction...The.Life.You.Can.Save.
factors_LW = imdata$Which.factors.were.important.in..getting.you.into..Effective.Altruism..or.altering.your.actions.in.its.direction...LessWrong.
factors_GWWC = imdata$Which.factors.were.important.in..getting.you.into..Effective.Altruism..or.altering.your.actions.in.its.direction...Giving.What.We.Can.
factors_givewell = imdata$Which.factors.were.important.in..getting.you.into..Effective.Altruism..or.altering.your.actions.in.its.direction...GiveWell.
factors_friends = imdata$Which.factors.were.important.in..getting.you.into..Effective.Altruism..or.altering.your.actions.in.its.direction...Friends.
factors_online = imdata$Which.factors.were.important.in..getting.you.into..Effective.Altruism..or.altering.your.actions.in.its.direction...The.online.EA.community.
factors_chapter = imdata$Which.factors.were.important.in..getting.you.into..Effective.Altruism..or.altering.your.actions.in.its.direction...Local.chapter.of.an.EA.organisation.
factors_other = imdata$Which.factors.were.important.in..getting.you.into..Effective.Altruism..or.altering.your.actions.in.its.direction...Other.
factors_TLYCS[id == 13] <- "Yes"
factors_TLYCS[id == 31] <- "Yes"
factors_TLYCS[id == 79] <- "Yes"
factors_TLYCS[id == 110] <- "Yes"
factors_TLYCS[id == 146] <- "Yes"
factors_givewell[id == 271] <- "Yes"
factors_online[id == 361] <- "Yes"
factors_TLYCS[id == 367] <- "Yes"
factors_online[id == 374] <- "Yes"
factors_TLYCS[id == 374] <- "Yes"
factors_TLYCS[id == 383] <- "Yes"
factors_TLYCS[id == 534] <- "Yes"
factors_TLYCS[id == 577] <- "Yes"
factors_online[id == 606] <- "Yes"



# Friend Count
friendcount = imdata$Roughly.how.many.of.your.friends.would.describe.themselves.as.Effective.Altruists.


# Career Path
careerfeed = imdata$What.career.path.do.you.plan.to.follow.
career = rep(NA, 1856)
career[careerfeed == "Direct charity/non-profit work"] <- "Direct"
career[careerfeed == "Earning to Give"] <- "ETG"
career[careerfeed == "None"] <- "None"
career[careerfeed == "Research"] <- "Research"
career[careerfeed == "Other"] <- "None"
career[id == 11] <- "Research"
career[id == 21] <- "ETGHybrid"
career[id == 36] <- "Research"
career[id == 47] <- "ETGHybrid"
career[id == 53] <- "Research"
career[id == 58] <- "ETGHybrid"
career[id == 122] <- "Research"
career[id == 144] <- "ETGHybrid"
career[id == 233] <- "ETGHybrid"
career[id == 265] <- "Direct"
career[id == 298] <- "Direct"
career[id == 361] <- "Research"
career[id == 265] <- "Direct"
career[id == 387] <- "ETG"
career[id == 393] <- "ETGHybrid"
career[id == 399] <- "Direct"
career[id == 454] <- "ETGHybrid"
career[id == 468] <- "ETG"
career[id == 499] <- "ETG"
career[id == 502] <- "ETG"
career[id == 545] <- "Research"
career[id == 580] <- "ETG"
career[id == 586] <- "ETG"
career[id == 587] <- "ETGHybrid"
career[id == 618] <- "ETG"
career[id == 630] <- "Direct"
career[id == 678] <- "ETG"
career[id == 694] <- "ETGHybrid"
career[id == 706] <- "ETGHybrid"
career[id == 716] <- "Direct"
career[id == 725] <- "ETG"
career[id == 738] <- "Direct"
career[id == 766] <- "ETGHybrid"
career[id == 791] <- "Research"
career[id == 821] <- "ETG"
career[id == 832] <- "ETG"
career[id == 852] <- "Direct"
career[id == 876] <- "ETGHybrid"
career[id == 894] <- "ETGHybrid"
career[id == 1253] <- "ETG"
career[id == 1380] <- "ETGHybrid"
career[id == 1474] <- "Research"
career[id == 1640] <- "Research"
career[id == 1704] <- "Direct"
career[id == 1735] <- "ETG"
career[id == 1739] <- "ETG"
career[id == 1762] <- "ETG"
career[id == 1769] <- "ETG"
career[id == 1786] <- "Direct"
career[id == 1826] <- "ETG"
career[id == 1837] <- "Direct"


# Student
student = imdata$Are.you.a.full.time.student.


# Donation Total
donate_2013 = rep(NA, 1856)
donate_2013[id == 6] <- 6216.82
donate_2013[id == 13] <- 1000
donate_2013[id == 17] <- 7000
donate_2013[id == 18] <- 5513.44
donate_2013[id == 21] <- 1985.96
donate_2013[id == 24] <- 30000
donate_2013[id == 27] <- 330
donate_2013[id == 30] <- 100
donate_2013[id == 31] <- 1000
donate_2013[id == 32] <- 2000
donate_2013[id == 36] <- 1475
donate_2013[id == 37] <- 100000
donate_2013[id == 38] <- 644.33
donate_2013[id == 39] <- 1295.17
donate_2013[id == 42] <- 300
donate_2013[id == 45] <- 0
donate_2013[id == 47] <- 2300
donate_2013[id == 49] <- 9690
donate_2013[id == 51] <- 118.13
donate_2013[id == 52] <- 3600
donate_2013[id == 53] <- 647.58
donate_2013[id == 54] <- 647.58
donate_2013[id == 55] <- 0
donate_2013[id == 59] <- 8000
donate_2013[id == 60] <- 1073.88
donate_2013[id == 69] <- 129.52
donate_2013[id == 71] <- 750
donate_2013[id == 72] <- 931.20
donate_2013[id == 78] <- 336.74
donate_2013[id == 79] <- 150
donate_2013[id == 80] <- 500
donate_2013[id == 82] <- 12951.70
donate_2013[id == 83] <- 4200
donate_2013[id == 84] <- 0
donate_2013[id == 85] <- 4864.23
donate_2013[id == 86] <- 1000
donate_2013[id == 94] <- 1036.14
donate_2013[id == 96] <- 1610.82
donate_2013[id == 98] <- 154.42
donate_2013[id == 99] <- 1000
donate_2013[id == 104] <- 0
donate_2013[id == 106] <- 105000
donate_2013[id == 108] <- 647.28
donate_2013[id == 110] <- 20000
donate_2013[id == 116] <- 484.42
donate_2013[id == 120] <- 25000
donate_2013[id == 121] <- 4498
donate_2013[id == 126] <- 3660.99
donate_2013[id == 130] <- 14000
donate_2013[id == 132] <- 350
donate_2013[id == 133] <- 8000
donate_2013[id == 135] <- 6000
donate_2013[id == 137] <- 50
donate_2013[id == 138] <- 4844.19
donate_2013[id == 140] <- 50000
donate_2013[id == 144] <- 300
donate_2013[id == 145] <- 129.18
donate_2013[id == 146] <- 0
donate_2013[id == 148] <- 600
donate_2013[id == 149] <- 2500
donate_2013[id == 152] <- 5000
donate_2013[id == 153] <- 200
donate_2013[id == 156] <- 1500
donate_2013[id == 158] <- 0
donate_2013[id == 163] <- 200
donate_2013[id == 171] <- 300
donate_2013[id == 172] <- 0
donate_2013[id == 173] <- 5000
donate_2013[id == 178] <- 0
donate_2013[id == 179] <- 10000
donate_2013[id == 180] <- 807.37
donate_2013[id == 183] <- 968.84
donate_2013[id == 191] <- 50
donate_2013[id == 192] <- 0
donate_2013[id == 193] <- 3229.46
donate_2013[id == 195] <- 350
donate_2013[id == 197] <- 200
donate_2013[id == 198] <- 3000
donate_2013[id == 199] <- 3000
donate_2013[id == 201] <- 450
donate_2013[id == 203] <- 1000
donate_2013[id == 204] <- 3000
donate_2013[id == 207] <- 2046
donate_2013[id == 212] <- 0
donate_2013[id == 213] <- 160000
donate_2013[id == 217] <- 180
donate_2013[id == 219] <- 0
donate_2013[id == 220] <- 20000
donate_2013[id == 221] <- 0
donate_2013[id == 222] <- 60000
donate_2013[id == 223] <- 800
donate_2013[id == 225] <- 7000
donate_2013[id == 226] <- 7000
donate_2013[id == 228] <- 2000
donate_2013[id == 230] <- 0
donate_2013[id == 233] <- 3719.40
donate_2013[id == 239] <- 0
donate_2013[id == 241] <- 500
donate_2013[id == 244] <- 0
donate_2013[id == 247] <- 100
donate_2013[id == 248] <- 20
donate_2013[id == 249] <- 100
donate_2013[id == 255] <- 0
donate_2013[id == 256] <- 10000
donate_2013[id == 261] <- 0
donate_2013[id == 265] <- 200
donate_2013[id == 271] <- 0
donate_2013[id == 273] <- 11300
donate_2013[id == 275] <- 0
donate_2013[id == 278] <- 20000
donate_2013[id == 279] <- 517.83
donate_2013[id == 283] <- 0
donate_2013[id == 284] <- 0
donate_2013[id == 286] <- 250
donate_2013[id == 287] <- 1294.57
donate_2013[id == 290] <- 800
donate_2013[id == 291] <- 0
donate_2013[id == 294] <- 10000
donate_2013[id == 295] <- 258.91
donate_2013[id == 296] <- 20
donate_2013[id == 297] <- 64.39
donate_2013[id == 298] <- 5562.82
donate_2013[id == 299] <- 500
donate_2013[id == 300] <- 250
donate_2013[id == 301] <- 630.66
donate_2013[id == 303] <- 8106.47
donate_2013[id == 305] <- 194.56
donate_2013[id == 307] <- 900
donate_2013[id == 308] <- 6100
donate_2013[id == 319] <- 486.39
donate_2013[id == 320] <- 5000
donate_2013[id == 321] <- 100
donate_2013[id == 323] <- 5000
donate_2013[id == 325] <- 50
donate_2013[id == 328] <- 2000
donate_2013[id == 329] <- 50
donate_2013[id == 330] <- 0
donate_2013[id == 332] <- 324.26
donate_2013[id == 333] <- 1715
donate_2013[id == 335] <- 250
donate_2013[id == 337] <- 1700
donate_2013[id == 338] <- 810.65
donate_2013[id == 341] <- 20
donate_2013[id == 342] <- 0
donate_2013[id == 343] <- 500
donate_2013[id == 347] <- 50
donate_2013[id == 350] <- 1350
donate_2013[id == 351] <- 15000
donate_2013[id == 355] <- 100
donate_2013[id == 356] <- 154.88
donate_2013[id == 361] <- 0
donate_2013[id == 362] <- 0
donate_2013[id == 365] <- 40
donate_2013[id == 364] <- 788.43
donate_2013[id == 366] <- 240
donate_2013[id == 367] <- 7000
donate_2013[id == 368] <- 163.95
donate_2013[id == 369] <- 600
donate_2013[id == 370] <- 50
donate_2013[id == 371] <- 7650
donate_2013[id == 373] <- 87599.24
donate_2013[id == 374] <- 10000
donate_2013[id == 375] <- 6
donate_2013[id == 382] <- 65
donate_2013[id == 383] <- 30000
donate_2013[id == 387] <- 25000
donate_2013[id == 390] <- 163.95
donate_2013[id == 391] <- 6500
donate_2013[id == 393] <- 0
donate_2013[id == 394] <- 0
donate_2013[id == 395] <- 111
donate_2013[id == 396] <- 15
donate_2013[id == 397] <- 100
donate_2013[id == 399] <- 412.1
donate_2013[id == 401] <- 0
donate_2013[id == 402] <- 387.70
donate_2013[id == 406] <- 13870.66
donate_2013[id == 407] <- 1809.28
donate_2013[id == 410] <- 32.31
donate_2013[id == 413] <- 0
donate_2013[id == 418] <- 858.66
donate_2013[id == 422] <- 194.41
donate_2013[id == 427] <- 1351.79
donate_2013[id == 428] <- 40
donate_2013[id == 429] <- 9562.50
donate_2013[id == 430] <- 70.40
donate_2013[id == 434] <- 3000
donate_2013[id == 439] <- 921.02
donate_2013[id == 441] <- 35000
donate_2013[id == 445] <- 6000
donate_2013[id == 448] <- 500
donate_2013[id == 453] <- 900
donate_2013[id == 454] <- 32.40
donate_2013[id == 456] <- 19500
donate_2013[id == 457] <- 50
donate_2013[id == 458] <- 0
donate_2013[id == 459] <- 0
donate_2013[id == 461] <- 4536.31
donate_2013[id == 463] <- 22.82
donate_2013[id == 464] <- 20000
donate_2013[id == 465] <- 810.05
donate_2013[id == 466] <- 11500
donate_2013[id == 470] <- 129.23
donate_2013[id == 471] <- 8054.19
donate_2013[id == 472] <- 600
donate_2013[id == 473] <- 10000
donate_2013[id == 475] <- 0
donate_2013[id == 476] <- 486.03
donate_2013[id == 483] <- 4605.13
donate_2013[id == 493] <- 200000
donate_2013[id == 494] <- 0
donate_2013[id == 496] <- 0
donate_2013[id == 499] <- 0
donate_2013[id == 501] <- 16500
donate_2013[id == 502] <- 300
donate_2013[id == 503] <- 50
donate_2013[id == 505] <- 137.37
donate_2013[id == 511] <- 0
donate_2013[id == 512] <- 150
donate_2013[id == 515] <- 824.21
donate_2013[id == 516] <- 170
donate_2013[id == 518] <- 0
donate_2013[id == 521] <- 0
donate_2013[id == 522] <- 0
donate_2013[id == 524] <- 26250
donate_2013[id == 525] <- 267.64
donate_2013[id == 529] <- 1295.52
donate_2013[id == 534] <- 323.88
donate_2013[id == 535] <- 387.69
donate_2013[id == 537] <- 641.05
donate_2013[id == 538] <- 0
donate_2013[id == 543] <- 0
donate_2013[id == 545] <- 18.32
donate_2013[id == 546] <- 1000
donate_2013[id == 553] <- 6135.76
donate_2013[id == 549] <- 50
donate_2013[id == 551] <- 366.31
donate_2013[id == 555] <- 516.92
donate_2013[id == 562] <- 274.74
donate_2013[id == 563] <- 200
donate_2013[id == 566] <- 450
donate_2013[id == 567] <- 17.36
donate_2013[id == 571] <- 5000
donate_2013[id == 574] <- 100
donate_2013[id == 577] <- 1883
donate_2013[id == 579] <- 0
donate_2013[id == 580] <- 2000000
donate_2013[id == 581] <- 35000
donate_2013[id == 583] <- 40
donate_2013[id == 584] <- 12500
donate_2013[id == 585] <- 200
donate_2013[id == 586] <- 1360.29
donate_2013[id == 587] <- 0
donate_2013[id == 590] <- 0
donate_2013[id == 591] <- 0
donate_2013[id == 594] <- 3600
donate_2013[id == 595] <- 12000
donate_2013[id == 596] <- 200
donate_2013[id == 598] <- 100
donate_2013[id == 602] <- 100
donate_2013[id == 604] <- 35.35
donate_2013[id == 605] <- 0
donate_2013[id == 606] <- 22000
donate_2013[id == 610] <- 0
donate_2013[id == 614] <- 500
donate_2013[id == 615] <- 2500
donate_2013[id == 616] <- 5000
donate_2013[id == 618] <- 2000
donate_2013[id == 619] <- 0
donate_2013[id == 623] <- 0
donate_2013[id == 626] <- 1400
donate_2013[id == 630] <- 872.22
donate_2013[id == 629] <- 0
donate_2013[id == 632] <- 0
donate_2013[id == 634] <- 1000
donate_2013[id == 635] <- 0
donate_2013[id == 638] <- 660
donate_2013[id == 640] <- 0
donate_2013[id == 641] <- 500
donate_2013[id == 643] <- 0
donate_2013[id == 649] <- 275.57
donate_2013[id == 657] <- 900
donate_2013[id == 659] <- 400
donate_2013[id == 662] <- 500000
donate_2013[id == 664] <- 2000
donate_2013[id == 665] <- 20000
donate_2013[id == 669] <- 100
donate_2013[id == 671] <- 129.11
donate_2013[id == 672] <- 200
donate_2013[id == 673] <- 0
donate_2013[id == 677] <- 154.93
donate_2013[id == 678] <- 0
donate_2013[id == 680] <- 2000
donate_2013[id == 681] <- 0
donate_2013[id == 682] <- 5000
donate_2013[id == 683] <- 6.46
donate_2013[id == 685] <- 0
donate_2013[id == 686] <- 2800
donate_2013[id == 692] <- 100000
donate_2013[id == 695] <- 100
donate_2013[id == 696] <- 1067.20
donate_2013[id == 706] <- 10225
donate_2013[id == 707] <- 420
donate_2013[id == 708] <- 5100
donate_2013[id == 709] <- 0
donate_2013[id == 713] <- 0
donate_2013[id == 714] <- 8400
donate_2013[id == 716] <- 30
donate_2013[id == 718] <- 10000
donate_2013[id == 719] <- 2000
donate_2013[id == 720] <- 6000
donate_2013[id == 721] <- 600
donate_2013[id == 723] <- 0
donate_2013[id == 724] <- 242.98
donate_2013[id == 725] <- 0
donate_2013[id == 726] <- 500
donate_2013[id == 727] <- 100
donate_2013[id == 730] <- 0
donate_2013[id == 734] <- 350
donate_2013[id == 736] <- 50
donate_2013[id == 738] <- 1000
donate_2013[id == 739] <- 0
donate_2013[id == 740] <- 1829.97
donate_2013[id == 741] <- 100
donate_2013[id == 742] <- 100
donate_2013[id == 743] <- 0
donate_2013[id == 746] <- 0
donate_2013[id == 747] <- 6200
donate_2013[id == 751] <- 0
donate_2013[id == 752] <- 1000
donate_2013[id == 753] <- 10
donate_2013[id == 754] <- 20
donate_2013[id == 755] <- 6000
donate_2013[id == 759] <- 1600
donate_2013[id == 764] <- 0
donate_2013[id == 766] <- 0
donate_2013[id == 768] <- 770
donate_2013[id == 771] <- 2500
donate_2013[id == 773] <- 138.32
donate_2013[id == 776] <- 3664.10
donate_2013[id == 779] <- 1500
donate_2013[id == 781] <- 0
donate_2013[id == 782] <- 0
donate_2013[id == 785] <- 2000
donate_2013[id == 786] <- 500
donate_2013[id == 789] <- 7003.86
donate_2013[id == 790] <- 387.40
donate_2013[id == 791] <- 2000
donate_2013[id == 792] <- 300
donate_2013[id == 793] <- 809.70
donate_2013[id == 798] <- 40
donate_2013[id == 807] <- 500
donate_2013[id == 808] <- 0
donate_2013[id == 810] <- 91.28
donate_2013[id == 816] <- 5000
donate_2013[id == 817] <- 458.12
donate_2013[id == 818] <- 0
donate_2013[id == 821] <- 0
donate_2013[id == 823] <- 200
donate_2013[id == 824] <- 232.52
donate_2013[id == 825] <- 0
donate_2013[id == 830] <- 2500
donate_2013[id == 832] <- 650
donate_2013[id == 834] <- 4857.35
donate_2013[id == 835] <- 161.91
donate_2013[id == 836] <- 3238.23
donate_2013[id == 839] <- 809.62
donate_2013[id == 841] <- 40
donate_2013[id == 847] <- 5025
donate_2013[id == 848] <- 0
donate_2013[id == 851] <- 0
donate_2013[id == 852] <- 0
donate_2013[id == 857] <- 2500
donate_2013[id == 858] <- 250
donate_2013[id == 859] <- 500
donate_2013[id == 863] <- 0
donate_2013[id == 864] <- 50
donate_2013[id == 871] <- 129.18
donate_2013[id == 875] <- 5000
donate_2013[id == 876] <- 10000
donate_2013[id == 877] <- 0
donate_2013[id == 879] <- 0
donate_2013[id == 884] <- 4000
donate_2013[id == 887] <- 25000
donate_2013[id == 888] <- 2381.28
donate_2013[id == 889] <- 200
donate_2013[id == 890] <- 0
donate_2013[id == 892] <- 180
donate_2013[id == 896] <- 3100.30
donate_2013[id == 897] <- 30
donate_2013[id == 901] <- 50
donate_2013[id == 906] <- 3209.79
donate_2013[id == 912] <- 0
donate_2013[id == 914] <- 100
donate_2013[id == 915] <- 3237.57
donate_2013[id == 917] <- 0
donate_2013[id == 920] <- 1806.94
donate_2013[id == 921] <- 0
donate_2013[id == 925] <- 2700
donate_2013[id == 930] <- 0
donate_2013[id == 932] <- 456.29
donate_2013[id == 933] <- 0
donate_2013[id == 934] <- 4532.6
donate_2013[id == 939] <- 1000
donate_2013[id == 942] <- 1290.67
donate_2013[id == 943] <- 0
donate_2013[id == 946] <- 922.71
donate_2013[id == 948] <- 51.63
donate_2013[id == 951] <- 0
donate_2013[id == 952] <- 485.64
donate_2013[id == 958] <- 0
donate_2013[id == 960] <- 25
donate_2013[id == 965] <- 200
donate_2013[id == 967] <- 912.58
donate_2013[id == 971] <- 60000
donate_2013[id == 972] <- 0
donate_2013[id == 974] <- 0
donate_2013[id == 975] <- 100
donate_2013[id == 976] <- 3237.57
donate_2013[id == 978] <- 410.66
donate_2013[id == 981] <- 3080
donate_2013[id == 982] <- 400
donate_2013[id == 987] <- 2755.99
donate_2013[id == 994] <- 0
donate_2013[id == 997] <- 120
donate_2013[id == 999] <- 15000
donate_2013[id == 1001] <- 136.92
donate_2013[id == 1002] <- 0
donate_2013[id == 1007] <- 0
donate_2013[id == 1009] <- 24000
donate_2013[id == 1010] <- 0
donate_2013[id == 1011] <- 0
donate_2013[id == 1012] <- 350
donate_2013[id == 1016] <- 100
donate_2013[id == 1018] <- 100
donate_2013[id == 1025] <- 0
donate_2013[id == 1028] <- 1000
donate_2013[id == 1029] <- 0
donate_2013[id == 1034] <- 50
donate_2013[id == 1035] <- 100
donate_2013[id == 1037] <- 400
donate_2013[id == 1039] <- 0
donate_2013[id == 1044] <- 1500
donate_2013[id == 1054] <- 25
donate_2013[id == 1060] <- 25000
donate_2013[id == 1061] <- 14.09
donate_2013[id == 1062] <- 30
donate_2013[id == 1064] <- 0
donate_2013[id == 1067] <- 0
donate_2013[id == 1071] <- 809.72
donate_2013[id == 1072] <- 70
donate_2013[id == 1078] <- 1200
donate_2013[id == 1083] <- 710.25
donate_2013[id == 1086] <- 0
donate_2013[id == 1090] <- 19438.68
donate_2013[id == 1099] <- 150
donate_2013[id == 1101] <- 0
donate_2013[id == 1103] <- 200
donate_2013[id == 1105] <- 5000
donate_2013[id == 1106] <- 0
donate_2013[id == 1108] <- 450
donate_2013[id == 1109] <- 219.18
donate_2013[id == 1113] <- 3000
donate_2013[id == 1116] <- 1200
donate_2013[id == 1117] <- 0
donate_2013[id == 1120] <- 1400
donate_2013[id == 1121] <- 300
donate_2013[id == 1122] <- 100
donate_2013[id == 1124] <- 0
donate_2013[id == 1125] <- 20
donate_2013[id == 1127] <- 200
donate_2013[id == 1128] <- 8910
donate_2013[id == 1130] <- 242.91
donate_2013[id == 1131] <- 8000
donate_2013[id == 1145] <- 500
donate_2013[id == 1149] <- 200
donate_2013[id == 1151] <- 0
donate_2013[id == 1161] <- 0
donate_2013[id == 1162] <- 322.95
donate_2013[id == 1166] <- 300
donate_2013[id == 1167] <- 5000
donate_2013[id == 1169] <- 0
donate_2013[id == 1176] <- 300
donate_2013[id == 1178] <- 0
donate_2013[id == 1180] <- 3000
donate_2013[id == 1182] <- 32.39
donate_2013[id == 1184] <- 50
donate_2013[id == 1190] <- 1000
donate_2013[id == 1194] <- 0
donate_2013[id == 1196] <- 0
donate_2013[id == 1197] <- 0
donate_2013[id == 1198] <- 82.04
donate_2013[id == 1200] <- 0
donate_2013[id == 1206] <- 4000
donate_2013[id == 1207] <- 120
donate_2013[id == 1211] <- 200
donate_2013[id == 1212] <- 0
donate_2013[id == 1213] <- 91.87
donate_2013[id == 1214] <- 300
donate_2013[id == 1215] <- 1000
donate_2013[id == 1218] <- 465.24
donate_2013[id == 1219] <- 0
donate_2013[id == 1221] <- 485.64
donate_2013[id == 1222] <- 5000
donate_2013[id == 1230] <- 456.33
donate_2013[id == 1232] <- 0
donate_2013[id == 1235] <- 2.5
donate_2013[id == 1242] <- 6020
donate_2013[id == 1243] <- 7500
donate_2013[id == 1244] <- 600
donate_2013[id == 1246] <- 91.27
donate_2013[id == 1253] <- 129.23
donate_2013[id == 1256] <- 0
donate_2013[id == 1262] <- 2000
donate_2013[id == 1263] <- 0
donate_2013[id == 1272] <- 1000
donate_2013[id == 1274] <- 279.46
donate_2013[id == 1277] <- 60
donate_2013[id == 1288] <- 10
donate_2013[id == 1294] <- 1500
donate_2013[id == 1297] <- 2099.1
donate_2013[id == 1299] <- 1000
donate_2013[id == 1305] <- 30
donate_2013[id == 1318] <- 0
donate_2013[id == 1319] <- 0
donate_2013[id == 1320] <- 3237.57
donate_2013[id == 1323] <- 0
donate_2013[id == 1327] <- 0
donate_2013[id == 1328] <- 1200
donate_2013[id == 1331] <- 75000
donate_2013[id == 1332] <- 900
donate_2013[id == 1334] <- 27000
donate_2013[id == 1338] <- 0
donate_2013[id == 1339] <- 809.39
donate_2013[id == 1341] <- 1250
donate_2013[id == 1344] <- 0
donate_2013[id == 1346] <- 0
donate_2013[id == 1350] <- 0
donate_2013[id == 1359] <- 8.09
donate_2013[id == 1367] <- 0
donate_2013[id == 1368] <- 182.5
donate_2013[id == 1373] <- 0
donate_2013[id == 1377] <- 0
donate_2013[id == 1380] <- 0
donate_2013[id == 1384] <- 1200
donate_2013[id == 1386] <- 0
donate_2013[id == 1387] <- 1000
donate_2013[id == 1388] <- 30
donate_2013[id == 1391] <- 647.51
donate_2013[id == 1392] <- 120
donate_2013[id == 1394] <- 500
donate_2013[id == 1407] <- 300
donate_2013[id == 1410] <- 4000
donate_2013[id == 1411] <- 213.64
donate_2013[id == 1414] <- 300
donate_2013[id == 1416] <- 0
donate_2013[id == 1417] <- 0
donate_2013[id == 1422] <- 100
donate_2013[id == 1430] <- 5
donate_2013[id == 1432] <- 242.91
donate_2013[id == 1436] <- 232.44
donate_2013[id == 1438] <- 1601.97
donate_2013[id == 1439] <- 1068.12
donate_2013[id == 1442] <- 58751.90
donate_2013[id == 1443] <- 106.80
donate_2013[id == 1447] <- 53.40
donate_2013[id == 1454] <- 0
donate_2013[id == 1461] <- 15000
donate_2013[id == 1465] <- 0
donate_2013[id == 1470] <- 0
donate_2013[id == 1474] <- 0
donate_2013[id == 1475] <- 1000
donate_2013[id == 1479] <- 10000
donate_2013[id == 1481] <- 200
donate_2013[id == 1483] <- 200
donate_2013[id == 1488] <- 2000
donate_2013[id == 1494] <- 0
donate_2013[id == 1496] <- 13.74
donate_2013[id == 1500] <- 1500
donate_2013[id == 1502] <- 1538.47
donate_2013[id == 1504] <- 647.78
donate_2013[id == 1505] <- 400
donate_2013[id == 1512] <- 300
donate_2013[id == 1514] <- 50000
donate_2013[id == 1518] <- 75
donate_2013[id == 1522] <- 1200
donate_2013[id == 1523] <- 3600
donate_2013[id == 1526] <- 600
donate_2013[id == 1530] <- 18000
donate_2013[id == 1548] <- 0
donate_2013[id == 1555] <- 0
donate_2013[id == 1561] <- 900
donate_2013[id == 1567] <- 0
donate_2013[id == 1570] <- 0
donate_2013[id == 1571] <- 194.33
donate_2013[id == 1572] <- 639.34
donate_2013[id == 1575] <- 1000
donate_2013[id == 1577] <- 500
donate_2013[id == 1578] <- 1000
donate_2013[id == 1579] <- 800
donate_2013[id == 1580] <- 0
donate_2013[id == 1581] <- 50
donate_2013[id == 1586] <- 200
donate_2013[id == 1587] <- 0
donate_2013[id == 1592] <- 150
donate_2013[id == 1594] <- 323.12
donate_2013[id == 1595] <- 533.78
donate_2013[id == 1596] <- 2500
donate_2013[id == 1598] <- 10
donate_2013[id == 1601] <- 1295.38
donate_2013[id == 1602] <- 0
donate_2013[id == 1606] <- 30
donate_2013[id == 1607] <- 0
donate_2013[id == 1609] <- 0
donate_2013[id == 1610] <- 50
donate_2013[id == 1611] <- 3238.77
donate_2013[id == 1612] <- 0
donate_2013[id == 1614] <- 240000
donate_2013[id == 1615] <- 150
donate_2013[id == 1619] <- 300
donate_2013[id == 1620] <- 200
donate_2013[id == 1624] <- 12147.93
donate_2013[id == 1626] <- 20
donate_2013[id == 1628] <- 0
donate_2013[id == 1631] <- 5000
donate_2013[id == 1633] <- 4857.69
donate_2013[id == 1639] <- 1200
donate_2013[id == 1640] <- 4695.77
donate_2013[id == 1641] <- 3238.80
donate_2013[id == 1642] <- 1200
donate_2013[id == 1644] <- 32.39
donate_2013[id == 1646] <- 600
donate_2013[id == 1649] <- 12145.39
donate_2013[id == 1652] <- 1574.59
donate_2013[id == 1654] <- 30
donate_2013[id == 1655] <- 9714.69
donate_2013[id == 1657] <- 0
donate_2013[id == 1658] <- 1099.48
donate_2013[id == 1661] <- 32.39
donate_2013[id == 1663] <- 150
donate_2013[id == 1664] <- 1000
donate_2013[id == 1672] <- 1200
donate_2013[id == 1673] <- 323.85
donate_2013[id == 1675] <- 400
donate_2013[id == 1679] <- 300
donate_2013[id == 1683] <- 0
donate_2013[id == 1685] <- 6000
donate_2013[id == 1686] <- 3500
donate_2013[id == 1687] <- 0
donate_2013[id == 1689] <- 0
donate_2013[id == 1691] <- 0
donate_2013[id == 1693] <- 2008
donate_2013[id == 1695] <- 127500
donate_2013[id == 1697] <- 365.20
donate_2013[id == 1699] <- 1000
donate_2013[id == 1701] <- 0
donate_2013[id == 1704] <- 0
donate_2013[id == 1707] <- 20
donate_2013[id == 1708] <- 0
donate_2013[id == 1713] <- 13875.7
donate_2013[id == 1714] <- 258.26
donate_2013[id == 1725] <- 2429.09
donate_2013[id == 1729] <- 0
donate_2013[id == 1730] <- 0
donate_2013[id == 1732] <- 0
donate_2013[id == 1733] <- 388.96
donate_2013[id == 1734] <- 6500
donate_2013[id == 1735] <- 20
donate_2013[id == 1737] <- 150
donate_2013[id == 1739] <- 1000
donate_2013[id == 1740] <- 60
donate_2013[id == 1741] <- 100
donate_2013[id == 1742] <- 0
donate_2013[id == 1743] <- 324.14
donate_2013[id == 1744] <- 2000
donate_2013[id == 1749] <- 1619.80
donate_2013[id == 1754] <- 121.55
donate_2013[id == 1755] <- 0
donate_2013[id == 1760] <- 0
donate_2013[id == 1762] <- 10000
donate_2013[id == 1767] <- 0
donate_2013[id == 1769] <- 500
donate_2013[id == 1770] <- 16435.210
donate_2013[id == 1773] <- 150
donate_2013[id == 1777] <- 0
donate_2013[id == 1782] <- 8323.64
donate_2013[id == 1783] <- 6482.74
donate_2013[id == 1784] <- 5000
donate_2013[id == 1786] <- 100
donate_2013[id == 1787] <- 300
donate_2013[id == 1788] <- 1417.50
donate_2013[id == 1793] <- 810.86
donate_2013[id == 1801] <- 1500
donate_2013[id == 1804] <- 0
donate_2013[id == 1809] <- 809.70
donate_2013[id == 1813] <- 2582.85
donate_2013[id == 1814] <- 7287.26
donate_2013[id == 1826] <- 0
donate_2013[id == 1831] <- 1619.89
donate_2013[id == 1832] <- 11336.11
donate_2013[id == 1836] <- 0
donate_2013[id == 1837] <- 1200
donate_2013[id == 1848] <- 1619.89
donate_2013[id == 1853] <- 92.98
donate_2013[id == 1862] <- 647.96
donate_2013[id == 1864] <- 2570
donate_2013[id == 1869] <- 1943.27
donate_2013[id == 1872] <- 3500
donate_2013[id == 1889] <- 650
donate_2013[id == 1894] <- 1000

# Income
income_2013 <- rep(NA, 1856)
income_2013[id == 6] <- 0.00
income_2013[id == 11] <- 8000.00
income_2013[id == 13] <- 0.00
income_2013[id == 17] <- 8700.00
income_2013[id == 18] <- 9093.43
income_2013[id == 21] <- 0.00
income_2013[id == 24] <- 20000.00
income_2013[id == 27] <- 1800.00
income_2013[id == 30] <- 57000.00
income_2013[id == 31] <- 5000.00
income_2013[id == 32] <- 20000.00
income_2013[id == 35] <- 32000.00
income_2013[id == 36] <- 12500.00
income_2013[id == 37] <- 170000.00
income_2013[id == 38] <- 2445.09
income_2013[id == 39] <- 19562.82
income_2013[id == 42] <- 4500.00
income_2013[id == 45] <- 16259.70
income_2013[id == 47] <- 31000.00
income_2013[id == 49] <- 46000.00
income_2013[id == 51] <- 3189.25
income_2013[id == 52] <- 29000.00
income_2013[id == 53] <- 12000.00
income_2013[id == 54] <- 7000.00
income_2013[id == 55] <- 0.00
income_2013[id == 59] <- 95000.00
income_2013[id == 60] <- 8495.73
income_2013[id == 65] <- 21137.61
income_2013[id == 69] <- 0.00
income_2013[id == 71] <- 7500.00
income_2013[id == 72] <- 16568.07
income_2013[id == 78] <- 4402.59
income_2013[id == 79] <- 0.00
income_2013[id == 80] <- 0.00
income_2013[id == 82] <- 53657.01
income_2013[id == 83] <- 21565.00
income_2013[id == 84] <- 0.00
income_2013[id == 85] <- 122167.50
income_2013[id == 86] <- 10000.00
income_2013[id == 94] <- 9755.82
income_2013[id == 96] <- 31892.50
income_2013[id == 98] <- 0.00
income_2013[id == 99] <- 35865.17
income_2013[id == 104] <- 135000.00
income_2013[id == 106] <- 375000.00
income_2013[id == 108] <- 0.00
income_2013[id == 110] <- 0.00
income_2013[id == 111] <- 146000.00
income_2013[id == 116] <- 14633.73
income_2013[id == 118] <- 5000.00
income_2013[id == 119] <- 13007.76
income_2013[id == 120] <- 120000.00
income_2013[id == 121] <- 30872.00
income_2013[id == 122] <- 25000.00
income_2013[id == 126] <- 40000.00
income_2013[id == 130] <- 200000.00
income_2013[id == 131] <- 45000.00
income_2013[id == 132] <- 26500.00
income_2013[id == 133] <- 155000.00
income_2013[id == 135] <- 110000.00
income_2013[id == 137] <- 2000.00
income_2013[id == 138] <- 32578.00
income_2013[id == 140] <- 200000.00
income_2013[id == 144] <- 7000.00
income_2013[id == 145] <- 12555.54
income_2013[id == 146] <- 0.00
income_2013[id == 148] <- 5600.00
income_2013[id == 149] <- 22000.00
income_2013[id == 152] <- 48600.00
income_2013[id == 153] <- 2000.00
income_2013[id == 156] <- 21000.00
income_2013[id == 161] <- 8000.00
income_2013[id == 163] <- 30000.00
income_2013[id == 171] <- 3000.00
income_2013[id == 172] <- 5000.00
income_2013[id == 173] <- 140000.00
income_2013[id == 178] <- 0.00
income_2013[id == 179] <- 100000.00
income_2013[id == 180] <- 7000.00
income_2013[id == 183] <- 15458.26
income_2013[id == 191] <- 10000.00
income_2013[id == 192] <- 0.00
income_2013[id == 193] <- 30949.10
income_2013[id == 195] <- 30000.00
income_2013[id == 198] <- 95000.00
income_2013[id == 199] <- 12000.00
income_2013[id == 201] <- 0.00
income_2013[id == 203] <- 8500.00
income_2013[id == 204] <- 10000.00
income_2013[id == 207] <- 20460.00
income_2013[id == 212] <- 10000.00
income_2013[id == 213] <- 300000.00
income_2013[id == 217] <- 8000.00
income_2013[id == 219] <- 0.00
income_2013[id == 220] <- 200000.00
income_2013[id == 221] <- 800.00
income_2013[id == 222] <- 13000.00
income_2013[id == 223] <- 3500.00
income_2013[id == 225] <- 9000.00
income_2013[id == 226] <- 60000.00
income_2013[id == 228] <- 20000.00
income_2013[id == 230] <- 41000.00
income_2013[id == 233] <- 62719.65
income_2013[id == 236] <- 7000.00
income_2013[id == 241] <- 23822.45
income_2013[id == 247] <- 5000.00
income_2013[id == 248] <- 2000.00
income_2013[id == 249] <- 4000.00
income_2013[id == 252] <- 70000.00
income_2013[id == 255] <- 25000.00
income_2013[id == 256] <- 80000.00
income_2013[id == 257] <- 4000.00
income_2013[id == 261] <- 4000.00
income_2013[id == 265] <- 25000.00
income_2013[id == 271] <- 0.00
income_2013[id == 273] <- 145000.00
income_2013[id == 278] <- 275000.00
income_2013[id == 279] <- 33480.20
income_2013[id == 283] <- 75000.00
income_2013[id == 286] <- 65000.00
income_2013[id == 287] <- 0.00
income_2013[id == 290] <- 30000.00
income_2013[id == 291] <- 0.00
income_2013[id == 294] <- 80000.00
income_2013[id == 295] <- 10946.13
income_2013[id == 296] <- 12000.00
income_2013[id == 297] <- 27640.17
income_2013[id == 298] <- 56181.98
income_2013[id == 299] <- 40000.00
income_2013[id == 300] <- 2500.00
income_2013[id == 301] <- 14633.73
income_2013[id == 303] <- 65970.45
income_2013[id == 305] <- 16302.35
income_2013[id == 307] <- 13500.00
income_2013[id == 308] <- 200000.00
income_2013[id == 319] <- 0.00
income_2013[id == 320] <- 65000.00
income_2013[id == 321] <- 60000.00
income_2013[id == 323] <- 70000.00
income_2013[id == 325] <- 160.00
income_2013[id == 328] <- 145000.00
income_2013[id == 329] <- 14000.00
income_2013[id == 330] <- 13000.00
income_2013[id == 332] <- 2850.57
income_2013[id == 333] <- 17000.00
income_2013[id == 337] <- 16000.00
income_2013[id == 338] <- 2445.35
income_2013[id == 341] <- 12000.00
income_2013[id == 342] <- 10000.00
income_2013[id == 343] <- 5800.00
income_2013[id == 347] <- 0.00
income_2013[id == 350] <- 12000.00
income_2013[id == 351] <- 122000.00
income_2013[id == 355] <- 20000.00
income_2013[id == 356] <- 19295.47
income_2013[id == 361] <- 0.00
income_2013[id == 362] <- 14763.13
income_2013[id == 365] <- 1000.00
income_2013[id == 364] <- 75000.00
income_2013[id == 366] <- 0.00
income_2013[id == 367] <- 70000.00
income_2013[id == 368] <- 3243.10
income_2013[id == 369] <- 24000.00
income_2013[id == 370] <- 0.00
income_2013[id == 371] <- 76500.00
income_2013[id == 373] <- 188000.00
income_2013[id == 374] <- 95000.00
income_2013[id == 375] <- 0.00
income_2013[id == 379] <- 6000.00
income_2013[id == 382] <- 21000.00
income_2013[id == 383] <- 135000.00
income_2013[id == 385] <- 20000.00
income_2013[id == 387] <- 95000.00
income_2013[id == 391] <- 57000.00
income_2013[id == 393] <- 10000.00
income_2013[id == 394] <- 0.00
income_2013[id == 395] <- 4000.00
income_2013[id == 396] <- 4000.00
income_2013[id == 397] <- 25000.00
income_2013[id == 399] <- 8323.97
income_2013[id == 401] <- 30000.00
income_2013[id == 402] <- 15436.38
income_2013[id == 406] <- 116939.17
income_2013[id == 407] <- 36006.60
income_2013[id == 410] <- 6696.04
income_2013[id == 413] <- 11589.30
income_2013[id == 418] <- 11402.30
income_2013[id == 422] <- 1625.97
income_2013[id == 427] <- 18028.92
income_2013[id == 428] <- 5000.00
income_2013[id == 429] <- 55000.00
income_2013[id == 430] <- 13958.87
income_2013[id == 434] <- 11000.00
income_2013[id == 439] <- 50000.00
income_2013[id == 441] <- 960000.00
income_2013[id == 445] <- 100000.00
income_2013[id == 448] <- 50000.00
income_2013[id == 453] <- 60000.00
income_2013[id == 454] <- 0.00
income_2013[id == 456] <- 160000.00
income_2013[id == 457] <- 2000.00
income_2013[id == 458] <- 20000.00
income_2013[id == 459] <- 0.00
income_2013[id == 461] <- 58000.00
income_2013[id == 463] <- 3410.04
income_2013[id == 464] <- 50000.00
income_2013[id == 465] <- 4323.99
income_2013[id == 466] <- 30000.00
income_2013[id == 468] <- 10000.00
income_2013[id == 470] <- 2317.86
income_2013[id == 471] <- 18522.57
income_2013[id == 472] <- 8000.00
income_2013[id == 473] <- 127000.00
income_2013[id == 475] <- 50.00
income_2013[id == 476] <- 65223.60
income_2013[id == 483] <- 62743.10
income_2013[id == 494] <- 12000.00
income_2013[id == 496] <- 0.00
income_2013[id == 499] <- 0.00
income_2013[id == 501] <- 165000.00
income_2013[id == 502] <- 4500.00
income_2013[id == 503] <- 16000.00
income_2013[id == 505] <- 16799.91
income_2013[id == 511] <- 0.00
income_2013[id == 512] <- 13000.00
income_2013[id == 515] <- 16127.91
income_2013[id == 516] <- 6000.00
income_2013[id == 518] <- 0.00
income_2013[id == 521] <- 0.00
income_2013[id == 522] <- 200.00
income_2013[id == 524] <- 106000.00
income_2013[id == 525] <- 18773.42
income_2013[id == 529] <- 11728.08
income_2013[id == 534] <- 40764.75
income_2013[id == 535] <- 32500.00
income_2013[id == 537] <- 10751.94
income_2013[id == 538] <- 10000.00
income_2013[id == 543] <- 4471.72
income_2013[id == 545] <- 53703.00
income_2013[id == 546] <- 30000.00
income_2013[id == 553] <- 38258.99
income_2013[id == 549] <- 0.00
income_2013[id == 551] <- 0.00
income_2013[id == 555] <- 27043.38
income_2013[id == 562] <- 13425.75
income_2013[id == 563] <- 75000.00
income_2013[id == 566] <- 38527.78
income_2013[id == 567] <- 103645.74
income_2013[id == 571] <- 65000.00
income_2013[id == 574] <- 3000.00
income_2013[id == 577] <- 93460.00
income_2013[id == 579] <- 125000.00
income_2013[id == 581] <- 120000.00
income_2013[id == 583] <- 40000.00
income_2013[id == 584] <- 250000.00
income_2013[id == 585] <- 20000.00
income_2013[id == 586] <- 14633.73
income_2013[id == 587] <- 40560.00
income_2013[id == 590] <- 15600.00
income_2013[id == 591] <- 20000.00
income_2013[id == 594] <- 76000.00
income_2013[id == 595] <- 300000.00
income_2013[id == 596] <- 90000.00
income_2013[id == 598] <- 30000.00
income_2013[id == 604] <- 4545.43
income_2013[id == 605] <- 70000.00
income_2013[id == 606] <- 60000.00
income_2013[id == 614] <- 72000.00
income_2013[id == 615] <- 25000.00
income_2013[id == 616] <- 175000.00
income_2013[id == 619] <- 0.00
income_2013[id == 621] <- 20051.89
income_2013[id == 623] <- 0.00
income_2013[id == 626] <- 85000.00
income_2013[id == 629] <- 0.00
income_2013[id == 632] <- 0.00
income_2013[id == 634] <- 140000.00
income_2013[id == 635] <- 16000.00
income_2013[id == 638] <- 15000.00
income_2013[id == 640] <- 30000.00
income_2013[id == 641] <- 5000.00
income_2013[id == 643] <- 0.00
income_2013[id == 649] <- 26830.35
income_2013[id == 657] <- 54000.00
income_2013[id == 664] <- 10000.00
income_2013[id == 665] <- 250000.00
income_2013[id == 669] <- 3000.00
income_2013[id == 671] <- 11074.22
income_2013[id == 672] <- 0.00
income_2013[id == 677] <- 10299.52
income_2013[id == 678] <- 30000.00
income_2013[id == 680] <- 40000.00
income_2013[id == 681] <- 23178.60
income_2013[id == 682] <- 80000.00
income_2013[id == 683] <- 3089.86
income_2013[id == 685] <- 200.00
income_2013[id == 686] <- 33000.00
income_2013[id == 694] <- 70000.00
income_2013[id == 695] <- 53000.00
income_2013[id == 696] <- 127435.88
income_2013[id == 706] <- 87000.00
income_2013[id == 708] <- 30000.00
income_2013[id == 707] <- 75000.00
income_2013[id == 709] <- 10000.00
income_2013[id == 713] <- 10000.00
income_2013[id == 714] <- 13100.00
income_2013[id == 716] <- 40000.00
income_2013[id == 718] <- 100000.00
income_2013[id == 720] <- 60000.00
income_2013[id == 721] <- 20000.00
income_2013[id == 723] <- 20000.00
income_2013[id == 724] <- 40764.75
income_2013[id == 725] <- 1028.76
income_2013[id == 726] <- 5000.00
income_2013[id == 727] <- 1000.00
income_2013[id == 730] <- 3000.00
income_2013[id == 734] <- 30000.00
income_2013[id == 736] <- 500.00
income_2013[id == 738] <- 55000.00
income_2013[id == 739] <- 16000.00
income_2013[id == 740] <- 4930.29
income_2013[id == 741] <- 62000.00
income_2013[id == 742] <- 40000.00
income_2013[id == 743] <- 22000.00
income_2013[id == 746] <- 25000.00
income_2013[id == 747] <- 150000.00
income_2013[id == 748] <- 7000.00
income_2013[id == 751] <- 0.00
income_2013[id == 752] <- 20000.00
income_2013[id == 753] <- 50000.00
income_2013[id == 754] <- 0.00
income_2013[id == 755] <- 60000.00
income_2013[id == 759] <- 6000.00
income_2013[id == 764] <- 22000.00
income_2013[id == 766] <- 3000.00
income_2013[id == 768] <- 6355.93
income_2013[id == 770] <- 0.00
income_2013[id == 771] <- 20000.00
income_2013[id == 773] <- 108309.24
income_2013[id == 776] <- 26879.85
income_2013[id == 779] <- 23500.00
income_2013[id == 781] <- 70000.00
income_2013[id == 782] <- 32000.00
income_2013[id == 785] <- 200000.00
income_2013[id == 786] <- 100000.00
income_2013[id == 789] <- 82798.62
income_2013[id == 790] <- 15431.40
income_2013[id == 791] <- 20000.00
income_2013[id == 792] <- 0.00
income_2013[id == 793] <- 8144.50
income_2013[id == 798] <- 40.00
income_2013[id == 807] <- 2000.00
income_2013[id == 808] <- 4000.00
income_2013[id == 810] <- 7272.69
income_2013[id == 816] <- 108000.00
income_2013[id == 817] <- 19243.58
income_2013[id == 818] <- 8000.00
income_2013[id == 821] <- 144000.00
income_2013[id == 823] <- 11000.00
income_2013[id == 824] <- 514.98
income_2013[id == 830] <- 100000.00
income_2013[id == 832] <- 20000.00
income_2013[id == 834] <- 35771.34
income_2013[id == 835] <- 9755.82
income_2013[id == 836] <- 71745.96
income_2013[id == 839] <- 500.00
income_2013[id == 841] <- 6100.00
income_2013[id == 847] <- 126844.00
income_2013[id == 848] <- 33332.38
income_2013[id == 851] <- 1500.00
income_2013[id == 852] <- 0.00
income_2013[id == 857] <- 25000.00
income_2013[id == 858] <- 0.00
income_2013[id == 859] <- 4000.00
income_2013[id == 863] <- 60000.00
income_2013[id == 864] <- 0.00
income_2013[id == 871] <- 38633.40
income_2013[id == 875] <- 55000.00
income_2013[id == 877] <- 0.00
income_2013[id == 879] <- 0.00
income_2013[id == 884] <- 50000.00
income_2013[id == 887] <- 500000.00
income_2013[id == 888] <- 52807.95
income_2013[id == 889] <- 74544.47
income_2013[id == 890] <- 10000.00
income_2013[id == 892] <- 4000.00
income_2013[id == 896] <- 32192.50
income_2013[id == 897] <- 8000.00
income_2013[id == 901] <- 4500.00
income_2013[id == 906] <- 10000.00
income_2013[id == 912] <- 25000.00
income_2013[id == 914] <- 50000.00
income_2013[id == 915] <- 130077.60
income_2013[id == 917] <- 65000.00
income_2013[id == 920] <- 15452.40
income_2013[id == 921] <- 75000.00
income_2013[id == 925] <- 200000.00
income_2013[id == 930] <- 80000.00
income_2013[id == 933] <- 20000.00
income_2013[id == 934] <- 44678.17
income_2013[id == 939] <- 50000.00
income_2013[id == 942] <- 154314.00
income_2013[id == 943] <- 16800.00
income_2013[id == 946] <- 73300.50
income_2013[id == 948] <- 2833.12
income_2013[id == 951] <- 0.00
income_2013[id == 952] <- 40649.25
income_2013[id == 954] <- 2000.00
income_2013[id == 958] <- 9000.00
income_2013[id == 960] <- 8499.35
income_2013[id == 965] <- 0.00
income_2013[id == 966] <- 7000.00
income_2013[id == 967] <- 81817.81
income_2013[id == 971] <- 60000.00
income_2013[id == 972] <- 0.00
income_2013[id == 974] <- 9000.00
income_2013[id == 975] <- 30000.00
income_2013[id == 976] <- 97558.20
income_2013[id == 978] <- 10000.00
income_2013[id == 981] <- 78000.00
income_2013[id == 982] <- 70000.00
income_2013[id == 987] <- 134399.25
income_2013[id == 994] <- 0.00
income_2013[id == 997] <- 3800.00
income_2013[id == 999] <- 10000.00
income_2013[id == 1001] <- 8000.00
income_2013[id == 1003] <- 0.00
income_2013[id == 1007] <- 15000.00
income_2013[id == 1008] <- 30000.00
income_2013[id == 1009] <- 275000.00
income_2013[id == 1010] <- 1630.59
income_2013[id == 1011] <- 5000.00
income_2013[id == 1012] <- 3500.00
income_2013[id == 1018] <- 2085.00
income_2013[id == 1025] <- 80000.00
income_2013[id == 1028] <- 12000.00
income_2013[id == 1029] <- 20000.00
income_2013[id == 1034] <- 700.00
income_2013[id == 1035] <- 10000.00
income_2013[id == 1037] <- 40000.00
income_2013[id == 1039] <- 25000.00
income_2013[id == 1054] <- 33333.00
income_2013[id == 1060] <- 70000.00
income_2013[id == 1061] <- 13956.93
income_2013[id == 1064] <- 0.00
income_2013[id == 1067] <- 34000.00
income_2013[id == 1071] <- 81445.00
income_2013[id == 1072] <- 0.00
income_2013[id == 1083] <- 51497.60
income_2013[id == 1086] <- 12000.00
income_2013[id == 1090] <- 78187.20
income_2013[id == 1099] <- 6000.00
income_2013[id == 1101] <- 0.00
income_2013[id == 1103] <- 25000.00
income_2013[id == 1108] <- 25000.00
income_2013[id == 1109] <- 54298.40
income_2013[id == 1113] <- 40000.00
income_2013[id == 1116] <- 30000.00
income_2013[id == 1117] <- 90000.00
income_2013[id == 1120] <- 43500.00
income_2013[id == 1121] <- 100000.00
income_2013[id == 1122] <- 29000.00
income_2013[id == 1124] <- 0.00
income_2013[id == 1125] <- 3400.00
income_2013[id == 1127] <- 20000.00
income_2013[id == 1128] <- 119583.00
income_2013[id == 1130] <- 0.00
income_2013[id == 1131] <- 160000.00
income_2013[id == 1134] <- 6000.00
income_2013[id == 1145] <- 14000.00
income_2013[id == 1149] <- 23000.00
income_2013[id == 1151] <- 0.00
income_2013[id == 1161] <- 500.00
income_2013[id == 1162] <- 10623.53
income_2013[id == 1166] <- 30000.00
income_2013[id == 1167] <- 57000.00
income_2013[id == 1169] <- 0.00
income_2013[id == 1178] <- 0.00
income_2013[id == 1180] <- 20000.00
income_2013[id == 1182] <- 0.00
income_2013[id == 1184] <- 200.00
income_2013[id == 1190] <- 78000.00
income_2013[id == 1194] <- 10000.00
income_2013[id == 1195] <- 1400.00
income_2013[id == 1196] <- 80000.00
income_2013[id == 1198] <- 3242.20
income_2013[id == 1200] <- 0.00
income_2013[id == 1206] <- 45000.00
income_2013[id == 1207] <- 23000.00
income_2013[id == 1212] <- 34420.00
income_2013[id == 1213] <- 3580.20
income_2013[id == 1214] <- 0.00
income_2013[id == 1215] <- 15000.00
income_2013[id == 1219] <- 0.00
income_2013[id == 1221] <- 0.00
income_2013[id == 1222] <- 150000.00
income_2013[id == 1230] <- 72000.00
income_2013[id == 1232] <- 0.00
income_2013[id == 1235] <- 2000.00
income_2013[id == 1242] <- 163830.00
income_2013[id == 1243] <- 70000.00
income_2013[id == 1244] <- 25000.00
income_2013[id == 1253] <- 0.00
income_2013[id == 1256] <- 46294.20
income_2013[id == 1262] <- 5000.00
income_2013[id == 1272] <- 19722.00
income_2013[id == 1274] <- 20000.00
income_2013[id == 1277] <- 17562.26
income_2013[id == 1288] <- 6000.00
income_2013[id == 1294] <- 0.00
income_2013[id == 1297] <- 53000.00
income_2013[id == 1299] <- 87000.00
income_2013[id == 1305] <- 36509.00
income_2013[id == 1318] <- 0.00
income_2013[id == 1319] <- 0.00
income_2013[id == 1320] <- 0.00
income_2013[id == 1323] <- 117280.80
income_2013[id == 1327] <- 3800.00
income_2013[id == 1328] <- 11586.96
income_2013[id == 1331] <- 20000.00
income_2013[id == 1332] <- 250000.00
income_2013[id == 1334] <- 54000.00
income_2013[id == 1338] <- 101000.00
income_2013[id == 1339] <- 0.00
income_2013[id == 1341] <- 16302.35
income_2013[id == 1344] <- 2700.00
income_2013[id == 1346] <- 11000.00
income_2013[id == 1350] <- 0.00
income_2013[id == 1359] <- 0.00
income_2013[id == 1367] <- 16302.35
income_2013[id == 1368] <- 0.00
income_2013[id == 1373] <- 18000.00
income_2013[id == 1377] <- 110000.00
income_2013[id == 1380] <- 0.00
income_2013[id == 1384] <- 0.00
income_2013[id == 1386] <- 29700.00
income_2013[id == 1387] <- 0.00
income_2013[id == 1388] <- 24000.00
income_2013[id == 1391] <- 10000.00
income_2013[id == 1392] <- 13041.88
income_2013[id == 1394] <- 6500.00
income_2013[id == 1407] <- 90000.00
income_2013[id == 1411] <- 10000.00
income_2013[id == 1413] <- 31858.97
income_2013[id == 1414] <- 16000.00
income_2013[id == 1416] <- 15000.00
income_2013[id == 1417] <- 100000.00
income_2013[id == 1422] <- 4867.00
income_2013[id == 1430] <- 18000.00
income_2013[id == 1432] <- 3200.00
income_2013[id == 1436] <- 1630.59
income_2013[id == 1438] <- 8200.00
income_2013[id == 1439] <- 7441.58
income_2013[id == 1442] <- 19135.50
income_2013[id == 1447] <- 69100.42
income_2013[id == 1454] <- 10630.83
income_2013[id == 1461] <- 50000.00
income_2013[id == 1465] <- 70000.00
income_2013[id == 1470] <- 0.00
income_2013[id == 1475] <- 0.00
income_2013[id == 1479] <- 140000.00
income_2013[id == 1480] <- 60000.00
income_2013[id == 1481] <- 32000.00
income_2013[id == 1483] <- 20000.00
income_2013[id == 1488] <- 300.00
income_2013[id == 1496] <- 12000.00
income_2013[id == 1500] <- 44799.75
income_2013[id == 1502] <- 80000.00
income_2013[id == 1504] <- 18340.14
income_2013[id == 1505] <- 1931.55
income_2013[id == 1512] <- 45000.00
income_2013[id == 1518] <- 55000.00
income_2013[id == 1522] <- 0.00
income_2013[id == 1523] <- 13000.00
income_2013[id == 1526] <- 35000.00
income_2013[id == 1530] <- 17000.00
income_2013[id == 1548] <- 75000.00
income_2013[id == 1555] <- 0.00
income_2013[id == 1561] <- 0.00
income_2013[id == 1567] <- 31000.00
income_2013[id == 1570] <- 0.00
income_2013[id == 1571] <- 17885.67
income_2013[id == 1572] <- 1625.97
income_2013[id == 1575] <- 18641.53
income_2013[id == 1577] <- 60000.00
income_2013[id == 1578] <- 0.00
income_2013[id == 1579] <- 18000.00
income_2013[id == 1580] <- 2400.00
income_2013[id == 1581] <- 1117.58
income_2013[id == 1586] <- 2190.00
income_2013[id == 1587] <- 18000.00
income_2013[id == 1588] <- 0.00
income_2013[id == 1592] <- 24000.00
income_2013[id == 1594] <- 60000.00
income_2013[id == 1595] <- 35770.94
income_2013[id == 1596] <- 31861.68
income_2013[id == 1598] <- 41198.08
income_2013[id == 1601] <- 0.00
income_2013[id == 1602] <- 0.00
income_2013[id == 1604] <- 0.00
income_2013[id == 1607] <- 30000.00
income_2013[id == 1609] <- 0.00
income_2013[id == 1610] <- 24000.00
income_2013[id == 1612] <- 10.00
income_2013[id == 1614] <- 55000.00
income_2013[id == 1615] <- 480000.00
income_2013[id == 1619] <- 7000.00
income_2013[id == 1620] <- 300.00
income_2013[id == 1624] <- 3000.00
income_2013[id == 1626] <- 77756.26
income_2013[id == 1628] <- 0.00
income_2013[id == 1631] <- 75000.00
income_2013[id == 1633] <- 50000.00
income_2013[id == 1639] <- 77725.45
income_2013[id == 1640] <- 12000.00
income_2013[id == 1641] <- 55396.37
income_2013[id == 1642] <- 48907.05
income_2013[id == 1644] <- 12000.00
income_2013[id == 1646] <- 80000.00
income_2013[id == 1649] <- 46842.52
income_2013[id == 1652] <- 13382.15
income_2013[id == 1654] <- 10000.00
income_2013[id == 1655] <- 19567.08
income_2013[id == 1657] <- 25487.18
income_2013[id == 1658] <- 68023.80
income_2013[id == 1661] <- 3258.61
income_2013[id == 1663] <- 6000.00
income_2013[id == 1664] <- 2000.00
income_2013[id == 1668] <- 0.00
income_2013[id == 1672] <- 70000.00
income_2013[id == 1673] <- 87982.47
income_2013[id == 1683] <- 19091.43
income_2013[id == 1685] <- 95000.00
income_2013[id == 1686] <- 36000.00
income_2013[id == 1687] <- 0.00
income_2013[id == 1689] <- 6000.00
income_2013[id == 1691] <- 0.00
income_2013[id == 1693] <- 19096.20
income_2013[id == 1697] <- 72747.44
income_2013[id == 1699] <- 40000.00
income_2013[id == 1701] <- 10000.00
income_2013[id == 1704] <- 0.00
income_2013[id == 1707] <- 0.00
income_2013[id == 1708] <- 25755.30
income_2013[id == 1713] <- 106308.34
income_2013[id == 1714] <- 70827.90
income_2013[id == 1725] <- 22828.26
income_2013[id == 1729] <- 4000.00
income_2013[id == 1730] <- 0.00
income_2013[id == 1732] <- 42000.00
income_2013[id == 1733] <- 16302.35
income_2013[id == 1734] <- 95000.00
income_2013[id == 1735] <- 6000.00
income_2013[id == 1737] <- 1500.00
income_2013[id == 1739] <- 52000.00
income_2013[id == 1740] <- 24000.00
income_2013[id == 1741] <- 10000.00
income_2013[id == 1742] <- 0.00
income_2013[id == 1743] <- 88032.69
income_2013[id == 1744] <- 100000.00
income_2013[id == 1749] <- 16302.35
income_2013[id == 1754] <- 13034.44
income_2013[id == 1755] <- 8000.00
income_2013[id == 1760] <- 1000.00
income_2013[id == 1762] <- 45000.00
income_2013[id == 1767] <- 0.00
income_2013[id == 1769] <- 2000.00
income_2013[id == 1770] <- 1640003.00
income_2013[id == 1773] <- 42000.00
income_2013[id == 1777] <- 3000.00
income_2013[id == 1782] <- 80739.02
income_2013[id == 1783] <- 130418.80
income_2013[id == 1784] <- 30000.00
income_2013[id == 1786] <- 40000.00
income_2013[id == 1787] <- 1500.00
income_2013[id == 1788] <- 9201.00
income_2013[id == 1793] <- 18553.18
income_2013[id == 1796] <- 25000.00
income_2013[id == 1801] <- 80000.00
income_2013[id == 1804] <- 0.00
income_2013[id == 1809] <- 4886.70
income_2013[id == 1813] <- 23180.04
income_2013[id == 1814] <- 73376.55
income_2013[id == 1826] <- 18.00
income_2013[id == 1831] <- 0.00
income_2013[id == 1832] <- 57070.65
income_2013[id == 1836] <- 130000.00
income_2013[id == 1837] <- 13000.00
income_2013[id == 1847] <- 0.00
income_2013[id == 1848] <- 8152.95
income_2013[id == 1853] <- 3219.41
income_2013[id == 1862] <- 32611.80
income_2013[id == 1864] <- 25700.00
income_2013[id == 1869] <- 70100.11
income_2013[id == 1871] <- 27000.00
income_2013[id == 1872] <- 18186.86
income_2013[id == 1889] <- 12000.00
income_2013[id == 1894] <- 0.00

# Percent income donated for nonstudents
p_inc_donate = as.numeric(donate_2013 / income_2013)*100
p_inc_donate[p_inc_donate == Inf] <- NA                     # Throw out people who donate despite having no income
p_inc_donate_ns = p_inc_donate[student == "Yes"]


# Referral URL
referrer = rep(NA, 1856)
referrerfeed <- sapply(strsplit(imdata$Referrer.URL, "\\?"), "[", 2)
referrer[referrerfeed == 's=9'] <- 'EAFB'
referrer[referrerfeed == 's=14'] <- 'LW'
referrer[referrerfeed == 's=18'] <- 'OtherFB'
referrer[referrerfeed == 's=19'] <- 'Special'
referrer[referrerfeed == 'rockstar'] <- 'Rockstar'
referrer[referrerfeed == 'eah-profiles'] <- 'EA Profiles'
referrer[referrerfeed == 'p'] <- 'Peter'
referrer[substring(referrerfeed, 1, 1) == 't'] <- 'Tom'



# In the Random Sample?
in.sample = rep(FALSE, 1856)
in.sample[id == 1606 | id == 1572 | id == 144 | id == 245 | id == 374 | id == 1683 | id == 1612 | id == 1580 | id == 1640 | id == 189 | id == 1575 | id == 163 | id == 1564 | id == 1611 | id == 207 | id == 1577 | id == 1607 | id == 1568 | id == 1630 | id == 1658 | id == 1598 | id == 1561 | id == 1596 | id == 1614 | id == 1615 | id == 252 | id == 1592 | id == 1054 | id == 1570 | id == 1639 | id == 1338] <- TRUE 


## Demographics
heardEA = imdata$Have.you.ever.heard.of.the.term..Effective.Altruism..or..EA.. 
table(heardEA)
length(p_inc_donate[p_inc_donate >= 80 & !is.na(p_inc_donate)])
describeEA = imdata$Could.you..however.loosely..be.described.as..an.EA..
table(describeEA)
table(heardEA, describeEA)
gender = imdata$Your.gender
table(gender)
numeric_ages <- as.numeric(age[!is.na(age) & age != ""])
median(numeric_ages[!is.na(numeric_ages)])
mean(numeric_ages[!is.na(numeric_ages)])
sd(numeric_ages[!is.na(numeric_ages)])
location = imdata$In.which.country.do.you.live.
sort(table(location))
sublocation = imdata$In.which.city.do.you.live.
sort(table(sublocation))
religion = imdata$Your.religious.beliefs
sort(table(religion))
table(student)

## Descriptive Statistics
table(metaethics)

table(poverty)
table(environmentalism)
table(animals)
table(rationality)
table(politics)
table(ai)
table(xrisk)
table(farfuture)
table(prioritization)
table(metacharity)
table(causeother)

table(poverty[describeEA == "Yes"])
table(environmentalism[describeEA == "Yes"])
table(animals[describeEA == "Yes"])
table(rationality[describeEA == "Yes"])
table(politics[describeEA == "Yes"])
table(ai[describeEA == "Yes"])
table(xrisk[describeEA == "Yes"])
table(farfuture[describeEA == "Yes"])
table(prioritization[describeEA == "Yes"])
table(metacharity[describeEA == "Yes"])
table(causeother[describeEA == "Yes"])

table(diet)
table(diet2)

table(group)
table(friendcount)
table(student)

table(career)

table(factors_contact)
table(factors_80K)
table(factors_TLYCS)
table(factors_LW)
table(factors_GWWC)
table(factors_givewell)
table(factors_friends)
table(factors_online)
table(factors_chapter)

table(referrer)

## Descriptive Stats for 2013 Donations
sum(!is.na(donate_2013))                    # Number of records
mean(donate_2013[describeEA == "Yes"], na.rm=T)                  # Mean
median(donate_2013[describeEA == "Yes"], na.rm=T)                # Median
median(donate_2013[describeEA == "No"], na.rm=T)                # Median
median(donate_2013[student == "No" & describeEA == "Yes"], na.rm=T)                # Non-student Median
median(donate_2013[student == "Yes" & describeEA == "Yes"], na.rm=T)                # Student Median
median(donate_2013[student == "No" & describeEA == "Yes" & (career == "ETG" || career == "ETGHybrid")], na.rm=T)                # Student Median
sd(donate_2013[describeEA == "Yes"], na.rm=T)                    # SD
quantile(donate_2013[describeEA == "Yes"], na.rm=T, probs=seq(0.1,1,len=10))  # Deciles
quantile(donate_2013[describeEA == "Yes"], na.rm=T, probs=seq(0.91,1,len=10))  # 0.9-1 Deciles 
sum(donate_2013[!is.na(donate_2013) & describeEA == "Yes"])

median(p_inc_donate[describeEA == "Yes"], na.rm=T)
mean(p_inc_donate[describeEA == "Yes"], na.rm=T)
median(p_inc_donate[student == "No" & describeEA == "Yes"], na.rm=T)
median(p_inc_donate[student == "No" & describeEA == "No"], na.rm=T)

length(p_inc_donate[!is.na(p_inc_donate) & describeEA == "Yes" & income_2013 >= 10000])
length(p_inc_donate[p_inc_donate >= 1 & !is.na(p_inc_donate) & describeEA == "Yes" & income_2013 >= 10000])
length(p_inc_donate[p_inc_donate >= 2 & !is.na(p_inc_donate) & describeEA == "Yes" & income_2013 >= 10000])
length(p_inc_donate[p_inc_donate >= 3 & !is.na(p_inc_donate) & describeEA == "Yes" & income_2013 >= 10000])
length(p_inc_donate[p_inc_donate >= 5 & !is.na(p_inc_donate) & describeEA == "Yes" & income_2013 >= 10000])
length(p_inc_donate[p_inc_donate >= 10 & !is.na(p_inc_donate) & describeEA == "Yes" & income_2013 >= 10000])
length(p_inc_donate[p_inc_donate >= 15 & !is.na(p_inc_donate) & describeEA == "Yes" & income_2013 >= 10000])
length(p_inc_donate[p_inc_donate >= 20 & !is.na(p_inc_donate) & describeEA == "Yes" & income_2013 >= 10000])
length(p_inc_donate[p_inc_donate >= 30 & !is.na(p_inc_donate) & describeEA == "Yes" & income_2013 >= 10000])
length(p_inc_donate[p_inc_donate >= 40 & !is.na(p_inc_donate) & describeEA == "Yes" & income_2013 >= 10000])
length(p_inc_donate[p_inc_donate >= 50 & !is.na(p_inc_donate) & describeEA == "Yes" & income_2013 >= 10000])
length(p_inc_donate[p_inc_donate >= 60 & !is.na(p_inc_donate) & describeEA == "Yes" & income_2013 >= 10000])
length(p_inc_donate[p_inc_donate >= 70 & !is.na(p_inc_donate) & describeEA == "Yes" & income_2013 >= 10000])
length(p_inc_donate[p_inc_donate >= 80 & !is.na(p_inc_donate) & describeEA == "Yes" & income_2013 >= 10000])
length(p_inc_donate[p_inc_donate >= 90 & !is.na(p_inc_donate) & describeEA == "Yes" & income_2013 >= 10000]) 
