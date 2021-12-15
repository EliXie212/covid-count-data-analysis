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
covid.ratio.35 = covid.ratio[35: length(covid.ratio)]


png(filename="figures/eda_35_ratio.png")
plot.ts(covid.ratio.35,
        main="Daily Ratio of Increase After Day 35",
        xlab="Day",
        ylab="Daily Ratio of Increase",
        col="blue")


auto.arima(covid.ratio.35)


png(filename="figures/model4_s.png")
model.ratio.sarima.35 = sarima(covid.ratio.35,p=0,d=0,q=3,P=0,D=0,Q=0,S=0)


model.ratio.sarima.35$AIC
model.ratio.sarima.35$BIC
model.ratio.sarima.35$AICc


model.ratio.sarima.35.a = arima(x = covid.ratio.35,
                                order = c(0, 0, 3),
                                seasonal = list(order = c(0, 0, 0),
                                period = 0))


png(filename="figures/model4_pacf.png")
pacf(model.ratio.sarima.35.a$residuals,
     main="PACF for SARIMA with Daily Ratio of Increase After Day 35")


model.ratio.sarima.35.acf = ARMAacf(ar=0, ma=0, lag.max=20)
model.ratio.sarima.35.pacf = ARMAacf(ar=0, ma=0, lag.max=20, pacf=TRUE)


png(filename="figures/model4_acf_c.png")
acf(covid.ratio.35, lag.max=20)
points(0:20, model.ratio.sarima.35.acf, col=2,
       main="Theoretical ACF vs Empirical ACF")


png(filename="figures/model4_pacf_c.png")
pacf(covid.ratio.35, lag.max=20,
     main="Theoretical PACF vs Empriical PACF")
points(1:20, model.ratio.sarima.35.pacf, col=2)



sarima_ratio_pred.35 = sarima.for(covid.ratio.35,p=0,d=0,q=0,P=0,D=2,Q=0,S=0,
                                    n.ahead=10)
