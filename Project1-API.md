Project 1 - Financial Data API
================
Spencer Williams
6/25/2023

- <a href="#loading-in-the-correct-packages"
  id="toc-loading-in-the-correct-packages">Loading in the correct
  packages</a>
- <a
  href="#creating-a-function-to-convert-character-vectors-to-numeric-if-it-is-a-vector-of-numerical-data"
  id="toc-creating-a-function-to-convert-character-vectors-to-numeric-if-it-is-a-vector-of-numerical-data">Creating
  a function to convert character vectors to numeric if it is a vector of
  numerical data</a>
- <a href="#tickers" id="toc-tickers"><code>Tickers</code></a>

## Loading in the correct packages

## Creating a function to convert character vectors to numeric if it is a vector of numerical data

## `Tickers`

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
tickers("A")
```

    ##   ticker                      name market locale primary_exchange type active
    ## 1      A Agilent Technologies Inc. stocks     us             XNYS   CS      1
    ##   currency_name     cik composite_figi share_class_figi     last_updated_utc
    ## 1           usd 1090872   BBG000C2V3D6     BBG001SCTQY4 2023-06-22T00:00:00Z

``` r
outputAPI <- fromJSON("https://api.polygon.io/v3/reference/tickers?active=true&apiKey=BnFt9sqaLWehzloLkpMtEeOG4WjAqkUc")
str(outputAPI)
```

    ## List of 5
    ##  $ results   :'data.frame':  100 obs. of  12 variables:
    ##   ..$ ticker          : chr [1:100] "A" "AA" "AAA" "AAAIF" ...
    ##   ..$ name            : chr [1:100] "Agilent Technologies Inc." "Alcoa Corporation" "AXS First Priority CLO Bond ETF" "ALTERNATIVE INVSTMENT TR" ...
    ##   ..$ market          : chr [1:100] "stocks" "stocks" "stocks" "otc" ...
    ##   ..$ locale          : chr [1:100] "us" "us" "us" "us" ...
    ##   ..$ primary_exchange: chr [1:100] "XNYS" "XNYS" "ARCX" NA ...
    ##   ..$ type            : chr [1:100] "CS" "CS" "ETF" "FUND" ...
    ##   ..$ active          : logi [1:100] TRUE TRUE TRUE TRUE TRUE TRUE ...
    ##   ..$ currency_name   : chr [1:100] "usd" "usd" "usd" "USD" ...
    ##   ..$ cik             : chr [1:100] "0001090872" "0001675149" "0001776878" NA ...
    ##   ..$ composite_figi  : chr [1:100] "BBG000C2V3D6" "BBG00B3T3HD3" "BBG01B0JRCS6" NA ...
    ##   ..$ share_class_figi: chr [1:100] "BBG001SCTQY4" "BBG00B3T3HF1" "BBG01B0JRCT5" NA ...
    ##   ..$ last_updated_utc: chr [1:100] "2023-06-22T00:00:00Z" "2023-06-22T00:00:00Z" "2023-06-22T00:00:00Z" "2022-08-26T05:00:07.114Z" ...
    ##  $ status    : chr "OK"
    ##  $ request_id: chr "07be28f0b34840ff86a86233ec46b2ba"
    ##  $ count     : int 100
    ##  $ next_url  : chr "https://api.polygon.io/v3/reference/tickers?cursor=YWN0aXZlPXRydWUmYXA9QUJDTCU3QzhlM2U5Mzk3NmI4YmFkMjcyOWM0NmVk"| __truncated__

``` r
output <- outputAPI$results
print(output)
```

    ##      ticker
    ## 1         A
    ## 2        AA
    ## 3       AAA
    ## 4     AAAIF
    ## 5     AAALF
    ## 6     AAALY
    ## 7      AAAU
    ## 8      AABB
    ## 9     AABVF
    ## 10      AAC
    ## 11    AAC.U
    ## 12   AAC.WS
    ## 13    AACAF
    ## 14    AACAY
    ## 15     AACG
    ## 16     AACI
    ## 17    AACIU
    ## 18    AACIW
    ## 19     AACS
    ## 20     AACT
    ## 21   AACT.U
    ## 22  AACT.WS
    ## 23    AACTF
    ## 24     AADI
    ## 25     AADR
    ## 26    AAEEF
    ## 27    AAFRF
    ## 28     AAGC
    ## 29    AAGEF
    ## 30    AAGFF
    ## 31     AAGH
    ## 32    AAGIY
    ## 33    AAGRY
    ## 34    AAHIF
    ## 35     AAIC
    ## 36   AAICpB
    ## 37   AAICpC
    ## 38    AAIGF
    ## 39    AAIIQ
    ## 40     AAIN
    ## 41    AAIRF
    ## 42      AAL
    ## 43    AALBF
    ## 44    AAMAF
    ## 45     AAMC
    ## 46     AAME
    ## 47    AAMMF
    ## 48    AAMTF
    ## 49    AAMpA
    ## 50    AAMpB
    ## 51      AAN
    ## 52    AANNF
    ## 53     AAOI
    ## 54     AAON
    ## 55      AAP
    ## 56     AAPB
    ## 57     AAPD
    ## 58     AAPJ
    ## 59     AAPL
    ## 60     AAPT
    ## 61     AAPU
    ## 62    AARTY
    ## 63    AASCF
    ## 64     AASL
    ## 65     AASP
    ## 66    AASZF
    ## 67      AAT
    ## 68     AATC
    ## 69    AATGF
    ## 70     AATP
    ## 71    AATRL
    ## 72     AATV
    ## 73      AAU
    ## 74    AAUGD
    ## 75    AAUKF
    ## 76    AAVMY
    ## 77    AAVVF
    ## 78    AAVXF
    ## 79     AAWH
    ## 80     AAXJ
    ## 81     AAXT
    ## 82    AAYYY
    ## 83       AB
    ## 84    ABAKF
    ## 85    ABANF
    ## 86    ABASF
    ## 87    ABAUF
    ## 88    ABBAF
    ## 89     ABBB
    ## 90    ABBNY
    ## 91    ABBRF
    ## 92     ABBV
    ## 93     ABBY
    ## 94      ABC
    ## 95    ABCAF
    ## 96     ABCB
    ## 97    ABCCF
    ## 98     ABCE
    ## 99    ABCFF
    ## 100    ABCL
    ##                                                                                                                                                  name
    ## 1                                                                                                                           Agilent Technologies Inc.
    ## 2                                                                                                                                   Alcoa Corporation
    ## 3                                                                                                                     AXS First Priority CLO Bond ETF
    ## 4                                                                                                                            ALTERNATIVE INVSTMENT TR
    ## 5                                                                                                                                  AAREAL BANK AG AKT
    ## 6                                                                                                                             AAREAL BANK AG UNSP/ADR
    ## 7                                                                                                              Goldman Sachs Physical Gold ETF Shares
    ## 8                                                                                                                                  ASIA BROADBAND INC
    ## 9                                                                                                                                   ABERDEEN INTL INC
    ## 10                                                                                                                       Ares Acquisition Corporation
    ## 11                         Ares Acquisition Corporation Units, each consisting of one Class A ordinary share, and one-fifth of one redeemable warrant
    ## 12     Ares Acquisition Corporation Redeemable Warrants, each whole warrant exercisable for one Class A ordinary share at an exercise price of $11.50
    ## 13                                                                                                                            AAC TECHS HLDGS INC ORD
    ## 14                                                                                                                           AAC TECHS HLDGS UNSP/ADR
    ## 15                                                                                                   ATA Creativity Global American Depositary Shares
    ## 16                                                                                                            Armada Acquisition Corp. I Common Stock
    ## 17                                                                                                                    Armada Acquisition Corp. I Unit
    ## 18                                                                                                                 Armada Acquisition Corp. I Warrant
    ## 19                                                                                                                           AMER COMMERCE SOLTNS INC
    ## 20                                                                                                                    Ares Acquisition Corporation II
    ## 21                        Ares Acquisition Corporation II Units, each consisting of one Class A ordinary share and one-half of one redeemable warrant
    ## 22  Ares Acquisition Corporation II Redeemable Warrants, each whole warrant exercisable for one Class A ordinary share at an exercise price of $11.50
    ## 23                                                                                                                          AURORA SOLAR TECHNOLOGIES
    ## 24                                                                                                                 Aadi Bioscience, Inc. Common Stock
    ## 25                                                                                                                AdvisorShares Dorsey Wright ADR ETF
    ## 26                                                                                                                                 ALTAIR RES INC ORD
    ## 27                                                                                                                                  AIRTEL AFRICA PLC
    ## 28                                                                                                                             ALL AMERICAN GOLD CORP
    ## 29                                                                                                                                AAG ENERGY HOLDINGS
    ## 30                                                                                                                           AFTERMATH SILVER LTD ORD
    ## 31                                                                                                                               AMERICA GREAT HEALTH
    ## 32                                                                                                                                AIA GROUP LTD S/ADR
    ## 33                                                                                                                          ASTRA AGRO LESTR UNSP/ADR
    ## 34                                                                                                                                   ASAHI CO LTD ORD
    ## 35                                                                                                                   Arlington Asset Investment Corp.
    ## 36                                                    Arlington Asset Investment Corp. 7.00% Series B Cumulative Perpetual Redeemable Preferred Stock
    ## 37                                      Arlington Asset Investment Corp. 8.250% Series C Fixed-to-Floating Rate Cumulative Redeemable Preferred Stock
    ## 38                                                                                                                                  AIA GROUP LTD ORD
    ## 39                                                                                                                             ALABAMA AIRCRAFT INDUS
    ## 40                                                                                      Arlington Asset Investment Corp. 6.000% Senior Notes Due 2026
    ## 41                                                                                                                                 AMERICAN AIRES INC
    ## 42                                                                                                                       American Airlines Group Inc.
    ## 43                                                                                                                              AALBERTS INDUS NV ORD
    ## 44                                                                                                                            ATLAS MARA CO NVEST ORD
    ## 45                                                                                                                         Altisource Asset Mgmt Corp
    ## 46                                                                                                                             Atlantic American Corp
    ## 47                                                                                                                               ALMADEX MINERALS LTD
    ## 48                                                                                                                              ARMADA MERCANTILE LTD
    ## 49                                                                                      Apollo Asset Management, Inc. 6.375% Series A Preferred Stock
    ## 50                                                                                      Apollo Asset Management, Inc. 6.375% Series B Preferred Stock
    ## 51                                                                                                                          The Aaron's Company, Inc.
    ## 52                                                                                                                                  AROUNDTOWN SA ORD
    ## 53                                                                                                                      Applied Optoelectronics, Inc.
    ## 54                                                                                                                                           Aaon Inc
    ## 55                                                                                                                             ADVANCE AUTO PARTS INC
    ## 56                                                                                                            GraniteShares 1.75x Long AAPL Daily ETF
    ## 57                                                                                                                 Direxion Daily AAPL Bear 1X Shares
    ## 58                                                                                                                                            AAP INC
    ## 59                                                                                                                                         Apple Inc.
    ## 60                                                                                                                            ALL AMERICAN PET CO INC
    ## 61                                                                                                               Direxion Daily AAPL Bull 1.5X Shares
    ## 62                                                                                                                              AIRTEL AFRICA PLC ADR
    ## 63                                                                                                                          ABERDEEN ASIAN SMALLR COS
    ## 64                                                                                                                            AMERICA'S SUPPLIERS INC
    ## 65                                                                                                                           GLOBAL ACQUISITIONS CORP
    ## 66                                                                                                                               ATLANTIC SAPPHIRE AS
    ## 67                                                                                                                        AMERICAN ASSETS TRUST, INC.
    ## 68                                                                                                                               AUTOSCOPE TECHS CORP
    ## 69                                                                                                                              ATI AIRTEST TECHS INC
    ## 70                                                                                                                                     AGAPE ATP CORP
    ## 71                                                                                                                           AMG CAP TR II 5.15% CONV
    ## 72                                                                                                                            ADAPTIVE AD SYSTEMS INC
    ## 73                                                                                                                              Almaden Minerals Ltd.
    ## 74                                                                                                                                 ANGOLD RES LTD NEW
    ## 75                                                                                                                                ANGLO AMER PLC ORD.
    ## 76                                                                                                                            ABN AMR BK N V UNSP/ADR
    ## 77                                                                                                                               ADVANTAGE ENERGY LTD
    ## 78                                                                                                                                      ABIVAX SA ORD
    ## 79                                                                                                                          ASCEND WELLNESS HOLDNGS A
    ## 80                                                                                                         iShares MSCI All Country Asia ex Japan ETF
    ## 81                                                                                                                          AAMAXAN TRANSPORT GRP INC
    ## 82                                                                                                                          AUSTRALIAN AGRCL UNSP/ADR
    ## 83                                                                                                                    AllianceBernstein Holding, L.P.
    ## 84                                                                                                                           ABRDN ASIA-PAC INCOME FD
    ## 85                                                                                                                            AUTOMATIC BANK SERVICES
    ## 86                                                                                                                                            ALBA SE
    ## 87                                                                                                                                  A2B AUSTRALIA LTD
    ## 88                                                                                                                            ABRDN ASIAN INCOME FUND
    ## 89                                                                                                                                 AUBURN BANCORP INC
    ## 90                                                                                                                                  ABB LTD SPONS ADR
    ## 91                                                                                                                           ABRASILVER RESOURCE CORP
    ## 92                                                                                                                                        ABBVIE INC.
    ## 93                                                                                                                                           ABBY INC
    ## 94                                                                                                                            AmerisourceBergen Corp.
    ## 95                                                                                                                             ATHABASCA MINERALS INC
    ## 96                                                                                                                                     Ameris Bancorp
    ## 97                                                                                                                               ABC ARBITRAGE SA ORD
    ## 98                                                                                                                                    ABCO ENERGY INC
    ## 99                                                                                                                           ABACUS MINING & EXPL ORD
    ## 100                                                                                                            AbCellera Biologics Inc. Common Shares
    ##     market locale primary_exchange    type active currency_name        cik
    ## 1   stocks     us             XNYS      CS   TRUE           usd 0001090872
    ## 2   stocks     us             XNYS      CS   TRUE           usd 0001675149
    ## 3   stocks     us             ARCX     ETF   TRUE           usd 0001776878
    ## 4      otc     us             <NA>    FUND   TRUE           USD       <NA>
    ## 5      otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 6      otc     us             <NA>    ADRC   TRUE           USD       <NA>
    ## 7   stocks     us             BATS     ETF   TRUE           usd 0001708646
    ## 8      otc     us             <NA>      CS   TRUE           USD       <NA>
    ## 9      otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 10  stocks     us             XNYS      CS   TRUE           usd 0001829432
    ## 11  stocks     us             XNYS    UNIT   TRUE           usd 0001829432
    ## 12  stocks     us             XNYS WARRANT   TRUE           usd 0001829432
    ## 13     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 14     otc     us             <NA>    ADRC   TRUE           USD       <NA>
    ## 15  stocks     us             XNAS    ADRC   TRUE           usd 0001420529
    ## 16  stocks     us             XNAS      CS   TRUE           usd 0001844817
    ## 17  stocks     us             XNAS    UNIT   TRUE           usd 0001844817
    ## 18  stocks     us             XNAS WARRANT   TRUE           usd 0001844817
    ## 19     otc     us             <NA>      CS   TRUE           USD       <NA>
    ## 20  stocks     us             XNYS      CS   TRUE           usd 0001853138
    ## 21  stocks     us             XNYS    UNIT   TRUE           usd 0001853138
    ## 22  stocks     us             XNYS WARRANT   TRUE           usd 0001853138
    ## 23     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 24  stocks     us             XNAS      CS   TRUE           usd 0001422142
    ## 25  stocks     us             XNAS     ETF   TRUE           usd 0001408970
    ## 26     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 27     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 28     otc     us             <NA>      CS   TRUE           USD       <NA>
    ## 29     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 30     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 31     otc     us             <NA>      CS   TRUE           USD       <NA>
    ## 32     otc     us             <NA>    ADRC   TRUE           USD       <NA>
    ## 33     otc     us             <NA>    ADRC   TRUE           USD       <NA>
    ## 34     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 35  stocks     us             XNYS      CS   TRUE           usd 0001209028
    ## 36  stocks     us             XNYS     PFD   TRUE           usd 0001209028
    ## 37  stocks     us             XNYS     PFD   TRUE           usd 0001209028
    ## 38     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 39     otc     us             <NA>      CS   TRUE           USD       <NA>
    ## 40  stocks     us             XNYS      SP   TRUE           usd 0001209028
    ## 41     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 42  stocks     us             XNAS      CS   TRUE           usd 0000006201
    ## 43     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 44     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 45  stocks     us             XASE      CS   TRUE           usd 0001555074
    ## 46  stocks     us             XNAS      CS   TRUE           usd 0000008177
    ## 47     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 48     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 49  stocks     us             XNYS     PFD   TRUE           usd 0001411494
    ## 50  stocks     us             XNYS     PFD   TRUE           usd 0001411494
    ## 51  stocks     us             XNYS      CS   TRUE           usd 0001821393
    ## 52     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 53  stocks     us             XNAS      CS   TRUE           usd 0001158114
    ## 54  stocks     us             XNAS      CS   TRUE           usd 0000824142
    ## 55  stocks     us             XNYS      CS   TRUE           usd 0001158449
    ## 56  stocks     us             XNAS     ETS   TRUE           usd 0001689873
    ## 57  stocks     us             XNAS     ETS   TRUE           usd       <NA>
    ## 58     otc     us             <NA>      CS   TRUE           USD       <NA>
    ## 59  stocks     us             XNAS      CS   TRUE           usd 0000320193
    ## 60     otc     us             <NA>      CS   TRUE           USD       <NA>
    ## 61  stocks     us             XNAS     ETS   TRUE           usd       <NA>
    ## 62     otc     us             <NA>    ADRC   TRUE           USD       <NA>
    ## 63     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 64     otc     us             <NA>      CS   TRUE           USD       <NA>
    ## 65     otc     us             <NA>      CS   TRUE           USD       <NA>
    ## 66     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 67  stocks     us             XNYS      CS   TRUE           usd 0001500217
    ## 68     otc     us             <NA>      CS   TRUE           USD       <NA>
    ## 69     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 70     otc     us             <NA>      CS   TRUE           USD       <NA>
    ## 71     otc     us             <NA>     PFD   TRUE           USD       <NA>
    ## 72     otc     us             <NA>      CS   TRUE           USD       <NA>
    ## 73  stocks     us             XASE      CS   TRUE           usd 0001015647
    ## 74     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 75     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 76     otc     us             <NA>    ADRC   TRUE           USD       <NA>
    ## 77     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 78     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 79     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 80  stocks     us             XNAS     ETF   TRUE           usd 0001100663
    ## 81     otc     us             <NA>      CS   TRUE           USD       <NA>
    ## 82     otc     us             <NA>    ADRC   TRUE           USD       <NA>
    ## 83  stocks     us             XNYS      CS   TRUE           usd 0000825313
    ## 84     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 85     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 86     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 87     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 88     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 89     otc     us             <NA>      CS   TRUE           USD       <NA>
    ## 90     otc     us             <NA>    ADRC   TRUE           USD       <NA>
    ## 91     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 92  stocks     us             XNYS      CS   TRUE           usd 0001551152
    ## 93     otc     us             <NA>      CS   TRUE           USD       <NA>
    ## 94  stocks     us             XNYS      CS   TRUE           usd 0001140859
    ## 95     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 96  stocks     us             XNAS      CS   TRUE           usd 0000351569
    ## 97     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 98     otc     us             <NA>      CS   TRUE           USD       <NA>
    ## 99     otc     us             <NA>      OS   TRUE           USD       <NA>
    ## 100 stocks     us             XNAS      CS   TRUE           usd 0001703057
    ##     composite_figi share_class_figi         last_updated_utc
    ## 1     BBG000C2V3D6     BBG001SCTQY4     2023-06-22T00:00:00Z
    ## 2     BBG00B3T3HD3     BBG00B3T3HF1     2023-06-22T00:00:00Z
    ## 3     BBG01B0JRCS6     BBG01B0JRCT5     2023-06-22T00:00:00Z
    ## 4             <NA>             <NA> 2022-08-26T05:00:07.114Z
    ## 5             <NA>             <NA> 2022-04-01T06:49:22.884Z
    ## 6     BBG002628DF1     BBG002628F57 2023-05-04T05:00:29.876Z
    ## 7     BBG00LPXX872     BBG00LPXX8Z1     2023-06-22T00:00:00Z
    ## 8     BBG000CWNRN5     BBG001SGRBK5 2023-04-17T05:00:24.252Z
    ## 9     BBG000BXKHJ4     BBG001S6XZ90 2023-05-10T05:00:36.305Z
    ## 10            <NA>             <NA>     2023-06-22T00:00:00Z
    ## 11            <NA>             <NA>     2023-06-22T00:00:00Z
    ## 12            <NA>             <NA>     2023-06-22T00:00:00Z
    ## 13            <NA>             <NA> 2022-06-24T14:14:05.429Z
    ## 14    BBG000VNTB62     BBG001T3PT80 2023-04-14T05:00:16.614Z
    ## 15    BBG000V2S3P6     BBG001T125S9     2023-06-22T00:00:00Z
    ## 16    BBG011XR7306     BBG011XR7315     2023-06-22T00:00:00Z
    ## 17    BBG011PFP1D1     BBG011PFP285     2023-06-22T00:00:00Z
    ## 18    BBG011XRPQV1             <NA>     2023-06-22T00:00:00Z
    ## 19    BBG000JVQ2Q9     BBG001SBV1Z7 2021-10-08T08:45:19.015Z
    ## 20            <NA>             <NA>     2023-06-22T00:00:00Z
    ## 21            <NA>             <NA>     2023-06-22T00:00:00Z
    ## 22            <NA>             <NA>     2023-06-22T00:00:00Z
    ## 23    BBG005BTJ9X6     BBG001STZM33 2022-08-12T05:00:19.436Z
    ## 24    BBG002WN7DT2     BBG002WN7DV9     2023-06-22T00:00:00Z
    ## 25    BBG000BDYRW6     BBG001T9B1Y4     2023-06-22T00:00:00Z
    ## 26    BBG002DMMHW5     BBG001SPCXW0 2023-05-10T05:00:36.805Z
    ## 27            <NA>             <NA> 2022-09-30T14:57:35.719Z
    ## 28    BBG000R4MM71     BBG001T948W9 2023-05-10T05:00:37.105Z
    ## 29            <NA>             <NA> 2022-04-19T06:54:24.347Z
    ## 30    BBG001ZZWS68     BBG001V0ZJL9 2023-04-19T05:00:26.883Z
    ## 31    BBG003443HQ1     BBG003443JG8 2023-05-04T05:00:30.176Z
    ## 32    BBG001R3QP52     BBG001V28NN4 2022-07-13T16:04:56.902Z
    ## 33    BBG000KF9H79     BBG001T8KP46 2023-05-04T05:00:30.876Z
    ## 34            <NA>             <NA> 2021-09-28T00:10:58.475Z
    ## 35    BBG000BD1373     BBG001S6DRN4     2023-06-22T00:00:00Z
    ## 36            <NA>             <NA>     2023-06-22T00:00:00Z
    ## 37            <NA>             <NA>     2023-06-22T00:00:00Z
    ## 38            <NA>             <NA> 2022-07-13T16:04:35.488Z
    ## 39    BBG000HPGHW5     BBG001SD4Q88 2021-09-28T00:08:41.075Z
    ## 40            <NA>             <NA>     2023-06-22T00:00:00Z
    ## 41    BBG00RD2H0V8     BBG00L8QSZF3 2023-05-10T05:00:37.305Z
    ## 42    BBG005P7Q881     BBG005P7Q907     2023-06-22T00:00:00Z
    ## 43            <NA>             <NA> 2021-09-28T00:10:12.175Z
    ## 44            <NA>             <NA> 2021-12-10T07:30:30.598Z
    ## 45    BBG003PNL136     BBG003PNL145     2023-06-22T00:00:00Z
    ## 46    BBG000B9XB24     BBG001S5N8T1     2023-06-22T00:00:00Z
    ## 47    BBG00L1LR0B3     BBG00K66WBV1 2022-12-06T19:15:00.033Z
    ## 48    BBG000K7V8F3     BBG001S6TJ73 2022-02-09T06:00:51.234Z
    ## 49            <NA>             <NA>     2023-06-22T00:00:00Z
    ## 50            <NA>             <NA>     2023-06-22T00:00:00Z
    ## 51    BBG00WCNDCZ6     BBG00WCNDDH4     2023-06-22T00:00:00Z
    ## 52            <NA>             <NA> 2021-09-28T08:45:23.537Z
    ## 53    BBG000D6VW15     BBG001SG47G4     2023-06-22T00:00:00Z
    ## 54    BBG000C2LZP3     BBG001S6CZK0     2023-06-22T00:00:00Z
    ## 55    BBG000F7RCJ1     BBG001SD2SB2     2023-06-22T00:00:00Z
    ## 56    BBG0193F21N2     BBG0193F22H7     2023-06-22T00:00:00Z
    ## 57    BBG0193YGJ57     BBG0193YGK09     2023-06-22T00:00:00Z
    ## 58    BBG000BHS5L4     BBG001S6BY24 2023-04-18T05:00:19.569Z
    ## 59    BBG000B9XRY4     BBG001S5N8V8     2023-06-22T00:00:00Z
    ## 60    BBG000R7ZH35     BBG001SM7HC0 2023-06-21T05:00:35.127Z
    ## 61    BBG0193YBZ92     BBG0193YC043     2023-06-22T00:00:00Z
    ## 62    BBG0175XTW30     BBG0175XTWY6 2022-05-05T18:02:26.736Z
    ## 63            <NA>             <NA> 2023-01-30T07:41:01.424Z
    ## 64    BBG000JMM577     BBG001SBFJH6 2022-11-18T07:52:04.566Z
    ## 65    BBG000K2W621     BBG001S7JJF3 2023-05-04T05:00:32.276Z
    ## 66            <NA>             <NA> 2023-05-19T15:59:27.257Z
    ## 67    BBG00161BCR0     BBG001TCBJS5     2023-06-22T00:00:00Z
    ## 68    BBG011MC2100     BBG011MC2119 2023-05-15T05:00:39.208Z
    ## 69    BBG000DPPB70     BBG001S77XD7 2023-05-10T05:00:38.205Z
    ## 70    BBG00HKYNJT7     BBG00HKYNJV4 2023-04-28T05:00:20.465Z
    ## 71            <NA>             <NA> 2021-09-28T00:08:42.275Z
    ## 72    BBG000DQDZ96     BBG001SGH8Q7 2023-05-01T05:00:22.505Z
    ## 73    BBG000DGFSY4     BBG001S7VVD4     2023-06-22T00:00:00Z
    ## 74    BBG00ZNSRJ77     BBG001SF6B93 2023-06-07T13:56:11.593Z
    ## 75            <NA>             <NA> 2023-02-15T15:49:20.594Z
    ## 76    BBG00PXGLFG8     BBG00PXGLG67 2022-08-15T05:00:49.252Z
    ## 77    BBG000C5QZ62     BBG001SDWVG7 2022-08-15T05:01:10.752Z
    ## 78            <NA>             <NA> 2023-06-12T06:44:12.258Z
    ## 79    BBG00P4VKXR7     BBG010JWLP17 2023-05-12T16:21:24.043Z
    ## 80    BBG000G6GXC5     BBG001T2V2D8     2023-06-22T00:00:00Z
    ## 81    BBG000BSVKZ8     BBG001SFRD87 2021-04-08T05:00:10.436Z
    ## 82    BBG002CND6S3     BBG002CND7J1 2023-05-04T05:00:33.376Z
    ## 83    BBG000B9WM03     BBG001S5N9S0     2023-06-22T00:00:00Z
    ## 84            <NA>             <NA> 2023-05-04T05:00:34.476Z
    ## 85            <NA>             <NA> 2021-09-29T08:45:24.326Z
    ## 86            <NA>             <NA> 2022-08-15T06:56:05.352Z
    ## 87            <NA>             <NA> 2023-04-05T11:06:56.183Z
    ## 88            <NA>             <NA> 2022-10-27T16:04:44.953Z
    ## 89    BBG000BMSFK2     BBG001SPRY52 2023-04-28T05:00:21.265Z
    ## 90    BBG000DK5Q25     BBG001SDDMX9 2023-05-23T11:53:18.415Z
    ## 91    BBG00GBV2HN8     BBG001S60949  2023-03-02T20:00:42.43Z
    ## 92    BBG0025Y4RY4     BBG0025Y4RZ3     2023-06-22T00:00:00Z
    ## 93    BBG001M8FVR1     BBG001V10SY1 2021-09-28T00:12:47.975Z
    ## 94    BBG000MDCQC2     BBG001S8X7P0     2023-06-22T00:00:00Z
    ## 95    BBG005K4ZL84     BBG001SQHLR5 2023-05-10T05:00:38.505Z
    ## 96    BBG000CDY3H5     BBG001S80PX7     2023-06-22T00:00:00Z
    ## 97            <NA>             <NA> 2021-09-28T00:10:09.075Z
    ## 98    BBG000M1SPF0     BBG001SK7PJ9 2022-09-28T21:16:48.383Z
    ## 99    BBG000JR8L77     BBG001S5XSV3 2023-05-10T05:00:38.805Z
    ## 100   BBG00LLW2MF2     BBG00LLW2MH0     2023-06-22T00:00:00Z
