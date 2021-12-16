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

auto.arima(covid.log)

png(filename="figures/model1_s.png")
model.sim.sarima = sarima(covid.log,p=1,d=2,q=1,P=0,D=0,Q=0,S=0)


model.sim.sarima$AIC
model.sim.sarima$BIC
model.sim.sarima$AICc


model.sim.sarima.a = arima(x = covid.log,
                          order = c(1, 2, 1),
                          seasonal = list(order = c(0, 0, 0),
                          period = 0))

png(filename="figures/model1_pacf.png")
pacf(model.sim.sarima.a$residuals,
        main="PACF for SARIMA On All Log Data")


model.sim.sarima.acf = ARMAacf(ar=model.sim.sarima$fit$model$theta,
                                ma=model.sim.sarima$fit$model$phi,
                                lag.max=60)

model.sim.sarima.pacf = ARMAacf(ar=model.sim.sarima$fit$model$theta,
                                ma=model.sim.sarima$fit$model$phi,
                                lag.max=60,
                                pacf=TRUE)

png(filename="figures/model1_acf_c.png")
acf(covid.log, lag.max=60, main="Theoretic ACF vs Empirical")
points(1:61, model.sim.sarima.acf, col=2)


png(filename="figures/model1_pacf_c.png")
pacf(covid.log,
        main="Theoretical PACF vs Empirical PACF")
points(1:60, model.sim.sarima.pacf, col=2)


sarima_pred = sarima.for(covid.log,p=1,d=2,q=4,P=0,D=0,Q=0,S=0, n.ahead=10)
