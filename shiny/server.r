set.seed(1433)
library("ggplot2")
library("data.table")

library("plyr")
library("dplyr")
dateDownloaded<- date()

shinyServer(
        function(input, output) {
               query <- reactive({
                       
                        if (input$chk1 == 1)
                        { query= "year"
                          
                        }
                        
                        if (input$chk1 == 2)
                        { query= "age"
                          
                        }
                        if (input$chk1 == 3)
                        { query= "educ"
                          
                        }
                        query<- query

                 })
               
               iOff <- reactive({
                       if (input$chk1 == 1)
                       { 
                               iOff = 1972
                       }
                       else
                       { 
                               iOff  = 0
                       }
                       iOff = iOff
               })               
                output$newPlot <- renderPlot({
                        dsname<-load(url("http://bit.ly/dasi_gss_data"))
                        ds <- get(dsname)
                        df<- data.frame(ds$caseid, news=ds$news,year=as.factor(ds$year), 
                                        age=ds$age, educ=ds$educ,
                                        res=as.integer(1) )
                        df<-na.omit(df)
                        dfs <- ddply(df, c("news", query()), summarise, sm=sum(res))
                        dfs1 <-ddply(dfs, c(query()), summarise, sm=sum(sm))
                        fin<-merge(dfs, dfs1, by=c(query()))
                        f<-data.frame(fin, percent=round((fin$sm.x / (fin$sm.y)) *100))
                        f <- data.frame(f, "xdata"=f[,1],"ydata" = f$percent )
                      
                          pt<-ggplot(f, 
                               aes(x=as.integer(xdata) , + iOff(), 
                                   y=as.integer(ydata) , 
                                   linetype=news, 
                                   fill=news,
                                   colour=news
                                   ))+ geom_line(size=1)+ xlab(c(query())) + ylab("% of Respondants")+ggtitle("Newspaper Consumption in US since 1972.") 
                                pt+scale_fill_discrete(name="Response")
                                pt+ scale_size_area()+scale_colour_brewer(palette="Set1") 
                               
                        
                       })
        }
)