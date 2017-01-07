library(shiny)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("cerulean"),

  # Application title
  titlePanel("Taiwan Train"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("year",
                  "請選擇年份",
                  min = 2005,
                  max = 2014,
                  value = 2010,
                  step = 1),
      sliderInput("month",
                  "請選擇月份",
                  min = 1,
                  max = 12,
                  value = 6,
                  step = 1),
      sliderInput("day",
                  "請選擇日期",
                  min = 1,
                  max = 31,
                  value = 15,
                  step = 1),
      selectInput('hide',
                  "請選擇是否詳細顯示",
                  choices = c('是','否'))
    ),

    # Show a plot of the generated distribution
    mainPanel(
      navbarPage('Navbar',
        tabPanel('Map',
                 htmlOutput("map")),
        tabPanel('Table',
                 htmlOutput("table")),
        tabPanel('Month Plot',
                 sliderInput('thresh_month','請選擇下限值',min=20000000, value = 25000000, max = 30000000),
                 plotOutput("month_hist"),
                 HTML("<br><hr><br>"),
                 plotOutput("month_hist_zoomIn")),
        tabPanel('Day Plot',
                 sliderInput('thresh_date','請選擇下限值',min=0, value = 500000, max = 1000000),
                 plotOutput("date_hist"),
                 HTML("<br><hr><br>"),
                 plotOutput("date_hist_zoomIn"))
      )
    )
  )
))
