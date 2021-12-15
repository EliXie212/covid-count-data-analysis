
library(astsa)
library(forecast)
library(dplyr)
library(graphics)
library(TSA)

covid = read.csv("source_data/covid.csv")
covid.time = unlist(covid['Day'])
covid.time = seq(covid.time[1], covid.time[length(covid.time)])
covid = as.ts(covid['Count'])
covid.log = log(covid)

log_pred <- function(log.pred) {
  return (exp(log.pred))
}


ratio_pred <- function(x_last, ratio.pred) {
  pred = 0
  base = x_last

  for (ratio in ratio.pred){
    base = base*(1+ratio)
    pred = c(pred, base)
  }

  return(pred[2:length(pred)])
}


covid.35 = window(covid, start=35)
covid.log.35 = covid.log[35: length(covid.log)]

png(filename="figures/final_pred_r.png")
final_log_pred = sarima.for(covid.log.35, n.ahead=10, p=0,d=1,q=0,P=0,D=0,Q=0,S=0)$pred
final_pred = log_pred(final_log_pred)


png(filename="figures/final_pred.png")
plot.ts(covid,
        main="Original Data And Predication for the Next 10 days",
        xlab="Day",
        ylab="Count",
        col="blue",
        xlim=c(1, 77),
        ylim=c(1, 1e6))
points(67:76, final_pred, col=3)


final_pred
