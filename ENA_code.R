wdir <- "~/Desktop/ENA/code"
ddir <- file.path(wdir, "data")

if (!dir.exists(wdir)){
  stop("failed")
}

if (!dir.exists(ddir)){
  dir.create(ddir)
  message('dir created')
}


test_data <- file.path(ddir, 'rs.data')
if (!file.exists(test_data)){
  download.file("https://gitlab.com/epistemic-analytics/qe-packages/rENA/-/raw/main/data/RS.data.rda?ref_type=heads&inline=false", test_data)
  message('test data downloaded')
}

tidy_table <- tibble(RS.data)

# install.packages("rENA")
# install.packages("rENA", repos = c("https://rena.qe-libs.org/cran/", "https://cran.rstudio.org"))
library("rENA")
library("tidyverse")

node_names <- tidy_table %>%
  select(where(~ is.numeric(.) && all(na.omit(unique(.)) %in% c(0, 1)))) %>%
  colnames() 

codes_df <- RS.data[, node_names]

unit <- tidy_table %>%
  select("UserName", "Condition") %>%
  colnames()

unit_of_analysis <- RS.data[, unit]





accum <- ena.accumulate.data(
  units = unit_of_analysis, # units of group, unit of analysis
  conversation = unit_of_analysis, # what conversation is under the same context and we should analyse together
  codes = codes_df, 
  model = "EndPoint", #SeparateTrajectory, AccumulatedTrajectory, Endpoint
  window.size.back = 4, #track back how many sentences 
  as.list = FALSE
)

set <- ena.make.set(enadata = accum) # for ploting

first.game <- set$meta.data$Condition == "FirstGame"
first.game.points <- set$points[first.game,]

### Subset rotated points and plot Condition 2 Group Mean
second.game <- set$meta.data$Condition == "SecondGame"
second.game.points <- set$points[second.game,]



