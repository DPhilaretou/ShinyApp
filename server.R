library(shiny)
# Fix number of decimal places and force non-scientific values
options("scipen"=100, "digits"=6)

# Load the ggplot2 package which provides
## Create a Table with the necessary data:
#Length
MetricLength <- c("Millimeters (mm)", "Centimeters (cm)", "Metres ( m)", "Kilometers (km)")
ImperialLength <- c("Inch", "Foot", "Yard", "Mile")

grp1a <- data.frame(rep(c("Length"), 4))
grp1b <- data.frame(rep(c("Metric Lengths"), 4))
grp1 <- cbind(grp1a,grp1b)
grp1 <- cbind(grp1,MetricLength)
grp1 <- cbind(grp1,c(0,0,0,0))
names(grp1) <- c("Measure", "Category", "Item", "Value" )

grp2a <- data.frame(rep(c("Length"), 4))
grp2b <- data.frame(rep(c("Imperial Lengths"), 4))
grp2 <- cbind(grp2a,grp2b)
grp2 <- cbind(grp2,ImperialLength)
grp2 <- cbind(grp2,c(0,0,0,0))
names(grp2) <- c("Measure", "Category", "Item", "Value" )

MyDataset <- rbind(grp1,grp2)

## Mass
MetricMass <- c("Milligrams (mg)", "Grams ( g)", "Kilograms (kg)")
ImperialMass <- c("Ounce (oz)", "Pound (lb)", "Stone")

grp3a <- data.frame(rep(c("Mass"), 3))
grp3b <- data.frame(rep(c("Metric Mass"), 3))
grp3 <- cbind(grp3a,grp3b)
grp3 <- cbind(grp3,MetricMass)
grp3 <- cbind(grp3,c(0,0,0))
names(grp3) <- c("Measure", "Category", "Item", "Value" )

grp4a <- data.frame(rep(c("Mass"), 3))
grp4b <- data.frame(rep(c("Imperial Mass"), 3))
grp4 <- cbind(grp4a,grp4b)
grp4 <- cbind(grp4,ImperialMass)
grp4 <- cbind(grp4,c(0,0,0))
names(grp4) <- c("Measure", "Category", "Item", "Value" )

LengthsCat <- rbind(grp3,grp4)

MyDataset <- rbind(MyDataset,LengthsCat)


