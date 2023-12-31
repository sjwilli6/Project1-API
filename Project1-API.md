Project 1 - Financial Data API
================
Spencer Williams
6/25/2023

- <a href="#intro" id="toc-intro">Intro</a>
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
  - <a href="#contingency-tables" id="toc-contingency-tables">Contingency
    Tables</a>
    - <a href="#creating-numerical-summaries-grouped-by-month"
      id="toc-creating-numerical-summaries-grouped-by-month">Creating
      Numerical Summaries Grouped by <code>Month</code></a>
  - <a href="#creating-plots-for-data"
    id="toc-creating-plots-for-data">Creating Plots for Data</a>

# Intro

I enjoy the stock market and the unpredictability that comes with it. I
have chosen to take a deeper dive into the [Financial Data
API](https://polygon.io/docs/stocks). Some specific details that come to
mind are the daily high and lows of each stock. I also wanted to look at
the volume and transactions to see which stocks have the most
interaction among the public.

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

``` r
# Loading in Data Packages
library(httr)
library(dplyr)
library(jsonlite)
library(rmarkdown)
library(tidyverse)
```

## Convert to Numeric

Creating a function to convert numeric vectors that are stored as
character to a numeric data type.

``` r
convertToNumeric <- function(vector){
  # Converting Data to Numeric
  if (any(is.na(suppressWarnings(as.numeric(vector))) == TRUE)){
    output <- vector
  }
  else {
    output <- as.numeric(vector)
  }
  # Return
  return(output)
}
```

# Functions

## Tickers

Creating a function to output data based on the name of the stock. The
data contains ticker symbols such as stocks/equities, indices, forex,
and crypto. It will then output a data frame of the called ticker
symbol.

``` r
tickers <- function(stock="all"){
  # Get data from API
  outputAPI <- fromJSON("https://api.polygon.io/v3/reference/tickers?active=true&apiKey=BnFt9sqaLWehzloLkpMtEeOG4WjAqkUc")
  # Results tab in API
  output <- outputAPI$results
  # See if the stock matches one of the names in the ticker colunn
  if(stock !="all") {
    if(stock %in% output$ticker) {
      output <- output %>% filter(ticker == stock)
    }
    # See if the stock matches one of the names in the name column
    else if (stock %in% output$name) {
      output <- output %>% filter(name == stock)
    }
    # Error Message
    else {
      message <- paste("Error: Stock was not found in the ticker or name column of dataset.")
      stop(message)
    }
  }
    else {
  
    }
  # Create Data Frame
  output <- suppressMessages(as.data.frame(lapply(output, convertToNumeric)))
  # Return
  return(output)
}
```

## Grouped Daily January

The Grouped Daily function allows the user to get a daily open, high,
low, and closing price for the entire stock/equities markets. In this
function, I set up data from January 9, 2023. The user will input a
stock or ticker, and the output will contain details from the specific
date.

``` r
groupedDailyJan <- function(stock="all"){
  # Get data from API
  outputAPI <- fromJSON("https://api.polygon.io/v2/aggs/grouped/locale/us/market/stocks/2023-01-09?adjusted=true&apiKey=BnFt9sqaLWehzloLkpMtEeOG4WjAqkUc")
  # Results tab in API
  output <- outputAPI$results
  # See if stock matches one of the names in the column T
  if(stock !="all") {
    if(stock %in% output$T) {
      output <- output %>% filter(T == stock)
    }
    # Error Message
    else {
      message <- paste("Error: Stock was not found in the ticker or name column of dataset.")
      stop(message)
    }
  }
    else {
  
    }
  # Create Data Frame
  output <- suppressMessages(as.data.frame(lapply(output, convertToNumeric)))
  # Return
  return(output)
}
```

## Grouped Daily March

The Grouped Daily function allows the user to get a daily open, high,
low, and closing price for the entire stock/equities markets. In this
function, I set up data from March 9, 2023. The user will input a stock
or ticker, and the output will contain details from the specific date.

``` r
groupedDailyMar <- function(stock="all"){
  # Get Data from API
  outputAPI <- fromJSON("https://api.polygon.io/v2/aggs/grouped/locale/us/market/stocks/2023-03-09?adjusted=true&apiKey=BnFt9sqaLWehzloLkpMtEeOG4WjAqkUc")
  # Results tab in API
  output <- outputAPI$results
  # See if the stock matches one of the names in the column T
  if(stock !="all") {
    if(stock %in% output$T) {
      output <- output %>% filter(T == stock)
    }
    # Error Message
    else {
      message <- paste("Error: Stock was not found in the ticker or name column of dataset.")
      stop(message)
    }
  }
    else {
  
    }
  # Create Data Frame
  output <- suppressMessages(as.data.frame(lapply(output, convertToNumeric)))
  # Return
  return(output)
}
```

## Stock Splits V3

Stock Splits V3 will give the user a list of historical stock splits,
including the ticker symbol, the execution date, and the factors of the
split ratio.

``` r
stockSplits <- function(stock="all"){
  # Get Data from API
  outputAPI <- fromJSON("https://api.polygon.io/v3/reference/splits?apiKey=BnFt9sqaLWehzloLkpMtEeOG4WjAqkUc")
  # Results tab in the API
  output <- outputAPI$results
  # See if the stock matches one of the names in the ticker column
  if(stock !="all") {
    if(stock %in% output$ticker) {
      output <- output %>% filter(ticker == stock)
    }
    # Error Messages
    else {
      message <- paste("Error: Stock has not been split recently or invalid stock.")
      stop(message)
    }
  }
    else {
  
    }
  # Create Data Frame
  output <- suppressMessages(as.data.frame(lapply(output, convertToNumeric)))
  # Return
  return(output)
}
```

## Ticker Types

Ticker Types is the different type of stocks that are being kept in the
data system that I am using. It has information such as the code or
ticker, the full description name, asset class, and the country.

``` r
tickerTypes <- function(stock="all"){
  # Get Data from API
  outputAPI <- fromJSON("https://api.polygon.io/v3/reference/tickers/types?apiKey=BnFt9sqaLWehzloLkpMtEeOG4WjAqkUc")
  # Results tab in API
  output <- outputAPI$results
  # See if the stock matches one of the names in the code column
  if(stock !="all") {
    if(stock %in% output$code) {
      output <- output %>% filter(code == stock)
    }
    # See if the stock matches one of the names in the descriptions column
    else if (stock %in% output$description) {
      output <- output %>% filter(description == stock)
    }
    # Error Message
    else {
      message <- paste("Error: Stock was not found in the ticker or name column of dataset.")
      stop(message)
    }
  }
    else {
  
    }
  # Create Data Frame
  output <- suppressMessages(as.data.frame(lapply(output, convertToNumeric)))
  # Return
  return(output)
}
```

## Dividend V3

This function will give a list of historical cash dividends, including
the ticker symbol, declaration date, ex-dividend date, record date, pay
date, frequency, and amount for CDs in the database.

``` r
dividendV3 <- function(stock="all"){
  # Get Data from API
  outputAPI <- fromJSON("https://api.polygon.io/v3/reference/dividends?apiKey=BnFt9sqaLWehzloLkpMtEeOG4WjAqkUc")
  # Results tab in API
  output <- outputAPI$results
  # See if Stock matches one of the names in the ticker column
  if(stock !="all") {
    if(stock %in% output$ticker) {
      output <- output %>% filter(ticker == stock)
    }
    # Error Message
    else {
      message <- paste("Error: Stock was not found in the ticker or name column of dataset.")
      stop(message)
    }
  }
    else {
  
    }
  # Create Data Frame
  output <- suppressMessages(as.data.frame(lapply(output, convertToNumeric)))
  # Return
  return(output)
}
```

## Financial API Wrapper Function

This function is a wrapper function called `FinancialAPI` that will
allow the user to easily call one of the functions listed above.

``` r
FinancialAPI <- function(func, ...){
  # List of Functions Created
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
  # Error Message
  else {
    stop("ERROR: Argument for function is not valid!")
  }
  # Return
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

# Renaming Column Names
colnames(Jan) <- c("Symbol", "Volume", "Volume_Weight", "Open", "Close", "High", "Low", "Timestamp", "Transactions")
colnames(Mar) <- c("Symbol", "Volume", "Volume_Weight", "Open", "Close", "High", "Low", "Timestamp", "Transactions")

# Creating Month and Difference Variable
Jan <- mutate(Jan, Month = "January", Difference = (Open - Close))
Mar <- mutate(Mar, Month = "March", Difference = (Open - Close))

# Joining Datasets
fullGroupedData <- full_join(Jan, Mar)
```

    ## Joining with `by = join_by(Symbol, Volume, Volume_Weight, Open, Close, High,
    ## Low, Timestamp, Transactions, Month, Difference)`

## Contingency Tables

I am creating a `Returns` variable that will tell us whether the stock
increased in Price throughout the day. I am then going to create a table
to see if January 9th or March 9th would have been a better day for
investors. Then, I am going to create a `Twenty` variable to see if
stocks were higher or lower than this value at their opening price.

``` r
# Creating vector
Returns <- vector()
# Creating for loop from 1 to the number of rows in the dataset
for (i in seq_len(nrow(fullGroupedData))) {
  # Positive return in Stock
  if(fullGroupedData$Difference[i] >= 0) {
    Returns[i] <- "Positive"
  # Negative return in Stock
  } else if (fullGroupedData$Difference[i] <= 0) {
    Returns[i] <- "Negative"
  } else {
    Returns[i] <- "Error"
  }
}
# Adding Return to my dataset
fullGroupedData$Returns <- Returns
# Creating contingency table
knitr::kable(table(fullGroupedData$Month, fullGroupedData$Returns), caption= "Monthly Returns")
```

|         | Negative | Positive |
|:--------|---------:|---------:|
| January |     4285 |     6668 |
| March   |     1560 |     9284 |

Monthly Returns

Based on the table, investors had a relatively good day on January 9th
and March 9th. March was a very good day for investors with 9,284 stocks
being positive out of the total 10,844. January had a respectable 6,668
increased stocks out of the possible 10,953. Here is a bar plot
displaying the data.

``` r
# Creating base for graph
g <- ggplot(fullGroupedData, aes(x = Returns))
# Adding bars to the graph
g + geom_bar(aes(fill = Month)) +
  # Creating labels and titles
  labs(x = "Returns", title = "Monthly Returns") +
  scale_x_discrete(labels = c("Negative", "Positive"))
```

![](Project1-API_files/figure-gfm/plot1-1.png)<!-- -->

Creating a second contingency table based on a new variable, `twenty`. I
thought twenty would be a reasonable stock price so i decided to pick
this as a variable.

``` r
# Creating vector
Twenty <- vector()
# Creating for loop from 1 to the number of rows in the dataset
for (i in seq_len(nrow(fullGroupedData))) {
  # If the stock opened greater than $20.
  if(fullGroupedData$Open[i] >= 20) {
    Twenty[i] <- "Higher"
  # If the stock opened less than $20.
  } else if (fullGroupedData$Open[i] <= 20) {
    Twenty[i] <- "Lower"
  } else {
    Twenty[i] <- "Error"
  }
}
# Add variable to the dataset
fullGroupedData$Twenty <- Twenty
# Create contingency table
knitr::kable(table(fullGroupedData$Month, fullGroupedData$Twenty), caption= "$20 Budget")
```

|         | Higher | Lower |
|:--------|-------:|------:|
| January |   5316 |  5637 |
| March   |   5418 |  5426 |

\$20 Budget

Based on this contingency table comparing the opening price of each
stock to the month variable, a 20 dollar stock seems to be around the
median. In January, 5,316 stocks were above an opening price of 20
dollars while 5,637 stocks were below this price. In March, these totals
were 5,418 above and 5,426 below the opening price of 20 dollars. Below
is a visual to see that 20 dollars is roughly the median of the data.

``` r
# Creating base for graph
g <- ggplot(fullGroupedData, aes(x = Twenty))
# Adding bars to the graph
g + geom_bar(aes(fill = Month)) +
  # Creating labels and titles for graph
  labs(x = "Returns", title = "$20 Budget") +
  scale_x_discrete(labels = c("Higher", "Lower")) +
  # Flipping the graph to the left side if user's prefer
  coord_flip()
```

![](Project1-API_files/figure-gfm/plot2-1.png)<!-- -->

### Creating Numerical Summaries Grouped by `Month`

Here, I am comparing numerical summaries between months for the daily
high and lows.

``` r
# Creating numerical summary's to see the details about the Jan/Mar lows and highs
tapply(fullGroupedData$Low, fullGroupedData$Month, summary)
```

    ## $January
    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ##      0.0      6.8     19.0     78.9     34.9 476653.3 
    ## 
    ## $March
    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ##      0.0      6.5     19.5     78.6     35.6 460924.4

``` r
tapply(fullGroupedData$High, fullGroupedData$Month, summary)
```

    ## $January
    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ##      0.0      7.1     19.4     80.8     35.7 487989.1 
    ## 
    ## $March
    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ##      0.0      7.0     20.1     81.0     36.8 474833.9

Based on the mean and median of each month, the data seems to be heavily
skewed to the right (higher stock price). The summary statistics are
relatively similar for the two months at daily low and high prices.

## Creating Plots for Data

Creating a Box Plot of the data in `Dividend`. It will compare the cash
amount of the recent CDs in the API.

``` r
# Calling "cash" data
cash <- FinancialAPI("dividendV3")
# Creating base for graph
g <- ggplot(cash, aes(x = ticker, y = cash_amount))
# Adding blue boxplots
g + geom_boxplot(fill = "blue") +
  # Adding labels and titles
  labs(x ="Symbol", y = "Cash Amount", title = "Boxplot for CDs in Dividends")
```

![](Project1-API_files/figure-gfm/plot3-1.png)<!-- -->

Based on this Box Plot, *GEGGL* has a higher cash amount dividend than
*GECCO*.

I am going to create a scatterplot to see if the number of transactions
has any relationship to the trading volume. In other words, are there
large amounts of volume being bought in March with little transactions
(large amount of money for a smaller group of individuals) vs a smaller
volume with large amounts of transactions.

``` r
# Creating base for graph
g <- ggplot(Mar, aes(x = Volume, y = Transactions))
# Adding scatterplot with text for each symbol
g + geom_text(aes(label = Symbol)) +
  # Adding labels and titles
    labs(x ="Volume", y = "Transactions", title = "Transactions vs Volume on March 9")
```

    ## Warning: Removed 104 rows containing missing values (`geom_text()`).

![](Project1-API_files/figure-gfm/plot4-1.png)<!-- -->

Looking at the data, Tesla (TSLA) has a very large volume of stock being
bought with a large amount of transactions. TQQQ on the other hand has
an enormous volume, but not as many transactions. I wonder if this could
be due to one particular individual or business that bought a large
amount of this stock.

I want to see if how many transactions were made on January 9. However,
looking at the data from previous EDA, there are going to be outliers.
As a result, I am going to cutoff my histogram at 5,000 transactions.

``` r
# Creating base for graph
g <- ggplot(Jan, aes(x = Transactions))
# Adding histogram to graph with binwidth and colors
g + geom_histogram(binwidth = 100, color = "red", fill = "black") +
  # Setting a cutoff to ignore outliers
  xlim(0, 5000) +
  # Adding labels and titles
  labs(y ="Count", x = "Transactions", title = "Histogram of Transactions on January 9")
```

    ## Warning: Removed 2782 rows containing non-finite values (`stat_bin()`).

    ## Warning: Removed 2 rows containing missing values (`geom_bar()`).

![](Project1-API_files/figure-gfm/plot5-1.png)<!-- -->

Based on this *Histogram of Transactions*, most stocks have a small
amount on January 9th. It is heavily skewed to the left, which would be
expected. I would assume that most stocks would have smaller
transactions on a daily basis.
