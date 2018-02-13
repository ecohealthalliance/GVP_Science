#' Pteropus Virome Estimation Using Anthony et al. 2013 Data

library(tidyverse)
library(iNEXT)
library(bplots) 
# note - bplots is a theme editor for ggplot that is not on CRAN. you can install bplots from github 
# using `devtools::install_github("brooke-watson/bplots")`. alternately, comment out line 105 (`theme_avenir() +`) to 
# reproduce the figures. 
library(viridis)

P <- rprojroot::find_rstudio_root_file

# Read in the Anthony et al. dataset
d <- read.csv(P("data/pteropus_data.csv"))
colnames(d)[1] <- "ID"
d2 <- d

# Eliminate rows (specimens) that were not tested for every virus

for (i in 9:63) {
  
  index <- d2[ , i] != "Not Tested"
  
  d2 <- d2[index, ]
}

d2 <- droplevels(d2)

# Eliminate extraneous columns 

d2 <- d2[ , -(2:8)]

# Convert viral testing columns to integers

d2[ , 2:ncol(d2)] <- 
  sapply(2:ncol(d2), function(x) as.integer(as.character(d2[ , x])))

# Which columns (viral tests) have no observations?

no.obs.cols <- which(colSums(d2) == 0)

# These should match what Anthony et al. reports in Fig. 8 as the eleven
# viruses not considered:
# PgHV-2, -5, -6, and -9 
# PgAdV-1 and -10
# PgAstV-4, -5, -6, and -8
# PgBoV-1

no.obs.cols

# Get rid of these columns in the dataframe

d2 <- d2[ , -no.obs.cols]

# Convert to a matrix

i.matrix <- as.matrix(d2)

# Use the first matrix column as the row names, get rid of the column

rownames(i.matrix) <- i.matrix[ , 1]

i.matrix <- i.matrix[ , -1]

# Transpose the matrix so that virus species are the rows, not the columns

i.matrix <- t(i.matrix)

#---------------------------------------------------------------------------------------

# asymptotic estimates by viral family 

#---------------------------------------------------------------------------------------

# get the names of the viral family tests 
rownames(i.matrix) 

# initialize a list to segment the viral families 
my.list <- list()

# manually go through the list of names to stratify 
my.list[[1]] <- i.matrix[1:4, ] # CoV
my.list[[2]] <- i.matrix[5:15, ] # PmV
my.list[[3]] <- i.matrix[16:19, ] # AstV
my.list[[4]] <- i.matrix[20:28, ] # HV
my.list[[5]] <- i.matrix[29:40, ] # AdV
my.list[[6]] <- i.matrix[41:43, ] # PyV
my.list[[7]] <- i.matrix[44, ] # BoV


names(my.list) <- c("CoV", "PmV", "AstV", "HV", "AdV", "PyV", "BoV")

# run iNEXT 
i.out <- iNEXT(my.list, q = 0, datatype = "incidence_raw", endpoint = 7079)

# filter out the other diversity metrics to save only species richness  
pterop.rich = i.out$AsyEst %>% 
  filter(Diversity == "Species richness")

# save the iNEXT estimates 
# write.csv(pterop.rich, P("data/output/pteropus_estimates_by_viral_family.csv"))
 