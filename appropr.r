 function(VF.matrix,VA.matrix,UV.vector)
   {
     vote_for<-VF 
     vote_against<-VA
     user_vote<-UV
     mat <-  (t(vote_for) * user_vote )  +   (t(vote_against) * ! user_vote )
     perc_appr<-unname(apply( mat , 2 , mean))
     a <- rCharts:::Highcharts$new()
     a$chart(type = "column")
     a$title(text = "Recommendation")
     
     vcolor<-c("#caf2f1", "#a7e5ef", "#66d1e4", "#50cbe0",
               "#3ac4dc", "#26bdd7", "#22aac1", "#1e97ac", "#1b8496")
     
     vlabels<-c("asd","zxc","vbn","fgh","rty", "esy","qwe","hjk","wer")
     
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
     a
   }