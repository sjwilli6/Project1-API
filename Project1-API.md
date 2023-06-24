Project 1 - Financial Data API
================
Spencer Williams
6/25/2023

- <a href="#packages-used-for-financial-data"
  id="toc-packages-used-for-financial-data">Packages Used for Financial
  Data</a>
  - <a href="#loading-in-the-correct-packages"
    id="toc-loading-in-the-correct-packages">Loading in the correct
    packages</a>
  - <a href="#convert-to-numeric" id="toc-convert-to-numeric">Convert to
    Numeric</a>
- <a href="#functions" id="toc-functions">Functions</a>
  - <a href="#tickers" id="toc-tickers">Tickers</a>
  - <a href="#grouped-daily-january" id="toc-grouped-daily-january">Grouped
    Daily January</a>
  - <a href="#grouped-daily-march" id="toc-grouped-daily-march">Grouped
    Daily March</a>
  - <a href="#stock-splits-v3" id="toc-stock-splits-v3">Stock Splits V3</a>
  - <a href="#ticker-types" id="toc-ticker-types">Ticker Types</a>
  - <a href="#dividend-v3" id="toc-dividend-v3">Dividend V3</a>
  - <a href="#financial-api-wrapper-function"
    id="toc-financial-api-wrapper-function">Financial API Wrapper
    Function</a>
- <a href="#data-exploration" id="toc-data-exploration">Data
  Exploration</a>

# Packages Used for Financial Data

Here is a list of packages I will be using to help me create functions
and manipulate the data throughout my project.

1.  **jsonlite** - This is an API interaction package that will allow me
    to connect to the Financial database. It will also allow me to get
    this data into a nice data frame.

2.  **tidyverse** - This package contains `dplyr` and `tidyr` that will
    let me manipulate and reshape the data frames. I can add/combine
    variables and dataframes while also creating plots.

3.  **rmarkdown** - This package will be used to render my data from
    Rstudio to Github in the correct repos.

## Loading in the correct packages

## Convert to Numeric

Creating a function to convert character vectors to numeric if it is a
vector of numerical data.

# Functions

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

## Grouped Daily January

The Grouped Daily function allows the user to get a daily open, high,
low, and closing price for the entire stock/equities markets. In this
function, I set up data from January 9, 2023.

``` r
groupedDailyJan <- function(stock="all"){
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

## Grouped Daily March

The Grouped Daily function allows the user to get a daily open, high,
low, and closing price for the entire stock/equities markets. In this
function, I set up data from March 9, 2023.

``` r
groupedDailyMar <- function(stock="all"){
  outputAPI <- fromJSON("https://api.polygon.io/v2/aggs/grouped/locale/us/market/stocks/2023-03-09?adjusted=true&apiKey=BnFt9sqaLWehzloLkpMtEeOG4WjAqkUc")
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
      message <- paste("Error: Stock has not been split recently or invalid stock.")
      stop(message)
    }
  }
    else {
  
    }
  output <- suppressMessages(as.data.frame(lapply(output, convertToNumeric)))
  return(output)
}
```

## Ticker Types

Ticker Types is the different type of stocks that are being kept in the
data system that I am using. It has information such as the code or
ticker, the full description name, asset class, and the country.

``` r
tickerTypes <- function(stock="all"){
  outputAPI <- fromJSON("https://api.polygon.io/v3/reference/tickers/types?apiKey=BnFt9sqaLWehzloLkpMtEeOG4WjAqkUc")
  output <- outputAPI$results
  
  if(stock !="all") {
    if(stock %in% output$code) {
      output <- output %>% filter(code == stock)
    }
    else if (stock %in% output$description) {
      output <- output %>% filter(description == stock)
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

## Dividend V3

This function will give a list of historical cash dividends, including
the ticker symbol, declaration date, ex-dividend date, record date, pay
date, frequency, and amount for CDs in the database.

``` r
dividendV3 <- function(stock="all"){
  outputAPI <- fromJSON("https://api.polygon.io/v3/reference/dividends?apiKey=BnFt9sqaLWehzloLkpMtEeOG4WjAqkUc")
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
```

## Financial API Wrapper Function

``` r
FinancialAPI <- function(func, ...){
  if (func == "tickers"){
    output <- tickers(...)
  }
  else if (func == "groupedDailyJan"){
    output <- groupedDailyJan(...)
  }
  else if (func == "groupedDailyMar"){
    output <- groupedDailyMar(...)
  }
  else if (func == "stockSplits"){
    output <- stockSplits(...)
  }
  else if (func == "tickerTypes"){
    output <- tickerTypes(...)
  }
  else if (func == "dividendV3"){
    output <- dividendV3(...)
  }
  else {
    stop("ERROR: Argument for function is not valid!")
  }
  return(output)
}
```

# Data Exploration

I am going to create a new *Month* variable for the `groupedDailyJan`
and `groupedDailyMar` datasets so that i can combine the two. I am then
going to create one more variable, *Difference*, that will calculate the
difference between the *Open* and *Close* price.

``` r
Jan <- FinancialAPI("groupedDailyJan")
Mar <- FinancialAPI("groupedDailyMar")
colnames(Jan) <- c("Symbol", "Volume", "Volume_Weight", "Open", "Close", "High", "Low", "Timestamp", "Transactions")
colnames(Mar) <- c("Symbol", "Volume", "Volume_Weight", "Open", "Close", "High", "Low", "Timestamp", "Transactions")

Jan <- mutate(Jan, Month = "January", Difference = (Open - Close))
Mar <- mutate(Mar, Month = "March", Difference = (Open - Close))

fullGroupedData <- full_join(Jan, Mar)
```

    ## Joining with `by = join_by(Symbol, Volume, Volume_Weight, Open, Close, High,
    ## Low, Timestamp, Transactions, Month, Difference)`
