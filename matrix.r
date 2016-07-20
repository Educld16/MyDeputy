amountofpar <- 0
    amountofpar[1] <- length(datd$law_id4[datd$law_id4 == datd$law_id4[1]])
    amountofdep <- numeric(amountofpar[1])
    for(k in 1:amountofpar[1]){
      amountofdep[k] <- datd$V1[k] + datd$V2[k]+datd$V3[k]+datd$V4[k]+datd$V5[k]
    }
    amountoflaw <- 1
    z <- 1
    temp <- datd$law_id4[1]
    while(z != length(datd$law_id4)){
      if(temp != datd$law_id4[z]){
        temp <- datd$law_id4[z]
        amountoflaw <- amountoflaw + 1
      }
      z <- z+1
    }
    rm(z)
    rm(temp)
    m1 <- matrix(data=0, nr=amountofpar[1], nc=amountoflaw[1])
    m2 <- matrix(data=0, nr=amountofpar[1], nc=amountoflaw[1])
    k<- 1
    multipl<- c(0.15, 0.1, 0.05, 0.85, 0.9, 0.95)
    for(i in 1:amountoflaw[1]){
      for(j in 1:amountofpar[1]){
        m1[j,i] <- (as.integer(((datd$V1[k]+datd$V3[k]*multipl[1]+datd$V4[k]*multipl[2]+datd$V5[k]*multipl[3])/amountofdep[j])*1000))/10
        k<- k+1
      }
    }
    rm(k)
    k<- 1
    for(i in 1:amountoflaw[1]){
      for(j in 1:amountofpar[1]){
        m2[j,i] <- (as.integer(((datd$V2[k]+datd$V3[k]*multipl[4]+datd$V4[k]*multipl[5]+datd$V5[k]*multipl[6])/amountofdep[j])*1000))/10
        k<- k+1
      }
    }
    rm(k)
