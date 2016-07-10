library(shiny)
library(rCharts)

shinyUI(fluidPage(
  
    titlePanel("\u041a\u0430\u043a\u0430\u044f \u043f\u0430\u0440\u0442\u0438\u044f \u0432\u0430\u043c \u043f\u043e\u0434\u0445\u043e\u0434\u0438\u0442\u003f"),
  
    navlistPanel(
      tabPanel("\u0421\u0442\u0430\u0442\u0438\u0441\u0442\u0438\u043a\u0430",
               mainPanel(
                 selectInput('law', '\u0412\u044b\u0431\u0435\u0440\u0438\u0442\u0435 \u0069\u0064 \u0437\u0430\u043a\u043e\u043d\u043e\u043f\u0440\u043e\u0435\u043a\u0442\u0430\u003a', 
                                     as.character(unique(datd$law_id4, incomparables = FALSE, fromLast = FALSE))),
                 showOutput("myChart", "highcharts")
              )
      ),
      tabPanel("\u0420\u0435\u043a\u043e\u043c\u0435\u043d\u0434\u0430\u0446\u0438\u0438",
                checkboxGroupInput('law_1', '\u0412\u044b\u0431\u0435\u0440\u0438\u0442\u0435 \u0437\u0430\u043a\u043e\u043d\u043e\u043f\u0440\u043e\u0435\u043a\u0442\u044b\u002c \u043a\u043e\u0442\u043e\u0440\u044b\u0435 \u0432\u044b \u0431\u044b \u0445\u043e\u0442\u0435\u043b\u0438 \u043f\u043e\u0434\u0434\u0435\u0440\u0436\u0430\u0442\u044c\u003a',
                             as.character(unique(datd$law_id4, incomparables = FALSE, fromLast = FALSE))),
               showOutput("recChart", "highcharts")
      )
    )
  ))
  

