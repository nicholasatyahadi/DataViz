library(shiny)
library(shinydashboard)
library(ggplot2)
library(plotly)
library(tidyverse)
library(shinyWidgets)

#some extra functions
lendist <- function(x){return(length(unique(x)))}
'%!in%' <- function(x,y)!('%in%'(x,y))
enden <- function(x){return(x[length(x)])}


#ui
ui <- dashboardPage(
  dashboardHeader(title = "DataViz"),
  dashboardSidebar(
    uiOutput("sidetabs")
  ),
  dashboardBody(
    uiOutput("bodycontent")
  )
  
)

#server
server <- function(input, output, session) {
  
  observeEvent(session, {
    updateTabItems(session, "tabs", selected = "mainpage")
  })
  
  menuitems <- reactiveVal(value = "Graph1")
  global <- reactiveValues(dataplot = NULL, fils = NULL)
  
  #dynamic sidebar menu
  output$sidetabs <- renderUI({
    sidebarMenu(id = "tabs",
                menuItem("About DataViz", tabName = "mainpage", icon = icon("exclamation-circle"), selected = T),
                menuItem("Upload Page", tabName = "uppage", icon = icon("file")),
                menuItem("Graphs", id = "subs", tabName = "subs",  icon = icon("line-chart"), 
                         startExpanded = T,
                         lapply(menuitems(), function(x) {
                           menuSubItem(x, tabName = paste0("menu_", x)) } )),
                menuItem("Graph Options", tabName = "options", icon = icon("gear"))
    )
  })
  
  #dynamic content
  output$bodycontent <- renderUI({
    
    submitems <- lapply(menuitems(), function(x){
      tabItem(tabName = paste0("menu_", x), uiOutput(paste0("menu_", x)))
    })
    
    items <- c(
      list(
        tabItem(tabName = "mainpage",
                h3("Welcome to DataViz"),
                fluidRow(
                  box(
                    width = 10,
                    textOutput('aboutdataviz')
                  ),
                  tags$br(),
                  tags$br(),
                  tags$br(),
                  tags$br(),
                  tags$br(),
                  h3('  How to use DataViz:'),
                    tags$ol(
                      tags$li("Input your CSV properties on the sidebar, then upload your CSV.\n The app will automatically remove rows with NA entries."),
                      tags$li("Go ahead make your first plot! (or graph, or panel, whatever you want to name it lol)"),
                      tags$li("Need more plots? Check out the Graph Options panel to add more. Don't be shy put some more!"),
                      tags$li("Just in case the plot does not help you in seeing the values, you can click on the curve on\n your plot and the app will generate the entry."),
                      tags$li("Analyze away! Have fun!")
                    ),
                  tags$br(),
                  box(
                    width = 10,
                    textOutput('sidenote'),
                    uiOutput('url')
                  )
                )
                
        )
      ),
      
      submitems,
      
      list(
        tabItem(tabName = "uppage",
                h3("Upload your CSV file here"),
                sidebarLayout(
                  sidebarPanel(width = 3,
                               fileInput('file', 'Upload CSV File:',
                                         accept=c('text/csv',
                                                  'text/comma-separated-values,text/plain',
                                                  '.csv')),
                               tags$br(),
                               radioButtons('sep', 'Delimiter',
                                            c(Semicolon=';',
                                              Comma=',',
                                              Tab='\t'),
                                            ','),
                               radioButtons('quote', 'Quote',
                                            c(None='',
                                              'Double Quote'='"',
                                              'Single Quote'="'"),
                                            '"'),
                               radioButtons('decimal', 'Decimal',
                                            c(Comma = ',',
                                              Dot = '.'),
                                            '.'),
                               radioButtons("disp", "Display",
                                            choices = c(Head = "head",
                                                        All = "all"),
                                            selected = "head")
                               
                  ),
                  mainPanel(
                    tableOutput('contents')
                  )
                )
        )
      ),
      list(
        tabItem(tabName = "options",
                
                textInput("addmenu", "Add New Graph (Don't use spacing between characters)"),
                actionButton("add", "Add"),
                
                selectInput("delmenu", "Delete Graph", choices = menuitems()),
                actionButton("del", "Delete")
        )
      )
    )
    
    do.call(tabItems, items)
  })
  
  #dynamic content in the dynamic menuitems
  prop <- list()
  observe({ 
    prop[[enden(menuitems())]] <- rep("",4)
    lapply(menuitems(), function(x){
      
      output[[paste0("menu_", x)]] <- renderUI ({
        list(fluidRow(
          box(width = 4,
            pickerInput(paste0("xaxis_",x),"X-Axis",choices = c("",colnames(csvfile())), selected = max(prop[[x]][1],""), multiple = F),
            pickerInput(paste0("yaxis_",x),"Y-Axis",choices = c("",colnames(csvfile())), selected = max(prop[[x]][2],""), multiple = F),
            pickerInput(paste0('calcmethod_',x),"Optional Calculation on Y-Axis", choices = c("",
                                                                                              None = "none",
                                                                                             Sum = 'sum',
                                                                                             Average = 'mean',
                                                                                             Median = 'median',
                                                                                             Count = 'length',
                                                                                             CountD = 'lendist'),
                        selected = max(prop[[x]][4],""), multiple = F),
            pickerInput(paste0("plotmod_",x), "Plot Model", choices = c("",
                                                                       "Barplot",
                                                                       "LineChart",
                                                                       "ScatterPlot",
                                                                       "PieChart"),
                        selected = max(prop[[x]][3],""), multiple = F)
          ),
          box(width = 8,
            #htmlOutput(paste0('testax_',x))
            plotlyOutput(paste0('plot_',x)),
            verbatimTextOutput(paste0('stextev_',x)),
            tableOutput(paste0('seltab_',x))
          )
        )
        )
      })
    
      #To Plot
      prop[[x]] <- c(input[[paste0('xaxis_',x)]],
                     input[[paste0('yaxis_',x)]],
                     input[[paste0('plotmod_',x)]],
                     input[[paste0('calcmethod_',x)]])
      
      df <- csvfile()
      
      #Since there might be users wanting optional calculations, we use the observe function
      observe({
        req(input[[paste0('xaxis_',x)]],input[[paste0('yaxis_',x)]],input[[paste0('calcmethod_',x)]],input[[paste0('plotmod_',x)]])
        df1 <- df[c(input[[paste0('xaxis_',x)]],input[[paste0('yaxis_',x)]])]
        if(input[[paste0('calcmethod_',x)]]!='none'){
          df1 <- df1 %>% group_by_at(vars(colnames(df1)[1])) %>% summarize_at(vars(colnames(df1)[2]),.funs=input[[paste0('calcmethod_',x)]])
          df1 <- as.data.frame(df1)
        }else{df1<-df1}
        
        for(i in 1:ncol(df1)){
          if(class(df1[,i])=='factor'){
            df1[,i] <- as.character(df1[,i])
          }
        }
        
        #we save the used data frame for later use in display
        global$dataplot[[x]] <- df1
        
        output[[paste0('plot_',x)]] <- renderPlotly({
          titletext<-paste0("<b>",input[[paste0('plotmod_',x)]],"</b> ",colnames(df1)[1]," VS. ",colnames(df1)[2])
          if(input[[paste0('plotmod_',x)]]=="Barplot"){
            plot <- ggplot(df1, aes(x = df1[,1], y = df1[,2], fill = factor(df1[,1]))) +
              geom_bar(stat="identity") +
              labs(title = titletext, x = colnames(df1)[1], y = colnames(df1)[2])
            ggplotly(plot+theme(legend.title = element_blank()),source = paste0('ev_',x)) %>% style(hoverinfo = 'none')
          }else if(input[[paste0('plotmod_',x)]]=="LineChart"){
            plot <- ggplot(df1, aes(x=df1[,1], y=df1[,2])) +
              geom_line(color = "#2557a8", size = 1) +
              labs(title = titletext, x = colnames(df1)[1], y = colnames(df1)[2])
            ggplotly(plot+theme(legend.title = element_blank()),source = paste0('ev_',x)) %>% style(hoverinfo = 'none')
          }else if(input[[paste0('plotmod_',x)]]=="ScatterPlot"){
            plot <- ggplot(df1, aes(x=df1[,1], y=df1[,2])) +
              geom_point(color = "#04c246") +
              labs(title = titletext, x = colnames(df1)[1], y = colnames(df1)[2])
            ggplotly(plot+theme(legend.title = element_blank()), source = paste0('ev_',x)) %>% style(hoverinfo = 'none')
          }else if(input[[paste0('plotmod_',x)]]=="PieChart"){
            plot_ly(df1, labels = df1[,1], values = df1[,2], type = 'pie', source = paste0('ev_',x)) %>% style(hoverinfo = 'none')
          }
        })
      })
      
      #the extra display about the selected data
      output[[paste0('stextev_',x)]] <- renderPrint({
        ed <- rbind(event_data('plotly_selected', source = paste0('ev_',x)),event_data('plotly_click', source = paste0('ev_',x)))
        plotdf <- isolate(global$dataplot[[x]])
        num <- sapply(c(1:nrow(ed)), function(i){
          max(ed$curveNumber[i],ed$pointNumber[i])
        })
        if(prop[[x]][4]=="none"){
          plotdf[num+1,]
        }else{
          funcs <- ifelse(prop[[x]][4]=='lendist','CountD',
                         ifelse(prop[[x]][4]=='length','Count',
                                ifelse(prop[[x]][4]=='median','Median',
                                       ifelse(prop[[x]][4]=='mean','Average','Sum'))))
                 
          colnames(plotdf)[2]<-paste0(c(funcs,colnames(plotdf)[2]), collapse = " ")
          plotdf[num+1,]
        }
      })
    })
  })
  
  
  #add/remove tabs
  observeEvent(input$add, {
    req(input$addmenu)
    if(input$addmenu %in% menuitems()){
      showNotification("Name has been used", type = "error")
      req(input$addmenu)
    }else{
      mitems <- c(menuitems(), input$addmenu)
      menuitems(mitems)
      updateTabItems(session, "tabs", selected = "options")
      showNotification(paste0(input$addmenu," successfully added!"), type = "message")
    }
  })
  
  observeEvent(input$del, {
    req(input$delmenu)
    ask_confirmation(
      inputId = "delconfirm",
      title = NULL,
      text = tags$b(
        icon("line-chart"),
        paste0("Do you really want to delete ", input$delmenu,"?"),
        style = "color: #FA5858;"
      ),
      btn_labels = c("Cancel", "Delete panel"),
      btn_colors = c("#00BFFF", "#FE2E2E"),
      html = TRUE
    )
  })
  
  #deletion confirmation
  observeEvent(input$delconfirm,{
    if(input$delconfirm == T){
      mitems <- menuitems()[-which(menuitems() == input$delmenu)]
      menuitems(mitems)
      updateTabItems(session, "tabs", selected = "options")
      showNotification(paste0(input$delmenu," deleted!"), type = "message")
    }
  })
  
  #the rest of the outputs
  
  #data input and cleaning
  csvfile <- reactive({
    req(input$file)
    csvdata <- read.csv(file = input$file$datapath,
                        sep = input$sep,
                        quote = input$quote,
                        dec = input$decimal,
                        na.strings = c("", "NA", "#N/A","N/A"))
    
    csvdata <- csvdata[complete.cases(csvdata),]
    for(i in ncol(csvdata)){
      if(class(csvdata[,i])=='factor'){
        csvdata[,i] <- as.character(csvdata[,i])
      }
    }
    
    return(csvdata)
  })
  
  output$contents <- renderTable({
    if(input$disp == "head"){
      return(head(csvfile()))
    }else{
      return(csvfile())
    }
  })
  
  #main dashboard display
  output$aboutdataviz <- renderText({
    paste("Welcome to DataViz! DataViz is a data visualization app built on Shiny Dashboard (and other libraries).
          This app aims to help R users for in-depth data analysis without having to leave R.
          And the best part is, you can freely control multiple graphs!")
  })
  
  output$sidenote <- renderText({
    paste("DataViz is still in development, so expect some glitches/errors.
    Nevertheless, I hope you enjoy using this app as much as I do making it.
    For any feedbacks/improvements/error reports, feel free to open an issue below. -N.S. ")
  })
  output$url <- renderUI({
    url <- a("GitHub Link", href="https://github.com/nicholasatyahadi/DataViz/issues")
    tagList("URL Link:", url)
  })
}

shinyApp(ui, server)