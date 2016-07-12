library(shiny)
library(rCharts)

shinyUI(fluidPage(
  tags$head(
    tags$style(HTML("
                    .irs-bar {
                       width: 100%; 
                        background: linear-gradient(to right, yellow , red); 
                        border-top: 1px solid black; 
                        border-bottom: 1px solid black;}
                    .irs-bar-edge {background: yellow;
                        border-top: 1px solid black; 
                        border-bottom: 1px solid black;
                        border-left: 1px solid black ;}
                    .irs-grid-text {color: black;}
                    .irs-grid-pol {background: black; width: 1px;}
                    .irs-max {color: black;}
                    .irs-min {color: black;}
                    .irs-single {color:black; background:none;}
                    "))
    ),
  
  
    titlePanel("\u041a\u0430\u043a\u0430\u044f \u043f\u0430\u0440\u0442\u0438\u044f \u0432\u0430\u043c \u043f\u043e\u0434\u0445\u043e\u0434\u0438\u0442\u003f"),
  
    tabsetPanel(
      tabPanel("\u0421\u0442\u0430\u0442\u0438\u0441\u0442\u0438\u043a\u0430",
               mainPanel(
                 selectInput('law', '\u0412\u044b\u0431\u0435\u0440\u0438\u0442\u0435 \u0069\u0064 \u0437\u0430\u043a\u043e\u043d\u043e\u043f\u0440\u043e\u0435\u043a\u0442\u0430\u003a', 
                    as.character(unique(datd$law_id4, incomparables = FALSE, fromLast = FALSE))
                 ),
                 showOutput("myChart", "highcharts")
               )
      ),
      tabPanel("\u0420\u0435\u043a\u043e\u043c\u0435\u043d\u0434\u0430\u0446\u0438\u0438",
                checkboxGroupInput('law_1', '\u0412\u044b\u0431\u0435\u0440\u0438\u0442\u0435 \u0437\u0430\u043a\u043e\u043d\u043e\u043f\u0440\u043e\u0435\u043a\u0442\u044b\u002c \u043a\u043e\u0442\u043e\u0440\u044b\u0435 \u0432\u044b \u0431\u044b \u0445\u043e\u0442\u0435\u043b\u0438 \u043f\u043e\u0434\u0434\u0435\u0440\u0436\u0430\u0442\u044c\u003a',
                             as.character(unique(datd$law_id4, incomparables = FALSE, fromLast = FALSE))),
               
                 lapply(top_law_keks$name, function(x)
                   verticalLayout(
                     wellPanel(
                     h3(x),
                     
                     sliderInput("law", h5("\u0423\u043a\u0430\u0436\u0438\u0442\u0435 \u0432\u0430\u0436\u043d\u043e\u0441\u0442\u044c \u0437\u0430\u043a\u043e\u043d\u0430 \u0434\u043b\u044f \u0432\u0430\u0441\u003a"), min=0, max=10, value=0, width = '500px'),
                     h5("\u041a\u0430\u043a \u0431\u044b \u0432\u044b \u0445\u043e\u0442\u0435\u043b\u0438 \u043f\u0440\u043e\u0433\u043e\u043b\u043e\u0441\u043e\u0432\u0430\u0442\u044c\u003a"),
                     flowLayout(
                       
                      
                      actionButton("but1", label = NULL, icon("ic1", class = "glyphicon glyphicon-ok", lib = "glyphicon"), width = '100px', style="color: #fff; background-color: green; border-color: green" ),
                      actionButton("but2", label = NULL, icon("ic2", class = "glyphicon-remove", lib = "glyphicon"), width = '100px', style="color: #fff; background-color: red; border-color: red" )
                     )
                     )
                   )
                  ),
               showOutput("recChart", "highcharts")
      )
    )
  ))
  

