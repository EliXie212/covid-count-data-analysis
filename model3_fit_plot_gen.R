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

get_ratio <- function(data){
  data.diff = diff(data)
  return(data.diff / (data[1:length(data)-1]+1e-8))
}


covid.ratio = get_ratio(covid)
covid.time.ratio = covid.time[2:length(covid.time)]

auto.arima(covid.ratio)

png(filename="figures/model3_s.png")
model.ratio.sarima = sarima(covid.ratio,p=2,d=1,q=0,P=0,D=0,Q=0,S=0)

model.ratio.sarima$AIC
model.ratio.sarima$BIC
model.ratio.sarima$AICc


model.ratio.sarima.a = arima(x = covid.ratio,
                              order = c(1, 1, 1),
                              seasonal = list(order = c(0, 0, 0),
                              period = 0))


png(filename="figures/model3_pacf.png")
pacf(model.ratio.sarima.a$residuals,
     main="PACF for SARIMA with Daily Ratio of Increase")


model.ratio.sarima.acf = ARMAacf(ar=model.ratio.sarima$fit$model$theta,
                                ma=model.ratio.sarima$fit$model$phi,
                                lag.max=60)
model.ratio.sarima.pacf = ARMAacf(ar=model.ratio.sarima$fit$model$theta,
                                  ma=model.ratio.sarima$fit$model$phi,
                                  lag.max=60,
                                  pacf=TRUE)


png(filename="figures/model3_acf_c.png")
acf(covid.ratio, lag.max=60,
    main="Theoretical ACF vs Empirical ACF")
points(0:60, model.ratio.sarima.acf, col=2)


png(filename="figures/model3_pacf_c.png")
pacf(covid.ratio, lag.max = 60,
     main="Theoretical PACF vs Empirical PACF")
points(1:60, model.ratio.sarima.pacf, col=2)


sarima_ratio_pred = sarima.for(covid.ratio,p=1,d=1,q=1,P=0,D=0,Q=0,S=0,
                                n.ahead=10)
