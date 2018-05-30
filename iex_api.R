### Functions to interact with the IEX API:  https://iextrading.com/developer/docs/

## use httr
library(httr)

base_url <- "https://api.iextrading.com/"
version <- "1.0/"

## volume by venue for given ticker
ven <- function(ticker){
    tmp <- GET(paste0(base_url, version, "stock/", ticker,"/volume-by-venue"))
    tmp <- content(tmp, "parsed")
    tmp <- do.call(rbind, tmp)
    tmp <- data.frame(tmp)
    tmp$Ticker <- ticker
    return(tmp)
}

## one minute prices over day for given ticker
one_day <- function(ticker){
    tmp <- GET(paste0(base_url, version, "stock/", ticker,"/chart/1d"))
    tmp <- content(tmp, "parsed")
    tmp <- do.call(rbind, tmp)
    tmp <- data.frame(tmp)
    tmp$Ticker <- ticker
    return(tmp)
}

## get all symbols (names and tickers), may change daily
symbol_list <- function(){
    tmp <- GET(paste0(base_url, version, "/ref-data/symbols"))
    tmp <- content(tmp, "parsed")
    tmp <- do.call(rbind, tmp)
    tmp <- data.frame(tmp)
    return(tmp)
}

## finacials for given ticker  --- work on this function, data returned is in a different structure. 
fins <- function(ticker){
    tmp <- GET(paste0(base_url, version, "stock/", ticker,"/financials"))
    tmp <- content(tmp, "parsed")
    tmp <- unlist(tmp)
    names <- gsub("financials.", "", names(tmp))
    ## iden <- c("", rep(c("", rep("Income Statement",8), rep("Balance Sheet", 7), rep("Cash Flow", 2)), 4))
    ## tmp <- data.frame(tmp, rownames = names, fin_statement = iden)
    tmp <- data.frame(tmp, rownames = names)
    ## names(tmp) <- c("data", "field", "Fin_Statement")
    names(tmp) <- c("data", "field")
    return(tmp)
}
