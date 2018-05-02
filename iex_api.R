### Functions to interact with the IEX API:  https://iextrading.com/developer/docs/

## use httr
library(httr)

base_url <- "https://api.iextrading.com/"
version <- "1.0/"

## example GET

test <- GET(paste0(base_url, version, "stock/aapl/company"))
str(content(test, "parsed"))


## volume by venue for given ticker
ven <- function(ticker){
    tmp <- GET(paste0(base_url, version, "stock/", ticker,"/volume-by-venue"))
    tmp <- content(tmp, "parsed")
    tmp <- do.call(rbind, tmp)
    tmp <- data.frame(tmp)
    tmp$Ticker <- ticker
    return(tmp)
}
