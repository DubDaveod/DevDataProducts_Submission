
shinyUI(pageWithSidebar(
        headerPanel("Newspaper Consumption in the US from 1972 to 2012."),
        sidebarPanel(
                p('This application investigates some trends in the consumption of newspapers within the US in the years 
                1972 through to 2012. It is based on the US GSS survey data. '), 
                p('General Social Surveys have been conducted since 1972
                over a wide range of topics, this application is based on answers to 
                the question - how often do you buy a newspaper?
                The possible responses are '),
                p('Everyday        
                Few Times A Week 
                Once A Week      
                Less Than Once Wk
                Never '),


                p('The data is taken from the US General Social Survey dataset,
                available from '),
                a('http://bit.ly/dasi_gss_data'),
                p('The code book available describing the data and survey methodology is at'), 
                a('http://publicdata.norc.org:41000/gssbeta/codebook.html'),  
                p('The variable under examination is NEWS36.'),
                
                p('The data is sliced by the following dimensions, 
                Year the survey was undertaken
                Data By Age of Respondant
                How many years of education the respondant has completed'),
                
                p('The data is displayed by means of a plot, showing the % of each respondants answering yes to the question 
                by year, age and number of years education.
                e.g. each year may have had 100 responses, of which 20 may be Everyday, 30 may be Never etc.'),
                br        
                ('In order to view the chart select an option. '),
                h3('Select an option to view the data by '),
                checkboxGroupInput("chk1", "Checkbox",
                                   c("View Data by Year" = "1" ,
                                     "View Data By Age of Respondant" = "2",
                                     "View Data by # of Responants years in Education" = "3"
                                   )  ,"selected"="1"                                  
                )),
        mainPanel(
                plotOutput('newPlot')
        )
))

