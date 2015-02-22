library(shiny)

vanguard_funds <- list("Select a fund" = " ",
                       "Total Stock Market (VTSMX, 1992)" = "VTSMX",
                       "Total Bond Market (VBMFX, 1986)" = "VBMFX",
                       "S&P 500 (Large-cap) (VFINX, 1976)" = "VFINX",
                       "Mid-cap (VIMSX, 1998)" = "VIMSX",
                       "Small-cap (NAESX, 1960)" = "NAESX",
                       "GNMA (VFIIX, 1980)" = "VFIIX",
                       "Long-term Bond (VBLTX, 1994)" = "VBLTX",
                       "Intermediate-term Bond (VBIIX, 1994)" = "VBIIX",
                       "Short-term Bond (VBISX, 1994)" = "VBISX",
                       "Long-term Treasury (VUSTX, 1986)" = "VUSTX",
                       "Intermediate-term Treasury (VFITX, 1991)" = "VFITX",
                       "Short-term Treasury (VFISX, 1991)" = "VFISX",
                       "Intermediate-term Investment-Grade (VFICX, 1993)" = "VFICX",
                       "Long-term Investment-Grade (VWESX, 1973)" = "VWESX",
                       "Short-term Investment-Grade (VFSTX, 1982)" = "VFSTX",
                       "High-yield Corporate (VWEHX, 1978)" = "VWEHX",
                       "Wellesley Income (VWINX, 1970)" = "VWINX",
                       "Wellington (VWELX, 1929)" = "VWELX")

shinyUI(fluidPage(
  titlePanel("Annual Yield Plotter"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("lookback", label = "Lookback period", min = 1, 
                  max = 15, value = 10),
      hr(),
      selectInput("fund1", label = "Fund 1",
                  choices = vanguard_funds[2:length(vanguard_funds)]),
      selectInput("fund2", label = "Fund 2",
                  choices = vanguard_funds),
      selectInput("fund3", label = "Fund 3",
                  choices = vanguard_funds),
      hr(),
      textInput("symb1", "Other Symbol 1", ""),
      textInput("symb2", "Other Symbol 2", ""),
      textInput("symb3", "Other Symbol 3", ""),
      dateRangeInput("dates", 
        "Date range",
        start = "2005-01-01", 
        end = as.character(Sys.Date()))
    ),
    mainPanel(
      plotOutput("plot"),
      p('This app plots the performance of various Vanguard funds
        or other tickers to give you an
        idea how specific investments performed historically in terms of
        a standardized metric: annual yield.'),
      p('First, select a lookback period. A value of 10 means that a
        point on the plot at 2015-01-01 will use the return of the
        10-year period ending in 2015-01-01. You should be able to get
        a sense from playing around with this parameter that
        the return of a particular ticker in a given year is fairly
        unpredictable, but longer holding periods, a more predictable
        average emerges.'),
      p('Select some
        Vanguard funds to compare. There are a mix of stock, bond, and
        blended funds. How volatile are the long-term yields?'),
      p('You can input up to three different Yahoo finance tickers and
        see performance comparisons with those as well. Note that if
        you have a long lookback period, and the ticker you chose has
        a short history, you may not see much or any performance to
        compare.'),
      p('You can also modify the date range of the plot. For tickers
        that have a longer history available, you can see more of what
        those historical yields were.'),
      p('Remember: Past performance is not a guarantee of future results.')
  ))
))