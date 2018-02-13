# GVP_Science

[![DOI](https://zenodo.org/badge/121411470.svg)](https://zenodo.org/badge/latestdoi/121411470)

Data and Code to reproduce the supplementary materials of Carroll et al. 2018, "The Global Virome Project."

### Listing of files

```
├── README.md                                      | This file
|
├── GVP_Science.Rproj                              | Rstudio project organization file
|
├── data/
|   ├── macaque_data.xlsx                          | macaque viral discovery matrix from DOI:10.1038/ncomms9147
|   ├── pteropus_data.csv                          | bat viral discovery matrix from DOI:10.1128/mBio.00598-13
|   ├── GVP_costs_from_anthony2013.xlsx            | calculations to determine costs of GVP, based on supplementary material from DOI:10.1128/mBio.00598-13
|   ├── output                                 
|   |   ├── macaca_estimates_by_viral_family.csv   | macaque viral estimates at the family level
|   └── └── pteropus_estimates_by_viral_family.csv | pteropus viral estimates at the family level
|   
├── R/
|   ├── macaque_validation_anthony_2015.R          | code to estimate viral family richness in macaques
|   ├── pteropus_validation_anthony_2013.R         | code to estimate viral family richness in pteropus  
|   ├── macaque_graphs.R                           | graph viral discovery at the viral family level in macaques 
|   ├── pteropus_graphs.R                          | graph viral discovery at the viral family level in P. giganteus
|   ├── GVP_SOM.R                                  | calculate mean number of viruses  per viral family  
|   └── virome_estimates_pteropus_7079.R           | code to calculate vir % up to 7079 samples as used in Anthony 2013 
|
├── figs                                            
|   ├── macaca_viral_discovery_by_family.png                 
└── └── pteropus_viral_discovery_by_family.png     
```
