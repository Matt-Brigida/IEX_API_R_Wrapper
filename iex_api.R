### Functions to interact with the IEX API:  https://iextrading.com/developer/docs/

## use httr
library(httr)

base_url <- "https://api.iextrading.com/"
version <- "1.0/"

.datahandler <- function(tmpdata, ticker = ""){
    tmpdata <- content(tmpdata, "parsed")
    tmpdata <- do.call(rbind, tmpdata)
    tmpdata <- data.frame(tmpdata)
    tmpdata$Ticker <- ticker
    return(tmpdata)
}

## volume by venue for given ticker
ven <- function(ticker){
    tmpdata <- GET(paste0(base_url, version, "stock/", ticker,"/volume-by-venue"))
    .datahandler(tmpdata, ticker)
}

book <- function(ticker){
    tmpdata <- GET(paste0(base_url, version, "stock/", ticker,"/book"))
    .datahandler(tmpdata, ticker)
}
  
## one minute prices over day for given ticker
one_day <- function(ticker){
    tmpdata <- GET(paste0(base_url, version, "stock/", ticker,"/chart/1d"))
    .datahandler(tmpdata, ticker)
}

## get all symbols (names and tickers), may change daily
symbol_list <- function(){
    tmpdata <- GET(paste0(base_url, version, "/ref-data/symbols"))
    .datahandler(tmpdata)
}


## finacials for given ticker  --- work on this function, data returned is in a different structure. 
fins <- function(ticker){
    tmp <- GET(paste0(base_url, version, "stock/", ticker,"/financials"))
    tmp <- content(tmp, "parsed")
    tmp <- unlist(tmp)
    names <- gsub("financials.", "", names(tmp))
    tmp <- data.frame(tmp, rownames = names)
    names(tmp) <- c("data", "field")
    return(tmp)
}
