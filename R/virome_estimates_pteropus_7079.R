# Estimates of the % of the Pteropus virome discovered at each level of sampling effort 

source('R/pteropus_validation_anthony_2013.R')

# iNEXT modelling for 7079 samples (maximum used in Anthony 2013 paper)
# using 1000 boostrap replacements
i.out.7079 <- iNEXT(i.matrix, q = 0, datatype = "incidence_raw", endpoint = 7079, knots = 7079, nboot = 1000)
saveRDS(pteropus.i.out, "data/pteropus.i.out.RDS")

# extract maximum estimate for 100% of samples  
est = pteropus.i.out$AsyEst[1,2]

pterop.estimates = pteropus.i.out$iNextEst %>% 
    mutate(virome_percent = round(qD/est,3)) %>% 
    select(samples_tested = t,viruses_found = qD, virome_percent, SC, Lower_CI = qD.LCL, Upper_CI = qD.UCL, method)

write.csv(pterop.estimates, "Pteropus_g_virome_percent.csv")