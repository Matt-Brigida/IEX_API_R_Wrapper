### Functions to interact with the IEX API:  https://iextrading.com/developer/docs/

## use httr
library(httr)

base_url <- "https://api.iextrading.com/"
version <- "1.0/"

.datahandler <- function(tmpdata, ticker = ""){
    tmpdata <- content(tmpdata, "parsed")
    tmpdata <- do.call(rbind, tmpdata)
    tmpdata <- data.frame(tmpdata)
    if(ticker != ""){
    tmpdata$Ticker <- ticker
    }
    return(tmpdata)
}

## volume by venue for given ticker
ven <- function(ticker){
    tmpdata <- GET(paste0(base_url, version, "stock/", ticker,"/volume-by-venue"))
    .datahandler(tmpdata, ticker)
}

## book
book <- function(ticker){
    tmpdata <- GET(paste0(base_url, version, "stock/", ticker,"/book"))
    .datahandler(tmpdata, ticker)
}

## chart---right now just pulls default 1 month.  Add additional history lengths later
chart <- function(ticker){
    tmpdata <- GET(paste0(base_url, version, "stock/", ticker,"/chart"))
    .datahandler(tmpdata, ticker)
}

## add collections function------



## one minute prices over day for given ticker
one_day <- function(ticker){
    tmpdata <- GET(paste0(base_url, version, "stock/", ticker,"/chart/1d"))
    .datahandler(tmpdata, ticker)
}


### function which are somewhat different from standard -----------

## get all symbols (names and tickers), may change daily
symbol_list <- function(){
    tmpdata <- GET(paste0(base_url, version, "/ref-data/symbols"))
    .datahandler(tmpdata)
}

## crypto
crypto <- function(){
    tmpdata <- GET(paste0(base_url, version, "/stock/market/crypto"))
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

## company---TODO: fix, this function must return a different structure
company <- function(ticker){
    tmpdata <- GET(paste0(base_url, version, "stock/", ticker,"/company"))
    .datahandler(tmpdata, ticker)
}