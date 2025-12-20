wdir <- "~/Desktop/ENA/code"
ddir <- file.path(wdir, "data")

if (!dir.exists(wdir)){
  stop("failed")
}

if (!dir.exists(ddir)){
  dir.create(ddir)
  message('dir created')
}




# install.packages("rENA")
# install.packages("rENA", repos = c("https://rena.qe-libs.org/cran/", "https://cran.rstudio.org"))
library("rENA")
library("tidyverse")

PhcodeNames <- c(
  "Definition","Claim","Reason","Inference","Example","Counterexample",
  "Distinction","Implication","Evaluation","Assumption","Intuition","FormalStructure"
)

data_path <- file.path(ddir, 'RS.data.ph.rds')
data <- readRDS(test_data)


accum <- ena.accumulate.data(
  units = data[,c("Condition","UserName")], # units of group, unit of analysis
  conversation = data[,c("Condition","GroupName")], # what conversation is under the same context and we should analyse together
  metadata = data[,c("GroupName")],
  codes = data[,PhcodeNames], 
  model = "EndPoint", #SeparateTrajectory, AccumulatedTrajectory, Endpoint
  window.size.back = 4, #track back how many sentences 
  as.list = FALSE
)

set <- ena.make.set(enadata = accum) # for ploting

humanities <- set$meta.data$Condition == "Humanities"
humanities.points <- set$points[humanities,]

### Subset rotated points and plot Condition 2 Group Mean
stem <- set$meta.data$Condition == "STEM"
stem.points <- set$points[stem,]


ena.conversations(set = set,
  units = c("FirstGame.steven z"), units.by=c("Condition","UserName"),
  conversation.by = c("Condition","GroupName"),
  codes=codeNames,
  window = 4
)


humanities.lineweights = set$line.weights[humanities,]
humanities.mean = colMeans(humanities.lineweights)

stem.lineweights = set$line.weights[stem,]
stem.mean = colMeans(stem.lineweights)

subtracted.network = humanities.mean - stem.mean


plot1 = ena.plot(set)
plot1 = ena.plot.network(plot1, network = subtracted.network)

#plot means only
plot2 = ena.plot(set)
plot2 = ena.plot.group(plot2, stem.points, labels = "STEM", colors  = "blue", confidence.interval = "box")
plot2 = ena.plot.group(plot2, humanities.points, labels = "Humanities", colors = "red", confidence.interval = "box")

#plot both
plot3 = ena.plot(set)
plot3 = ena.plot.network(plot3, network = subtracted.network)
plot3 = ena.plot.group(plot3, humanities.points, labels = "Humanities", colors = "red", confidence.interval = "box")
plot3 = ena.plot.group(plot3, stem.points, labels = "STEM", colors  = "blue", confidence.interval = "box")

dim.by.activity = cbind(
 set$points.rotated[,1],
 set$enadata$trajectories$step$ActivityNumber*.8/14-.4  #scale down to dimension 1
) # for visualisation, show the 'stanza' on the map 
#第二個數字14：你有幾段文字，但其實應該看其實有幾個項目 N <- max(ActivityNumber)
# *8 乘以多少 是這條線的高度
# 上下留多少空間 0.4


plot = ena.plot.trajectory(
 plot,
 points = dim.by.activity,
 names = unique(set$enadata$units$UserName),
 by = set$enadata$units$UserName
)

print(plot)



#Trajectories

accum_tra = ena.accumulate.data(
  units = data[,c("UserName","Condition")],
  conversation = data[,c("Condition","GroupName")], # GroupName here has been used to 
  # metadata = RS.data[,c("CONFIDENCE.Change","CONFIDENCE.Pre","CONFIDENCE.Post","C.Change")], 
# Different metadata variables were retained across the endpoint and trajectory models to support their distinct analytic purposes.”

  codes = data[,PhcodeNames],
  window.size.back = 4,
  model = "A" 
# Trajectories
)

set_tra = ena.make.set(accum_tra)

humanities <- set_tra$meta.data$Condition == "Humanities"
stem       <- set_tra$meta.data$Condition == "STEM"

humanities.mean <- colMeans(set_tra$line.weights[humanities, , drop = FALSE])
stem.mean       <- colMeans(set_tra$line.weights[stem, , drop = FALSE])

subtracted.network <- humanities.mean - stem.mean



plot = ena.plot(set_tra)
plot = ena.plot.network(plot, network = subtracted.network, legend.name="Network", legend.include.edges = T)

dim.by.activity = cbind(
 set_tra$points.rotated[,1],
 set_tra$enadata$trajectories$step$ActivityNumber*.8/14-.4  #scale down to dimension 1
)

print(plot)


# The positive figure is Humanities and negative is STEM, because [humanities.mean - stem.mean]
sort(subtracted.network, decreasing = TRUE)[1:10]
sort(subtracted.network, decreasing = FALSE)[1:10]





