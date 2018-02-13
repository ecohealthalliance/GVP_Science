# Viral diversity curves stratified by viral family 
# for Carroll et al. 2018 The Global Virome Project Science policy forum paper 
# Supplementary materials - estimating the average number of viral species per viral family 
### ----------------------------------------------------------------------------------------------

# calculate per-family estimates for macaques and pteropus 
P = rprojroot::find_rstudio_root_file
library(psych)

# get matrices and iNEXT output from Simon's 2013 Pteropus and 2015 Macaque papers  
source(P("R/macaque_validation_anthony_2015.R"))
source(P("R/pteropus_validation_anthony_2013.R"))

o = data.frame(matrix(ncol = 7, nrow = 4)) # initialize a df for the families with only one virus 
o[,1] = c('MmOrbi', 'MmPapV', 'MmFilo', 'MmPapV') # the names of the macaca fams with only 1 species   
o[,3] = 1 # observed 
o[,4] = 1 # estimated (based on the pteropus estimates)
names(o) = names(m.out$AsyEst)

z = data.frame(matrix(ncol = 7, nrow = 7)) # initialize a df for the tested families with 0 viruses  
# since inext doesn't know how to handle them (2 fams for Pteropus, 5 for macaca)
z[,3] = 0 # observed viruses 
z[,4] = 0 # estimated viruses 
names(z) = names(m.out$AsyEst)

# combine everything: pteropus estimates + macaca estimates +
# tested families with only 1 observed species (o) + tested families with 0 species (z)
all = rbind(mac.rich, pterop.rich, o, z)

# get average, median, sd, se 
describe(all$Estimator,
         type=2)
#mean = 11.58, sd  36.94, median = 2.5, se = 6.74

# define variables 
mean = 11.58 
n_mammals = 5291
vir_families = 25
n_birds = 11862
bird_vir_families = 1

viruses_total = mean * n_mammals * vir_families + mean * n_birds * bird_vir_families 

# range of total estimates 
low_vir_fam_est = mean - se 
high_vir_fam_est = mean + se 

low_total_est = mean * n_mammals * low_vir_fam_est + mean * n_birds * bird_vir_families 
high_total_est = mean * n_mammals * high_vir_fam_est + mean * n_birds * bird_vir_families 
