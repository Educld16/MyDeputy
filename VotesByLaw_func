function(VF.matrix,VA.matrix,UV.vector){
  vote_for<-VF
  vote_against<-VA
  user_vote<-UV
  mat <-  unname((t(VF) * UV )  +   (t(VA) * ! UV ))
  b <- rCharts:::Highcharts$new()
  b$chart(type = "column")
  
  
  vcolor<-c("#caf2f1", "#a7e5ef", "#66d1e4", "#50cbe0",
            "#3ac4dc", "#26bdd7", "#22aac1", "#1e97ac", "#1b8496")
  
  vlabels<-c("asd","zxc","vbn","fgh","rty", "rty","qwe","hjk","wer")
  vlaws<-c("law 1","law 2","law 3","law 4")
  b$xAxis(categories = vlaws)
  b$yAxis(title = list(text = "Percent"))
  len=length(vlabels)
   for(i in 1:len){
    b$series(data = list( mat[1,i],mat[2,i],mat[3,i],mat[4,i])
  , name = vlabels[i], color=vcolor[i])
  }
  b}
