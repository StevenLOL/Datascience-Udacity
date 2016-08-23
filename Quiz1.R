setwd("/Users/johnryanzelling/Downloads")
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(
        fileurl,
        destfile = "problem1.csv",
        method = "curl"
)
prob1 <- read.csv("problem1.csv", header = TRUE)
ans <- prob1$VAL
gtmil <- ans[ans==24]
gtmil <- gtmil[ !is.na(gtmil) ]
length( gtmil )


#install.packages("xlsx")
library(xlsx)
setwd("/Users/johnryanzelling/Downloads")
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(
        fileurl,
        destfile = "problem.xlsx",
        method = "curl"
)
colIndex <- 7:15
rowIndex <- 18:23
prob2 <- read.xlsx( "problem.xlsx", 
                    sheetIndex = 1, 
                    header = TRUE,
                    colIndex = colIndex,
                    rowIndex = rowIndex
                    )
sum(prob2$Zip*prob2$Ext,na.rm=T)


install.packages("XML")
library(XML)
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
prob3 <- xmlTreeParse( fileurl, useInternal = TRUE )
rootNode <- xmlRoot( prob3 )
xmlName( rootNode ) 
names( rootNode )

install.packages("data.table")
library(data.table)
setwd("/Users/johnryanzelling/Downloads")
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(
        fileurl,
        destfile = "problem.csv",
        method = "curl"
)
DT <- fread("problem.csv")

x1 <- Sys.time()
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
y1 <- Sys.time()

x2 <- Sys.time()
sapply(split(DT$pwgtp15,DT$SEX),mean)
y2 <- Sys.time()

x3 <- Sys.time()
DT[,mean(pwgtp15),by=SEX]
y3 <- Sys.time()

x4 <- Sys.time()
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
y4 <- Sys.time()

x5 <- Sys.time()
tapply(DT$pwgtp15,DT$SEX,mean)
y5 <- Sys.time()

x6 <- Sys.time()
mean(DT$pwgtp15,by=DT$SEX)
y6 <- Sys.time()

x1-y1
x2-y2
x3-y3
x4-y4
x5-y5
x6-y6
