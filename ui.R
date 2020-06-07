# Written by : Juenzy Hodawya
# Department of Business statistics, Matana University
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# A. Libraries 
library(shiny)
library(shinydashboard)
library(dplyr)
library(readxl)
library(plotly)
library(rworldmap)
library(ggplot2)
library(hrbrthemes)

# B. Import Data
Complete <- read.csv2("Complete.csv", header = T, sep = ";")

# C. User Interface
shinyUI(
    dashboardPage(
        skin = "purple",
        dashboardHeader(title = "Factory Dashboard",
                        dropdownMenu(type = "messages"),
                        dropdownMenu(type = "notifications"),
                        dropdownMenu(type = "tasks"),
                        tags$li(class = "dropdown",tags$img(src = "Matana.png", height = 48, width = 48))
                        ),
        dashboardSidebar(
            sidebarMenu(
                sidebarSearchForm("searchText",
                                  "buttonSearch",
                                  "Search"),
                menuItem("Dashboard",
                         tabName = "dashboard",
                         icon = icon("dashboard")),
                menuItem("Table",
                         tabName = "table",
                         icon = icon("table")),
                menuItem("Summary",
                         tabName = "summary",
                         icon = icon("clipboard-list")),
                menuItem("Location of Customers",
                         tabName = "map",
                         icon = icon("map"),
                         badgeLabel = "New!",
                         badgeColor = "green"),
                menuItem("Raw Data & Source Code",
                         icon = icon("download"),
                         href = "https://github.com/JuenzyHodawya/Factory-Dashboard"),
                menuItem("About Me",
                         icon = icon("id-card"),
                         menuSubItem("Linked in",
                                     icon = icon("linkedin"),
                                     href = "https://www.linkedin.com/in/juenzy-hodawya-a310ab1a3/"),
                         menuSubItem("Facebook",
                                     icon = icon("facebook-square"),
                                     href = "https://www.facebook.com/juenzy.hodawya.9"))
            )
        ),
        dashboardBody(
            tabItems(
                tabItem(
                    tabName = "dashboard",
                    fluidRow(
                        infoBox("Top Sales (Country)",
                                628,"USA",
                                width = 3,
                                icon = icon("globe-americas"),
                                color = "olive"),
                        infoBox("Top Sales (City)",
                                205, "London",
                                width = 3,
                                icon = icon("city"),
                                color = "teal"),
                        infoBox("Top Product",
                                108, "Raclette Courdavault",
                                width = 3,
                                icon = icon("heart"),
                                color = "olive"),
                        infoBox("Top Quantity",
                                130,
                                width = 3,
                                icon = icon("thumbs-up"),
                                color = "teal")
                    ),
                    fixedRow(
                        valueBoxOutput("value1", width = 4),
                        valueBoxOutput("value2", width = 4),
                        valueBoxOutput("value3", width = 4)
                    ),
                    fluidRow(
                        box(title = "Histogram",
                            status = "primary",
                            solidHeader = T,
                            collapsible = T,
                            plotlyOutput("histogram")),
                        box(title = "Bar Plot",
                            status = "danger",
                            solidHeader = T,
                            collapsible = T,
                            plotlyOutput("bar_plot"))
                    ),
                    fluidRow(
                        box(title = "Box Plot",
                            width = 12,
                            status = "success",
                            solidHeader = F,
                            collapsible = T,
                            plotlyOutput("box_plot")))
                ),
                tabItem(tabName = "table",
                        fluidRow(
                            DT::dataTableOutput("data_table"))
                ),
                tabItem(tabName = "summary",
                        fluidRow(
                            verbatimTextOutput("summary")
                        ),
                ),
                tabItem(tabName = "map",
                        fluidRow(
                            box(
                                title = "Location of Customers",
                                id = "map",
                                status = "success",
                                solidHeader = TRUE,
                                width = 12,
                                plotOutput("map", height = "750px")
                            )
                        )
                )
            )
        )
    )
)