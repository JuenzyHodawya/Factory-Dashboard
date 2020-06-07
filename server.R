
shinyServer(function(input, output) {
    
    output$value1 <- renderValueBox({
        TotalAmount <- as.numeric(Complete$TotalAmount)
        avg_total_amount <- round(mean(TotalAmount), 2)
        valueBox(
            avg_total_amount,
            "Average of Total Amount",
            icon = icon("balance-scale"),
            color = "orange"
        )
    })
    
    output$value2 <- renderValueBox({
        avg_unit_price <- round(mean(Complete$UnitPrice), 2)
        valueBox(
            avg_unit_price,
            "Average of Unit Price",
            icon = icon("dollar-sign"),
            color = "green"
        )
    })
    
    output$value3 <- renderValueBox({
        avg_quantity <- round(mean(Complete$Quantity), 2)
        valueBox(
            avg_quantity,
            "Average of Quantity",
            icon = icon("calculator"),
            color = "blue"
        )
    })
    
    output$histogram <- renderPlotly({
        ggplot(Complete, aes(x=Complete$Quantity)) +
            stat_bin(breaks=seq(0,150,6), fill="maroon", color="#e9ecef", alpha=0.9) +
            ggtitle("Density of Quantity Orders by Customers") +
            theme_ipsum() +
            xlab("Quantity") +
            ylab("Density")
    })
    
    output$bar_plot <- renderPlotly({
        ggplot(Complete, aes(x=Complete$Country, y=Complete$Quantity) ) +
            geom_bar(stat="identity", fill="#69b3a2") +
            ggtitle("Sales in Each Country") +
            coord_flip() +
            theme_ipsum() +
            xlab("Country") +
            ylab("Quantity") +
            theme(
                panel.grid.minor.y = element_blank(),
                panel.grid.major.y = element_blank(),
                legend.position="none")  
    })
    
    output$box_plot <- renderPlotly({
        Country <- Complete$Country
        ggplot(Complete, aes(x=Complete$ProductName, y=Complete$Quantity, fill=ProductName)) +
            geom_boxplot(color="#69b3a2", alpha=0.8) +
            ggtitle("Number of Product Orders by Customers") +
            theme(plot.title = element_text(size=12)) +
            xlab('Product Name') +
            ylab('Quantity')    
    })
    
    output$data_table  <- DT::renderDataTable({DT::datatable(Complete)
    })
    
    output$summary  <- renderPrint({summary(Complete [,c(-1:-4,-7:-10,-14:-15)])
    })
    
    output$map <- renderPlot({
        countries <- as.data.frame(table(Complete$Country))
        colnames(countries) <- c("country", "value")
        matched <- joinCountryData2Map(countries, joinCode = "NAME", nameJoinColumn = "country")
        mapCountryData(matched, nameColumnToPlot = "value", mapTitle = "", 
                       catMethod = "pretty", colourPalette = c("pink", "darkred"))
    })
    
})
    