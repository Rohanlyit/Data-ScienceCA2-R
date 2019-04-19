
# Inserting the provided NIPostcode dataset into dataframe
NIPostcodes = read.csv("NIPostcodes.csv", header=0, na.strings=c("","NA"))
# Command to show the  total number of rows of the dataframe
nrow(NIPostcodes)
# Command to show the structure of the dataframe
str(NIPostcodes)
# Command to display first 10 rows of the dataframe
head(NIPostcodes,n=10)
head(NIPostcodes)
# 
NIPostcodes$X<- with(NIPostcodes, paste0(X, X.1, X.2))
head(NIPostcodes)
# Adding suitable titles for each attribute of the dataset
colnames(NIPostcodes) <- c("Organisation_Name", "Sub-building Name", "Building_Name", "Number", "Primary_Thorfare", "Alt_Thorfare", "Secondary_Thorfare", "Locality", "Townland", "Town", "County", "Postcode", "x-coordinates", "y-coordinates", "Primary_Key")
# Displaying the first five rows
head(NIPostcodes)
str(NIPostcodes)
# Replacing the missing entries with "NA" identifier
NIPostcodes[NIPostcodes == " "] <- NA
head(NIPostcodes)
str(NIPostcodes)
# Commands to display the mean missing values of each column in the dataframe
colSums(is.na(NIPostcodes))
colMeans(is.na(NIPostcodes))
str(NIPostcodes)
# Modifying the County attribute accordingly
NIPostcodes$Geo_location[NIPostcodes$County == "ANTRIM"] <- "North-East"
NIPostcodes$Geo_location[NIPostcodes$County == "DOWN"] <- "South-East"
NIPostcodes$Geo_location[NIPostcodes$County == "ARMAGH"] <- "South"
NIPostcodes$Geo_location[NIPostcodes$County == "LONDONDERRY"] <- "North-West"
NIPostcodes$Geo_location[NIPostcodes$County == "TYRAN"] <- "West"
NIPostcodes$Geo_location[NIPostcodes$County == "FERMANAGH"] <- "South-West"
Geo_location <- factor(NIPostcodes$Geo_location, order = TRUE, levels = c("North-East", "South-East", "South","North-West","West","South-West"))
# Storing the modified attribute in the "Geo_location"
NIPostcodes$Geo_location <- Geo_location
head(Geo_location)
str(NIPostcodes)
# Moving the "Primary Key" identifier at the start of the dataset
CleanedNIPostcodeData<-NIPostcodes[,c(15, 1:14,16)]
CleanedNIPostcodeData

# Displaying the Clean NIPOstcode data
head(CleanedNIPostcodeData)
str(CleanedNIPostcodeData)

# Creating a Limavady dataset and displaying only those data that has locality, townland and town containing name "LIMAVADY" 
NIPostcodes2 <- CleanedNIPostcodeData[ which(NIPostcodes$Town == "LIMAVADY"),]
Limavady_data <- NIPostcodes2[c(9,10,11)]
# Storing the Limavady data in a csv file
head(Limavady_data)
str(Limavady_data)
write.csv(Limavady_data, file = "Limavady_data1.csv", row.names = FALSE, col.names = FALSE)
# Storing the final cleaned dataset as CleanedNIPostcodeData 
write.csv(CleanedNIPostcodeData, file = "CleanNIPostcodeData1.csv", row.names = FALSE, col.names = FALSE)
head(CleanedNIPostcodeData)
str(CleanedNIPostcodeData)