##      Class Assignment One for Reproducible Research Class
##      Michael Sloan


fnActivityExercise <- function() {
        ##  Source required libraries.
        library("dplyr")

        ##  Download Source File to working directory and unzip csv to datafile 
        download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip", "activity.zip")
        unzip ("activity.zip", exdir= "./data")
        
        ##  Load the DataSet into a RAW dataset (I use a RAW and a TARGET dataset to contain pre and post maniputation)
        rawData <- read.csv ("./data/activity.csv")
        
        ##  Prepare Cleansed Dataset
        targetData <- rawData[complete.cases(rawData),]         ##  Remove NA's
        targetData <- arrange(targetData, date)                 ##  Arrange in Date Order
        activityData <- arrange(targetData, interval)           ##  Arrange in interval Order
        
        ##  Manipulate Data for Part1 Results
        targetData$date <- as.Date(targetData$date)             ##  Convert factors to date format.
        targetData <- aggregate(targetData$steps, list(targetData$date), sum)    ##  Builds SUM Aggregate
        colnames(targetData) <- c("Date", "Daily_Steps")

        ##  Present Part One Results
        avgdlystps <- mean(targetData$Daily_Steps)
        meddlystps <- median(targetData$Daily_Steps)
        
        
        plot(targetData$Daily_Steps,type="h")
        abline(h=avgdlystps)
        abline(h=meddlystps)
        print(c("Average Daily Steps - ", as.character(avgdlystps)))
        print(c("Median Daily Steps - ", as.character(meddlystps)))
        
        ## Create Part 2 Results
        ##  activitydata <- aggregate(activityData$steps, list(activityData$interval), mean)
        
        activityData <- aggregate(activityData$steps, list(activityData$interval), mean)
        colnames(activityData) <- c("Interval", "Average_Steps")
        plot(activityData$Average_Steps, type="l")
        
        print("The interval with the greatest number of steps is averaged across all days is")
        print(as.character(activityData[activityData$Average_Steps==max(activityData$Average_Steps),]))
        


        ## Part 3 Results
        NADataSet <- rawData
        print(c("Total NA values is the dataset are - ", sum(is.na(rawData))))
        
        
        ##immute NA's
        medianNA <- median(NADataSet$steps, na.rm = TRUE)
        NADataSet[is.na(NADataSet)] <- 0
        
        return(NADataSet)    ## Returns the DataSet <DEBUG>
}

fnCleanUp <- function() {
        file.remove("activity.zip")
        unlink("data", recursive=TRUE)
}

