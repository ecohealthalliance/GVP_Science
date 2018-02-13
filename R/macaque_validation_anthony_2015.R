#' Macaque Virome Estimation Using Anthony et al. 2015 Data

# check that packages are installed and install them if they aren't 
packages = c("tidyverse","iNEXT","readxl","viridis")

package.check <- lapply(packages, FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
        install.packages(x, dependencies = TRUE)
        library(x, character.only = TRUE)
    }
})

# shortcut for file paths 
P = rprojroot::find_rstudio_root_file

# Read in the Anthony et al. 2015 dataset
md <- read_excel(P("data/macaque_data.xlsx"))  

# Trim sample names, "total" rows and columns, and NA rows to leave only the matrix 
md <- md[1:458, 2:185]

# Find out whether there are any viral tests with no positive results 
no.obs.cols <- which(colSums(md) == 0) # none 
    
# Convert to a matrix
m.matrix <- as.matrix(md)   

# Transpose the matrix so that virus species are the rows, not the columns
m.matrix <- t(m.matrix)  

#---------------------------------------------------------------------------------------

# asymptotic estimates by viral family 

#---------------------------------------------------------------------------------------

# find the number of distinct individual viral family names 
rownames(m.matrix) 

# creating a list to segment out the matrices by viral family 
my.list.m <- list()  

# manually go through the list of names and segment them out 
# commenting out the ones with only one species within the viral family 
my.list.m[[1]] <- m.matrix[1:5, ] # MmAdV
my.list.m[[2]] <- m.matrix[6:7, ] # MmBoV
my.list.m[[3]] <- m.matrix[8:9, ] # MmCoV
my.list.m[[4]] <- m.matrix[10:14, ] # MmPicorna 
my.list.m[[5]] <- m.matrix[15:18, ] # MmPosaV
# my.list.m[[6]] <- m.matrix[19, ] # MmSFV
my.list.m[[7]] <- m.matrix[20:21, ] # MmHV
my.list.m[[8]] <- m.matrix[22:23, ] # MmPyV
my.list.m[[9]] <- m.matrix[24:25, ] # MmRbV
my.list.m[[10]] <- m.matrix[26:47, ] # MmAstV
my.list.m[[11]] <- m.matrix[48:167, ] # MmPbV
# my.list.m[[12]] <- m.matrix[168, ] # MmOrbi
my.list.m[[12]] <- m.matrix[169:171, ] # MmRota # moved to #12 so this list makes sense 
# my.list.m[[14]] <- m.matrix[172, ] # MmFilo
my.list.m[[6]] <- m.matrix[173:183, ] # MmAaV # moved to # 6 so that this list makes sense 
# my.list.m[[16]] <- m.matrix[184, ] # MmPapV

## entire list of viral families w/ species discovered 
# names(my.list.m) <- c("MmAdV", "MmBoV", "MmCoV", "MmPicorna", "MmPosaV", "MmSFV", "MmHV", 
#                     "MmPyV", "MmRbV", "MmAstV", "MmPbV", "MmOrbi", "MmRota", "MmFilo",
#                     "MmAaV", "MmPapV")

# viral families with at least 2 species discovered 
names(my.list.m) <- c("MmAdV", "MmBoV", "MmCoV", "MmPicorna", "MmPosaV", "MmAaV", "MmHV", 
                    "MmPyV", "MmRbV", "MmAstV", "MmPbV", "MmRota") # without the ones with only 1 species 

# use iNEXT to estimate viral diversity by family 
m.out <- iNEXT(my.list.m, q = 0, datatype = "incidence_raw")

 
# filter out the other diversity metrics to save only species richness  
mac.rich = m.out$AsyEst %>% 
  filter(Diversity=="Species richness")
sum(mac.rich$Estimator)

# save the estimates 
# write.csv(mac.rich, P("data/output/macaca_estimates_by_viral_family.csv"))