setwd("NI Crime Data")
library(dplyr)
# Extracting all csv files from different folders containing crimes of different years
csv_files <- dir(pattern='*.csv$', recursive = TRUE)
for(i in 1:length(csv_files)) {
  if(i == 1)
    df <- read.csv(csv_files[i])
  else
    df <- rbind(df, read.csv(csv_files[i]))
}
# Merging all csv files from different folders containing crimes of different years
df <- rbind_all(lapply(csv_files, read.csv))
head(df)
df
setwd("..")
write.csv(df, file = "AllNICrimeData.csv", row.names = FALSE, col.names = FALSE)
head(df)
str(df)
Cleaned_Post <- read.csv("CleanNIPostcodeData1.csv")
ncol(df)
nrow(df)
write.csv(df, file = "AllNICrimeData.csv", row.names = FALSE, col.names = FALSE)
df <- subset(df, select = -c(Crime.ID, Reported.by, Falls.within, LSOA.code, LSOA.name,
                             Last.outcome.category, Context))
str(df)
df$Violence_type[df$Crime.type == "Anti-social behaviour"] <- "Physical abuse"
df$Violence_type[df$Crime.type == "Drugs"] <- "South-East" <- "Physical abuse"
df$Violence_type[df$Crime.type == "Possession of weapons"] <- "Physical abuse"
df$Violence_type[df$Crime.type == "Public order"] <- "Physical abuse"
df$Violence_type[df$Crime.type == "Theft from the person"] <- "Physical abuse"
df$Violence_type[df$Crime.type == "Bicycle theft"] <- "Mental abuse"
df$Violence_type[df$Crime.type == "Burglary"] <- "Mental abuse"
df$Violence_type[df$Crime.type == "Criminal damage and arson"] <- "Physical abuse"
df$Violence_type[df$Crime.type == "Other crime"] <- "Physical and mental abuse"
df$Violence_type[df$Crime.type == "Other theft"] <- "Mental abuse"
df$Violence_type[df$Crime.type == "Robbery"] <- "Mental abuse"
df$Violence_type[df$Crime.type == "Shoplifting"] <- "Physical and mental abuse"
df$Violence_type[df$Crime.type == "Vehicle crime"] <- "Physical abuse"
df$Violence_type[df$Crime.type == "Violence and sexual offences"] <- "Physical and mental abuse"
Violence_type <- factor(df$Violence_type, order = TRUE, levels = c("Physical abuse", "Mental abuse", "Physical and mental abuse"))

df$Violence_type <- Violence_type

df$Location <- gsub("On or near", '', df$Location, ignore.case = FALSE)
df$Location <- trimws(df$Location, which = "both")
df$Location <- sub("^$", "Not available", df$Location)
head(df)
AllNICrimeData_Summary <- group_by(df, Location)
random_crime_sample <- sample_n(df,size =  1000)
View(random_crime_sample)
NIPostcodes_subset <- Cleaned_Post[, c(6, 13)]
NIPostcodes_subset <- NIPostcodes_subset[!duplicated(NIPostcodes_subset$Primary_Thorfare), ]
find_a_postcode <- function(random_crime_sample, Location){
  Postcode <- NIPostcodes_subset$Postcode[match(random_crime_sample$Location, 
                                                NIPostcodes_subset$Primary_Thorfare)]
  return(Postcode)
}

Postcode <- find_a_postcode(random_crime_sample, Location)
random_crime_sample$Postcode <- Postcode
str(random_crime_sample)
nrow(random_crime_sample)
ncol(random_crime_sample)