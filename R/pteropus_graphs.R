#------------------------------------------------------------

#               /\                 /\
#              / \'._   (\_/)   _.'/ \
#              |.''._'--(o.o)--'_.''.|
#               \_ / `;=/ " \=;` \ _/
#                 `\__| \___/ |__/`
#                      \(_|_)/
#                       " ` "
# pteropus graphs 
#-------------------------------------------------------------
# load package(s) not used in macaque_validation_anthony_2015.R
if(!require(here)) {
    install.packages("here", dependencies = TRUE)
    library(here)
}

# load ggplot theme 
if(!require(bplots)) {
    if(!require(devtools)) {
        install.packages("devtools", dependencies = TRUE)
        library(devtools)
    }
    devtools::install_github("brooke-watson/bplots")
    library(bplots)
}

# source data     
source(P("R/pteropus_validation_anthony_2015.R"))

g_title = expression(paste("Viral discovery by viral family in ", italic("Pteropus giganteus")))
# graph by viral family 
g = ggiNEXT(i.out) +
    ggtitle(g_title) +
    xlab("Number of specimens tested (i.e., samples)") + ylab("Viral species") +
    xlim(0, 2000) + ylim(0, 20) +
    scale_shape_manual(values = rep(19, length(names(my.list)))) +
    # theme(legend.position = "none")
    guides(linetype = F, fill = F, shape = F, color = guide_legend(title = "Viral Family")) + 
    theme_avenir() + 
    scale_color_manual(values = viridis(length(unique(i.out$DataInfo$site))))

# png("figs/pteropus_viral_discovery_by_family.png", width = 550, height = 550)
# plot(g)
# dev.off()