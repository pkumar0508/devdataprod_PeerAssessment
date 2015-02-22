library(quantmod)
library(ggplot2)

earlyDate <- "1925-01-01"
today <- as.character(Sys.Date())

lagpad <- function(x, k) {
  c(rep(NA, k), x)[1 : length(x)] 
}

getS <- function(t, n) {
  e <- data.frame(Ticker=character(), dates=character(), r=numeric())
  if (t == ' ' || t == '') {
    return(e)
  }
  s <- getSymbols(t, src = "yahoo",
             from = earlyDate, to = today, auto.assign = FALSE)
  dates <- index(s)
  v <- as.data.frame(s)[,6]
  vlag <- lagpad(v, n * 252)
  r_annual <- ((v / vlag) ^ (1/ n) - 1) * 100
  d <- cbind(data.frame(Ticker = t),
             data.frame(dates = dates, r = r_annual))
  return(d)
}

shinyServer(function(input, output) {
  fund1 <- reactive({ getS(input$fund1, input$lookback) })
  fund2 <- reactive({ getS(input$fund2, input$lookback) })
  fund3 <- reactive({ getS(input$fund3, input$lookback) })
  symb1 <- reactive({ getS(input$symb1, input$lookback) })
  symb2 <- reactive({ getS(input$symb2, input$lookback) })
  symb3 <- reactive({ getS(input$symb3, input$lookback) })
  output$plot <- renderPlot({
    d <- fund1()
    d <- rbind(d, fund2())
    d <- rbind(d, fund3())
    d <- rbind(d, symb1())
    d <- rbind(d, symb2())
    d <- rbind(d, symb3())
    p <- ggplot(d, aes(x=dates, y=r,color=Ticker,group=Ticker)) +
      geom_line() + xlab('Date') + ylab("Annualized Return") +
      xlim(input$dates)
    print(p)
  })
})