# Define a server for the Shiny app
shinyServer(function(input, output) {
  # Commentary to explain how the application works
  output$text1 <- renderText("This Application provides a simple way of finding out the value of measures based on a selected item!
                             First select a Measure, then select an appropriate item, then enter the value you want to convert.
                             The calculated results will show in the value column of the table.
                             If you have selected an item that does not exist for the selected measure then the list of items will show zero values!")
  # Filter data based on selections
  output$table <- renderDataTable({
    data <- MyDataset
    if (input$Measure != "All"){
      data <- data[data$Measure == input$Measure,]
    }
    output$Item <- renderPrint({
      input$Item
    })
    if (input$Item != "All" & input$Measure == "Length" & input$Item %in% data[data$Measure == input$Measure, "Item"]){
      
    if(input$Item == "Millimeters (mm)"){
      data[1,4] <- input$ItemValue
      data[2,4] <- 0.1 * input$ItemValue # Centimiters
      data[3,4] <- 0.001 * input$ItemValue # Metres
      data[4,4] <- 0.000001 * input$ItemValue # Kilometers
      data[5,4] <- 0.03937007874015748 * input$ItemValue # Inches
      data[6,4] <- 0.0032808398950131233 * input$ItemValue # Feet
      data[7,4] <- 0.0010936132983377078 * input$ItemValue # Yards
      data[8,4] <- 0.000000621371192237334 * input$ItemValue # Miles
    } 
    if(input$Item == "Centimeters (cm)"){
      data[1,4] <- 10 * input$ItemValue # Millimeters
      data[2,4] <- input$ItemValue # Centimiters
      data[3,4] <- 0.01 * input$ItemValue # Metres
      data[4,4] <- 0.00001 * input$ItemValue # Kilometers
      data[5,4] <- 0.3937007874015748 * input$ItemValue # Inches
      data[6,4] <- 0.032808398950131233 * input$ItemValue # Feet
      data[7,4] <- 0.010936132983377078 * input$ItemValue # Yards
      data[8,4] <- 0.00000621371192237334 * input$ItemValue # Miles
    } 
    if(input$Item == "Metres ( m)"){
      data[1,4] <- 1000 * input$ItemValue # Millimeters
      data[2,4] <- 100 * input$ItemValue # Centimiters
      data[3,4] <- input$ItemValue # Metres
      data[4,4] <- 0.001 * input$ItemValue # Kilometers
      data[5,4] <- 39.37007874015748 * input$ItemValue # Inches
      data[6,4] <- 3.2808398950131233 * input$ItemValue # Feet
      data[7,4] <- 1.0936132983377078 * input$ItemValue # Yards
      data[8,4] <- 0.000621371192237334 * input$ItemValue # Miles
    } 
    if(input$Item == "Kilometers (km)"){
      data[1,4] <- 1000000 * input$ItemValue # Millimeters
      data[2,4] <- 100000 * input$ItemValue # Centimiters
      data[3,4] <- 1000 * input$ItemValue # Metres
      data[4,4] <- input$ItemValue # Kilometers
      data[5,4] <- 39370.07874015748 * input$ItemValue # Inches
      data[6,4] <- 3280.8398950131233 * input$ItemValue # Feet
      data[7,4] <- 1093.6132983377078 * input$ItemValue # Yards
      data[8,4] <- 0.621371192237334 * input$ItemValue # Miles
    } 
    if(input$Item == "Inch"){
      data[1,4] <- 25.4 * input$ItemValue # Millimeters
      data[2,4] <- 2.54 * input$ItemValue # Centimiters
      data[3,4] <- 0.0254 * input$ItemValue # Metres
      data[4,4] <- 0.0000254 * input$ItemValue # Kilometers
      data[5,4] <- input$ItemValue # Inches
      data[6,4] <- 0.08333333333333333 * input$ItemValue # Feet
      data[7,4] <- 0.027777777777777776 * input$ItemValue # Yards
      data[8,4] <- 0.000015782828282828283 * input$ItemValue # Miles
    } 
    if(input$Item == "Foot"){
      data[1,4] <- 25.4 * 12 * input$ItemValue # Millimeters
      data[2,4] <- 2.54 * 12 * input$ItemValue # Centimiters
      data[3,4] <- 0.254 * 12 * input$ItemValue # Metres
      data[4,4] <- 0.000254 * 12 * input$ItemValue # Kilometers
      data[5,4] <- 12 * input$ItemValue # Inches
      data[6,4] <- input$ItemValue # Feet
      data[7,4] <- 0.3333333333333333 * input$ItemValue # Yards
      data[8,4] <- 0.0001893939393939394 * input$ItemValue # Miles
    } 
    if(input$Item == "Yard"){
      data[1,4] <- 914.4 * input$ItemValue # Millimeters
      data[2,4] <- 91.44 * input$ItemValue # Centimiters
      data[3,4] <- 0.9144 * input$ItemValue # Metres
      data[4,4] <- 0.0009144 * input$ItemValue # Kilometers
      data[5,4] <- 36 * input$ItemValue # Inches
      data[6,4] <- 3 * input$ItemValue # Feet
      data[7,4] <- input$ItemValue # Yards
      data[8,4] <- 0.0005681818181818182 * input$ItemValue # Miles
    } 
    if(input$Item == "Mile"){
      data[1,4] <- 1609344 * input$ItemValue # Millimeters
      data[2,4] <- 160934.4 * input$ItemValue # Centimiters
      data[3,4] <- 1609.344 * input$ItemValue # Metres
      data[4,4] <- 1.609344 * input$ItemValue # Kilometers
      data[5,4] <- 63360 * input$ItemValue # Inches
      data[6,4] <- 5280 * input$ItemValue # Feet
      data[7,4] <- 1760 * input$ItemValue # Yards
      data[8,4] <- input$ItemValue # Miles
    } 
    }
    if (input$Item != "All" & input$Measure == "Mass" & input$Item %in% data[data$Measure == input$Measure, "Item"]){
      
      if(input$Item == "Milligrams (mg)"){
        data[1,4] <- input$ItemValue # Milligrams
        data[2,4] <- 0.001 * input$ItemValue # Grams
        data[3,4] <- 0.000001 * input$ItemValue # Kilograms
        data[4,4] <- 0.0000352739619496 * input$ItemValue # Ounces
        data[5,4] <- 0.00000220462262185 * input$ItemValue # Pounds
        data[6,4] <- 1.57473044418e-7 * input$ItemValue # Stone
      } 
      if(input$Item == "Grams ( g)"){
        data[1,4] <- 1000 * input$ItemValue # Milligrams
        data[2,4] <- input$ItemValue # Grams
        data[3,4] <- 0.001 * input$ItemValue # Kilograms
        data[4,4] <- 0.0352739619496 * input$ItemValue # Ounces
        data[5,4] <- 0.00220462262185 * input$ItemValue # Pounds
        data[6,4] <- 0.000157473044418 * input$ItemValue # Stone
      } 
      if(input$Item == "Kilograms (kg)"){
        data[1,4] <- 1000000 * input$ItemValue # Milligrams
        data[2,4] <- 1000 * input$ItemValue # Grams
        data[3,4] <- input$ItemValue # Kilograms
        data[4,4] <- 35.2739619496 * input$ItemValue # Ounces
        data[5,4] <- 2.20462262185 * input$ItemValue # Pounds
        data[6,4] <- 0.157473044418 * input$ItemValue # Stone
      } 
      if(input$Item == "Ounce (oz)"){
        data[1,4] <- 28349.523125 * input$ItemValue # Milligrams
        data[2,4] <- 28.349523125 * input$ItemValue # Grams
        data[3,4] <- 0.028349523125 * input$ItemValue # Kilograms
        data[4,4] <- input$ItemValue # Ounces
        data[5,4] <- 0.0625 * input$ItemValue # Pounds
        data[6,4] <- 0.004464285714285714 * input$ItemValue # Stone
      } 
      if(input$Item == "Pound (lb)"){
        data[1,4] <- 453592.37 * input$ItemValue # Milligrams
        data[2,4] <- 453.59237 * input$ItemValue # Grams
        data[3,4] <- 0.45359237 * input$ItemValue # Kilograms
        data[4,4] <- 16 * input$ItemValue # Ounces
        data[5,4] <- input$ItemValue # Pounds
        data[6,4] <- 0.07142857142857142 * input$ItemValue # Stone
      } 
      if(input$Item == "Stone"){
        data[1,4] <- 6350293.18 * input$ItemValue # Milligrams
        data[2,4] <- 6350.29318 * input$ItemValue # Grams
        data[3,4] <- 6.35029318 * input$ItemValue # Kilograms
        data[4,4] <- 224 * input$ItemValue # Ounces
        data[5,4] <- 14 * input$ItemValue # Pounds
        data[6,4] <- input$ItemValue # Stone
      } 
    }
    data
   
  })
  
})