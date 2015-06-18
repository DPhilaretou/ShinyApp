
library(shiny)
options(shiny.deprecation.messages=FALSE)

# Fix number of decimal places and force non-scientific values
options("scipen"=100, "digits"=6)

## Create a Table with the necessary data:
## Length
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

MyDataset <- rbind(MyDataset, LengthsCat)


## My Shiny Application 
# setwd("C:/Coursera/Developing Data Products/ShinyProject")

# Define the overall UI
shinyUI(
  fluidPage(
    titlePanel("Simple Measure Converter"),
    
    # Commentary
    textOutput("text1"),
    # Create a new Row in the UI for selectInputs
    fluidRow(
      column(4, 
             selectInput("Measure", 
                         "Measure:", 
                         c("All", 
                           unique(as.character(MyDataset$Measure))))
      ),
      column(4, 
             selectInput("Item", 
                         "Item:", 
                         c("All", 
                           unique(as.character(MyDataset$Item))))
      ),
      numericInput("ItemValue", "Enter the value of the selected item:", 0)
    ),
    
    # Create a new row for the table.
    fluidRow(
      dataTableOutput(outputId="table"),
      verbatimTextOutput("Item")
    )    
  )  
)
