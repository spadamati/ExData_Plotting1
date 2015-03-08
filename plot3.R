## =========================== =================    ======= ====================
## Exploratory Data Analysis:  Peer Assessment 1 --- Plot 3  (Multi Line Graph)
## =========================== =================    ======= ====================


## ***********************************************************************************************************************

  # Task 1: Examining Household Energy Usage Varying Over a 2-day period in Feb 2007. 
  # Task 2: Fork and clone the GitHub repository: https://github.com/rdpeng/ExData_Plotting1
  # Task 3: Reconstruct 4 plots shown in the "figure" folder and save it to a PNG file using the base-plotting system.
  # Task 4: Create 4 separate R code files that constructs the 4 corresponding plots.
  # Task 5: Code files should include code for reading the data as well as code that creates the PNG file.
  # Task 6: Push your git repository to GitHub so that the GitHub version of your repository is upto date.

## ***********************************************************************************************************************

## ***********************************************************************************************************************

  # Note 1: Dataset File size = 20Mb with 2075259 rows and 9 cols
  # Note 2: Calculate Rough Estimate of Memory reqd  = 2M * 9 * (8 bytes) / 1M ~ 144 MB
  # Note 3: Make sure your computer has enough memory (most modern computers should be fine).
  # Note 4: In this dataset missing values are coded as ?
  # Note 5: The file has a header row.

## ***********************************************************************************************************************

## -------------------------------------------------------------------------------------------------------------------------------
##  Step 1: Instructions for Downloading and Unzipping the dataset file into R
## -------------------------------------------------------------------------------------------------------------------------------

  # If the dataset file does not exists, then download and unzip the "household_power_consumption.txt" to your working directory.
  # Please follow the below code only if you have not downloaded and unzipped the file to your working directory.
  # Otherwise,skip this Step 1 and proceed directly to Step 2.


  library(util)
  if(!file.exists("exdata-data-household_power_consumption.zip")) {
    
    tmp <- tempfile()#create name for the temporary destination file
    
    download.file(url = "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile =tmp,mode ="wb")
     #Note: use method = "curl" for Mac 
    
    file <- unzip(tmp)#extracting the zipped file 
    
    unlink(tmp) #delete the tmp file
  }
  
  
## -------------------------------------------------------------------------------------------------------------------------------
## Step 2: Reading the data from the "household_power_consumption.txt" file
## -------------------------------------------------------------------------------------------------------------------------------

  read_powerdata <- read.table(file,header=TRUE,sep=';',na.strings="?",stringsAsFactors = FALSE,
                               colClasses=c("character", "character", rep("numeric",7)))
  dim(read_powerdata) # obs/rows = 2075259 ,variables/cols = 9
  str(read_powerdata)
  # "Date" col contains all the dates values as strings format
  # "Time" col contains all the times values as strings format
  # So we have to perform conversion of these 2 cols to appropriate classes and format as per instructions to construct the plots.            

## -------------------------------------------------------------------------------------------------------------------------------
## Step 3: Convert and Format the "Date" (chr vector) variable to 'Date' class in R using the as.Date()  
## -------------------------------------------------------------------------------------------------------------------------------

  read_powerdata$Date <- as.Date(read_powerdata$Date, format="%d/%m/%Y")


## -------------------------------------------------------------------------------------------------------------------------------
## Step 4: Filter the dataset by subsetting in the specified date range: "2007-02-01" & "2007-02-02" 
## -------------------------------------------------------------------------------------------------------------------------------

  df <- subset(read_powerdata, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))


## -------------------------------------------------------------------------------------------------------------------------------
## Step 5: Convert the "Time" (chr vector) variable to 'POSIXlt' class in R using the strptime()
##         Create a new "Time" col by combining the converted "Date" and "Time" cols data using the format:%F %T
## -------------------------------------------------------------------------------------------------------------------------------

  df$Time <- strptime(paste(df$Date, df$Time), "%F %H:%M:%S" )
  # %F = %Y-%m-%d # %T = %H:%M:%S
  # %F = "Year-month-day"
  # %T = "Hour:Minute:Second"
  
  dim(df) # obs/rows = 2880 ,variables/cols = 9
  str(df)
  # "Date" col converted and formatted to 'Date' class 
  # "Time" col converted and formatted to 'POSIXlt' class
  # Now,we can use this cleaned,processed and formatted data for plotting the Multi Line Graph.

## -------------------------------------------------------------------------------------------------------------------------------
##  Step 6: Construct/Set up the plot for Multi Line Graph and save it into PNG file ---> Plot 3
## -------------------------------------------------------------------------------------------------------------------------------

  png(filename = "plot3.png", width = 480, height = 480,units = "px", bg = "transparent")
  
  plot(df$Time, df$Sub_metering_1 , type="l",col = "black",xlab="",ylab="Energy sub metering")
  lines(df$Time, df$Sub_metering_2, col="red")
  lines(df$Time, df$Sub_metering_3, col="blue")
  legend("topright", lty = 1, col = c("black","red","blue"),legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


## -------------------------------------------------------------------------------------------------------------------------------
##  Step 7: Close the PNG device 
## -------------------------------------------------------------------------------------------------------------------------------

  dev.off() 
