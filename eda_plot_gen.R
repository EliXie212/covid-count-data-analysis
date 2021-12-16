library(astsa)
library(forecast)
library(dplyr)
library(graphics)
library(TSA)

## Import Data
covid = read.csv("source_data/covid.csv")
covid.time = unlist(covid['Day'])
covid.time = seq(covid.time[1], covid.time[length(covid.time)])
covid = as.ts(covid['Count'])


## Daily Count
png(filename="figures/eda.png")
plot.ts(covid,
        main="Daily Counts Day 1 to Day 66",
        xlab="Day",
        ylab="Counts",
        col="blue")

## Log EDA
## Calculate log
covid.log = log(covid)

png(filename="figures/eda_log.png")
plot.ts(covid,
        main="Daily Counts Day 1 to Day 66",
        xlab="Day",
        ylab="Counts",
        col="blue")

png(filename="figures/eda_ratio.png")
covid.log.diff = diff(covid.log, differences = 1)
plot(covid.log.diff,
      main="Daily Ratio of Increase Day 2 to Day 66",
      xlab="Day",
      ylab="Raio of increase",
      col="blue")

png(filename="figures/eda_diff2.png")
covid.log.diff.2 = diff(covid.log, differences = 2)
plot(covid.log.diff.2,
        main="Log Daily Counts After Second Order Difference",
        xlab="Day",
        ylab="Log Counts",
        col="blue")

png(filename="figures/eda_diff2_acf.png")
acf(covid.log.diff.2,
        main="ACF for Log Daily Counts After Second Differencing")

png(filename="figures/eda_diff2_pacf.png")
pacf(covid.log.diff.2,
      main="PACF for Log Daily Counts After Second Differencing")



## Ratio EDA
## calculate Ratio
get_ratio <- function(data){
  data.diff = diff(data)
  return(data.diff / (data[1:length(data)-1]+1e-8))
}


covid.ratio = get_ratio(covid)


png(filename="figures/eda_ratio.png")
plot.ts(covid.ratio,
        main="Daily Ratio Plot",
        xlab="Day",
        ylab="Daily ratio increase",
        col="blue")


png(filename="figures/eda_diff2_ratio.png")
covid.ratio.diff.2 = diff(covid.ratio, differences = 2)
plot.ts(covid.ratio.diff.2,
        main="Daily Ratio of Increase After First Order Differencing",
        xlab="Day",
        ylab="Daily Ratio Increase",
        col="blue")


png(filename="figures/eda_diff2_ratio_acf.png")
acf(covid.ratio.diff.2,
        main="ACF for Daily Ratio Increase After First Order Differencing")


png(filename="figures/eda_diff2_ratio_pacf.png")
pacf(covid.ratio.diff.2,
        main="PACF for Daily Ratio Increase After First Order Differencing")
