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
covid.log = log(covid)

## Use data only after day 35
covid.log.35 = covid.log[35: length(covid.log)]

png(filename="figures/eda_35.png")
plot.ts(covid.log.35,
        main="Log Day Counts Day 35 to 66",
        xlab="Day",
        ylab="Counts",
        col="blue")

auto.arima(covid.log.35)


png(filename="figures/model2_s.png")
model.log.sarima.35 = sarima(covid.log.35,p=0,d=1,q=0,P=0,D=0,Q=0,S=0)

model.log.sarima.35$AIC
model.log.sarima.35$BIC
model.log.sarima.35$AICc

model.log.sarima.35.a = arima(x = covid.log.35,
                              order = c(0, 1, 0),
                              seasonal = list(order = c(0, 0, 0),
                              period = 0))

png(filename="figures/model2_pacf.png")
pacf(model.log.sarima.35.a$residuals,
        main="PACF SARIMA On Log Counts After Day 35")


model.log.sarima.35.acf = ARMAacf(ar=0, ma=0, lag.max=20)
model.log.sarima.35.pacf = ARMAacf(ar=0, ma=0, lag.max=20, pacf=TRUE)


png(filename="figures/model2_acf_c.png")
acf(diff(covid.log.35), lag.max=20, main="Theoretical ACF VS Empircal ACF")
points(1:21, model.log.sarima.35.acf, col=2)


png(filename="figures/model2_pacf_c.png")
pacf(diff(covid.log.35), lag.max=20)
points(1:20, model.log.sarima.35.pacf, col=2,
        main="Theoretical PACF VS Empirical PACF")


sarima_pred.35 = sarima.for(covid.log.35,p=0,d=1,q=0,P=0,D=0,Q=0,S=0,
                            n.ahead=10)
