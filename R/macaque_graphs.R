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
source(P("R/macaque_validation_anthony_2015.R"))

# graph the estimates by viral family 
m_title = expression(paste("Viral discovery by viral family in ", italic("Macaca Mulatta")))
m2 = ggiNEXT(m.out) +
    ggtitle(m_title) +
    xlab("Number of specimens tested (i.e., samples)") + ylab("Viral species") +
    xlim(0, 1000) + ylim(0, 200) +
    scale_shape_manual(values = rep(19, length(names(my.list.m)))) +
    #   theme(legend.position = "none")
    scale_color_manual(values = viridis(12)) + 
    theme_avenir() + 
    guides(linetype = F, fill = F, shape = F, color=guide_legend(title="Viral Family"))

# save the graph 
# png("figs/macaca_viral_discovery_by_family.png", width = 550, height = 550)
# plot(m2)
# dev.off()
