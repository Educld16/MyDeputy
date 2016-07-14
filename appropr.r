recs <- function(VF,VA,UV,W)
{
  weights<-W
  vote_for<-VF
  vote_against<-VA
  for(x in 1:length(weights)){
    vote_for[,x]=vote_for[,x]*weights[x]
    vote_against[,x]=vote_against[,x]*weights[x]
  }
  user_vote<-UV
  mat <-  (t(vote_for) * user_vote)  +   (t(vote_against) * ! user_vote )
  perc_appr<-unname(apply( mat , 2 , mean))
  return(perc_appr)
}
