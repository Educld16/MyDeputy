library(shiny)
library(rCharts)
percents=T  # stats tab option
datd <- read.csv("all.csv", sep=",", stringsAsFactors=FALSE)
catg <- c("\u0417\u0430", "\u041f\u0440\u043e\u0442\u0438", "\u0423\u0442\u0440\u0438\u043c\u0430\u043b\u0438\u0441\u044c", "\u041d\u0435 \u0433\u043e\u043b\u043e\u0441\u0443\u0432\u0430\u043b\u0438", "\u0412\u0456\u0434\u0441\u0443\u0442\u043d\u0456")
vcolor<-c("#caf2f1", "#a7e5ef", "#66d1e4", "#50cbe0",
          "#3ac4dc", "#26bdd7", "#22aac1", "#1e97ac", "#1b8496")
vlabels<-unique(datd$party4)
law_ids<-unique(datd$law_id4)
uvd <- data.frame(law_id=law_ids,vote=rep(-1,length(law_ids)))
source('appropr.r')
shinyServer(function(input, output) {
  output$myChart <- renderChart2({
    d<-datd[datd$law_id4==input$law,]
    b <- Highcharts$new()
    b$chart(type = "column")
    b$title(text = "")
    b$xAxis(categories = vlabels)
    vcolor<-c("#caf2f1", "#a7e5ef", "#66d1e4", "#22aac1", "#1b8496")
    if (percents){
      for(i in 1:5){
        d[[paste("VV",i,sep="")]]<-
          apply(d[,c("V1", "V2", "V3", "V4", "V5")], 1, function(x){return(round(x[paste("V",i,sep="")]/sum(x)*100,2))})
      }
      for(i in 1:5){
        d[[paste("V",i,sep="")]] <- d[[paste("VV",i,sep="")]]
      }
    }
    for(i in 1:5){
      b$series(name = catg[i], data=unname(d[,c(paste("V",i,sep=""))]), color=vcolor[i])
    }
    return(b)
  })
  output$recChart <- renderChart2({
    source('matrix.r')  # matrix generator code
    VF<-m1
    VA<-m2
    law_choices<-input$law_1
    law_ids<-unique(datd$law_id4)
    UV<-dat$uv$vote
    W<-c(0.6,0.8,0.9,0.7)  # test weights
    for(x in 1:length(law_ids)){  # read values from sliders
      num<-law_ids[x]
      t<-input[[paste("slider_",num,sep="")]]
      if(t) W[x]<-t/10
    }
    for(x in 1:length(W)){  # remove unuseful laws
      if(UV[x]==-1){
        W[x]=0
      }
    }
    perc_appr <- recs(VF,VA,UV,W)  # get recommendations
    a <- rCharts:::Highcharts$new()
    a$chart(type = "column")
    a$title(text = "Recommendation")
    label_perc<-data.frame(vl=vlabels, p=perc_appr)
    sorted_label_perc<- label_perc[sort.list(label_perc[,2], decreasing = TRUE),]
    percent<-(sorted_label_perc[,2])
    labels<-as.character(sorted_label_perc[,1])
    a$xAxis(categories =labels)
    a$yAxis(title = list(text = "Percent"))
    a$series(data = list(
      list(y = percent[1], color = vcolor[9]),
      list(y = percent[2], color = vcolor[8]),
      list(y = percent[3], color = vcolor[7]),
      list(y = percent[4], color = vcolor[6]),
      list(y = percent[5], color = vcolor[5]),
      list(y = percent[6], color = vcolor[4]),
      list(y = percent[7], color = vcolor[3]),
      list(y = percent[8], color = vcolor[2]),
      list(y = percent[9], color = vcolor[1])
    ), name = 'Percent of appropriation', color="white")
    return(a)
  })
  d <- reactive({
    uvd
  })
  
  dat <- reactiveValues(uv=NULL)
  observe({
    dat$uv <- d()
  })
  
  lapply(unique(datd$law_id4), function(x){
    observeEvent(input[[paste("but1_",x,sep="")]], {
       dat$uv[dat$uv$law_id==x,]$vote = 1
     });
    observeEvent(input[[paste("but2_",x,sep="")]], {
       dat$uv[dat$uv$law_id==x,]$vote = 0
     })
  })
})