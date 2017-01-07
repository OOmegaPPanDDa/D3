library(shiny)
library(dplyr)
library(googleVis)
library(ggplot2)
source('read_data.R')

shinyServer(function(input, output) {
  
  
  
  
  output$map <- renderGvis({
    
    date_data <<- train_flow %>% 
      filter(year==input$year & month == input$month & day == input$day)
    
    date_flow_sum <- sum(date_data$flow)
    map_data <- data.frame(站名=date_data$stop_name, 日流量=date_data$flow, 日流量佔比=date_data$flow/date_flow_sum,
                              LatLong = date_data$LatLong)
    
    
    map_data <- map_data %>% arrange(desc(日流量))
    
    if(input$hide == '否'){
      map_data <- map_data[1:20,]
    }
    
    
    gvisGeoChart(map_data, "LatLong", 
              hovervar = "站名",
              sizevar='日流量佔比',
              colorvar="日流量", 
              options=list(region="TW",colors="['#F1E1FF', '#FF0000']"))
    
  })
  
  
  
  
  
  output$table <- renderGvis({
    
    
    
    date_data <- train_flow %>% 
      filter(year==input$year & month == input$month & day == input$day)
    
    date_flow_sum <- sum(date_data$flow)
    table_data <- data.frame(站名=date_data$stop_name, 日流量=date_data$flow, 日流量佔比=date_data$flow/date_flow_sum)
    
    
    table_data <- table_data %>% arrange(desc(日流量))
    
    if(input$hide == '否'){
      table_data <- table_data[1:20,]
    }
    
    table_data$排名 <- seq(from = 1, to = nrow(table_data))
    table_data <- table_data[,c(4,1,2,3)]
    
    gvisTable(table_data)

  })
  
  
  
  
  
  output$month_hist <- renderPlot({
    
    
    
    year_data <- train_flow %>% 
      filter(year==input$year)
    
    
    year_data <- year_data %>% group_by(month) %>% mutate(month_count=sum(flow)) %>% ungroup()
    year_data <- unique(year_data %>% select(month,month_count))
    year_data$month <- as.factor(year_data$month)
    
    options(scipen=999)
    month_hist <- ggplot(year_data, aes(x=month,y=month_count-input$thresh_month,fill=month_count)) +
      geom_histogram(stat='identity',alpha = .8) +
      ylim(0, 22000000) + 
      scale_fill_gradient("月流量", low = "#84C1FF", high = "#0066CC") + 
      labs(title= paste0("Histogram for ", input$year, " Train", collapse = ''))+
      labs(x="月份", y=paste0("月流量 - ", input$thresh_month, collapse = ''))+ 
      theme(text = element_text(family= 'Arial Unicode MS'))
    
    month_hist
    
  })
  
  
  
  
  
  output$month_hist_zoomIn <- renderPlot({
    
    
    
    year_data <- train_flow %>% 
      filter(year==input$year)
    
    
    year_data <- year_data %>% group_by(month) %>% mutate(month_count=sum(flow)) %>% ungroup()
    year_data <- unique(year_data %>% select(month,month_count))
    year_data$month <- as.factor(year_data$month)
    
    options(scipen=999)
    month_hist_zoomIn <- ggplot(year_data, aes(x=month,y=month_count-input$thresh_month,fill=month_count)) +
      geom_histogram(stat='identity',alpha = .8) +
      scale_fill_gradient("月流量", low = "#84C1FF", high = "#0066CC") + 
      labs(title= paste0("Histogram for ", input$year, " Train (Zoom In to View)", collapse = ''))+
      labs(x="月份", y=paste0("月流量 - ", input$thresh_month, collapse = ''))+ 
      theme(text = element_text(family= 'Arial Unicode MS'))
    
    month_hist_zoomIn
    
  })
  
  
  
  output$date_hist <- renderPlot({
    
    
    
    month_data <- train_flow %>% 
      filter(year==input$year, month==input$month)
    
    
    month_data <- month_data %>% group_by(day) %>% mutate(day_count=sum(flow)) %>% ungroup()
    month_data <- unique(month_data %>% select(day,day_count))
    month_data$day <- as.factor(month_data$day)
    
    options(scipen=999)
    day_hist <- ggplot(month_data, aes(x=day,y=day_count-input$thresh_date,fill=day_count)) +
      geom_histogram(stat='identity',alpha = .8) +
      ylim(0, 1500000) + 
      scale_fill_gradient("日流量", low = "#FFC78E", high = "#FF5809") + 
      labs(title= paste0("Histogram for ", input$year,"年 ",input$month,"月 ","Train", collapse = ''))+
      labs(x="日期", y=paste0("日流量 - ", input$thresh_date, collapse = ''))+ 
      theme(text = element_text(family= 'Arial Unicode MS'))
    
    day_hist
    
  })
  
  
  
  
  output$date_hist_zoomIn <- renderPlot({
    
    
    
    month_data <- train_flow %>% 
      filter(year==input$year, month==input$month)
    
    
    month_data <- month_data %>% group_by(day) %>% mutate(day_count=sum(flow)) %>% ungroup()
    month_data <- unique(month_data %>% select(day,day_count))
    month_data$day <- as.factor(month_data$day)
    
    options(scipen=999)
    day_hist_zoomIn <- ggplot(month_data, aes(x=day,y=day_count-input$thresh_date,fill=day_count)) +
      geom_histogram(stat='identity',alpha = .8) +
      scale_fill_gradient("日流量", low = "#FFC78E", high = "#FF5809") + 
      labs(title= paste0("Histogram for ", input$year,"年 ",input$month,"月 ","Train (Zoom In to View)", collapse = ''))+
      labs(x="日期", y=paste0("日流量 - ", input$thresh_date, collapse = ''))+ 
      theme(text = element_text(family= 'Arial Unicode MS'))
    
    day_hist_zoomIn
    
  })
  
  
  
  
})