wdir <- "~/Desktop/ENA/code"
ddir <- file.path(wdir, "data")

if (!dir.exists(wdir)){
  stop("failed")
}

if (!dir.exists(ddir)){
  dir.create(ddir)
  message('dir created')
}


install.packages("rENA")
install.packages("rENA", repos = c("https://rena.qe-libs.org/cran/", "https://cran.rstudio.org"))
library("rENA")
library("tidyverse")

codeNames <- c("Claim", "Counterclaim", "Evidence", "Lead", "Position", "Rebuttal")

# connect to mongo
install.packages("mongolite")
library(mongolite)

mongo_url <- "mongodb://localhost:27017"
con <- mongo(
  collection = "w8_for_ENA",
  db = "testing",
  url = mongo_url
)

df_seg_r <- con$find()
nrow(df_seg_r)
table(df_seg_r$discourse_type, useNA = "ifany")

# con$disconnect()


#ENA

accum <- ena.accumulate.data(
  units = df_seg_r['segment_id'],
  conversation = df_seg_r['student_id'],
  codes = df_seg_r[, codeNames],
  model = "EndPoint",
  window.size.back = 1,
  as.list = FALSE
)

set <- ena.make.set(enadata = accum) # for ploting

plot_overlay <- ena.plot(set)

names(set$networks)


print(plot_overlay)




