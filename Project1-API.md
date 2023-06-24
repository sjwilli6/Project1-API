Project 1 - Financial Data API
================
Spencer Williams
6/25/2023

- <a href="#loading-in-the-correct-packages"
  id="toc-loading-in-the-correct-packages">Loading in the correct
  packages</a>
- <a href="#convert-to-numeric" id="toc-convert-to-numeric">Convert to
  Numeric</a>
- <a href="#tickers" id="toc-tickers">Tickers</a>
- <a href="#grouped-daily" id="toc-grouped-daily">Grouped Daily</a>
- <a href="#stock-splits-v3" id="toc-stock-splits-v3">Stock Splits V3</a>
- <a href="#market-status" id="toc-market-status">Market Status</a>
- <a href="#stock-splits-v3-1" id="toc-stock-splits-v3-1">Stock Splits
  V3</a>
- <a href="#ticker-news" id="toc-ticker-news">Ticker News</a>

## Loading in the correct packages

## Convert to Numeric

Creating a function to convert character vectors to numeric if it is a
vector of numerical data.

## Tickers

Creating a function to output data based on the name of the stock. The
data contains ticker symbols such as stocks/equities, indices, forex,
and crypto.

``` r
tickers <- function(stock="all"){
  outputAPI <- fromJSON("https://api.polygon.io/v3/reference/tickers?active=true&apiKey=BnFt9sqaLWehzloLkpMtEeOG4WjAqkUc")
  output <- outputAPI$results
  
  if(stock !="all") {
    if(stock %in% output$ticker) {
      output <- output %>% filter(ticker == stock)
    }
    else if (stock %in% output$name) {
      output <- output %>% filter(name == stock)
    }
    else {
      message <- paste("Error: Stock was not found in the ticker or name column of dataset.")
      stop(message)
    }
  }
    else {
  
    }
  output <- suppressMessages(as.data.frame(lapply(output, convertToNumeric)))
  return(output)
}
```

## Grouped Daily

The Grouped Daily function allows the user to get a daily open, high,
low, and closing price for the entire stock/equities markets. In this
function, I set up data from January 9, 2023.

``` r
groupedDaily <- function(stock="all"){
  outputAPI <- fromJSON("https://api.polygon.io/v2/aggs/grouped/locale/us/market/stocks/2023-01-09?adjusted=true&apiKey=BnFt9sqaLWehzloLkpMtEeOG4WjAqkUc")
  output <- outputAPI$results
  
  if(stock !="all") {
    if(stock %in% output$T) {
      output <- output %>% filter(T == stock)
    }
    else {
      message <- paste("Error: Stock was not found in the ticker or name column of dataset.")
      stop(message)
    }
  }
    else {
  
    }
  output <- suppressMessages(as.data.frame(lapply(output, convertToNumeric)))
  return(output)
}
```

## Stock Splits V3

Stock Splits V3 will give the user a list of historical stock splits,
including the ticker symbol, the execution date, and the factors of the
split ratio.

``` r
stockSplits <- function(stock="all"){
  outputAPI <- fromJSON("https://api.polygon.io/v3/reference/splits?apiKey=BnFt9sqaLWehzloLkpMtEeOG4WjAqkUc")
  output <- outputAPI$results
  
  if(stock !="all") {
    if(stock %in% output$ticker) {
      output <- output %>% filter(ticker == stock)
    }
    else {
      message <- paste("Error: Stock was not found in the ticker or name column of dataset.")
      stop(message)
    }
  }
    else {
  
    }
  output <- suppressMessages(as.data.frame(lapply(output, convertToNumeric)))
  return(output)
}
stockSplits("BOIL")
```

    ##   execution_date split_from split_to ticker
    ## 1     2023-06-23         20        1   BOIL

## Market Status

This function will allow the user to get the current trading status of
the exchnanges and the overall financial markets.

## Stock Splits V3

Stock Splits V3 will give the user a list of historical stock splits,
including the ticker symbol, the execution date, and the factors of the
split ratio.

## Ticker News

Using the ticker news function, the user can obtain the most recent news
article relating to the ticker symbol. This includes a summary of the
article and a link to the original source. There are a minimal amount of
recent news articles.

``` r
tickerNews <- function(stock="all"){
  outputAPI <- fromJSON("https://api.polygon.io/v2/reference/news?apiKey=BnFt9sqaLWehzloLkpMtEeOG4WjAqkUc")
  output <- outputAPI$results
  
  if(stock !="all") {
    if(stock %in% output$tickers) {
      output <- output %>% filter(tickers == stock)
    }
    else {
      message <- paste("Error: Stock does not have recent news")
      stop(message)
    }
  }
    else {
  
    }
  output <- suppressMessages(as.data.frame(lapply(output, convertToNumeric)))
  return(output)
}
```
