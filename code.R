#use data from excellent paper
#http://media.pimco.com/Documents/PIMCO_Quantitative_Research_Active_Share_Tracking_Error_Sapra_Hun.pdf
#for plotting in R

load("paperData.RData")

#activeTracking <- data.frame(
#  numStocks = factor(c(25,50,100,500))
#  ,matrix(
#    c(NA,na.omit(
#      as.numeric(
#        readClipboard()
#      )
#    ))
#    , ncol = 11
#    , byrow = T
#  )[-1,-1]
#)
#colnames(activeTracking)[-1] <- seq(0.1,1,0.1)


require(reshape2)
require(ggplot2)

#activeTracking.melt <- melt(
#  activeTracking
#  , id.vars = 1
#  , value.name = "TrkError"
#  , variable.name = "ActiveShare"
#)

ggplot(
  data = activeTracking.melt
  ,aes(y=TrkError,x=ActiveShare,group=numStocks,colour=numStocks)) +
  geom_line() + theme_bw() + geom_point()


require(rCharts)
d1 <- dPlot(
  TrkError ~ ActiveShare,
  groups = c("ActiveShare","numStocks"),
  data = activeTracking.melt,
  type = 'line',
  xAxis = list(type = "addMeasureAxis"),
  yAxis = list(outputFormat = ".2f")
)
d1

n1 <- nPlot(
  TrkError ~ ActiveShare,
  group = "numStocks",
  data = activeTracking.melt,
  type = 'lineChart'
)
n1$chart ( useInteractiveGuideline = T )
n1$publish(description = "rCharts+nvd3 | PIMCO Active Share Research")
