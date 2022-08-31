###Summary Statistics and Tests

#install.packages('ggpubr')
install.packages('ggplot2')
library(ggpubr)
library(ggplot2)

summary(len_fclass$time_our) #summary statistics
summary(len_fclass$time_google)
summary(len_fclass$difference_our_google)
summary(len_fclass$percent_difference_our)
sd(len_fclass$time_our) #to find standard deviation
sd(len_fclass$time_google)
t.test(len_fclass$time_our, len_fclass$time_google) #to check whether they are statsitically different

#Summary statistics for subcategories of fclass (for the data has 250 obs for each category)
summary(subset(len_fclass, fclass=='primary'))
summary(subset(len_fclass, fclass=='secondary'))
summary(subset(len_fclass, fclass=='tertiary'))
summary(subset(len_fclass, fclass=='track'))
summary(subset(len_fclass, fclass=='trunk'))
summary(subset(len_fclass, fclass=='unclassified'))

#Summary statistics for subcategories of fclass for the dataset that has maxpeed
summary(subset(maxspeed_len_fclass, fclass=='primary'))
summary(subset(maxspeed_len_fclass, fclass=='secondary'))
summary(subset(maxspeed_len_fclass, fclass=='tertiary')  )
summary(subset(maxspeed_len_fclass, fclass=='track')  )
summary(subset(maxspeed_len_fclass, fclass=='trunk'))
summary(subset(maxspeed_len_fclass, fclass=='unclassified')  )

#Summary statistics for time and time difference
summary(len_fclass$percent_difference_our)
summary(maxspeed_len_fclass$time_our)
summary(maxspeed_len_fclass$time_google)
summary(maxspeed_len_fclass$time_osm)
summary(maxspeed_len_fclass$difference_our_google)
summary(maxspeed_len_fclass$difference_our_osm)
summary(maxspeed_len_fclass$difference_osm_google)
sd(maxspeed_len_fclass$time_our)
sd(maxspeed_len_fclass$time_google)
sd(maxspeed_len_fclass$time_osm)
t.test(maxspeed_len_fclass$time_our,maxspeed_len_fclass$time_google)
t.test(maxspeed_len_fclass$time_our,maxspeed_len_fclass$time_osm)

#Summary statistics for difference ratio difference/osm
summary(maxspeed_len_fclass$percent_dour_google)
summary(maxspeed_len_fclass$percent_dour_dosm)
summary(maxspeed_len_fclass$percent_dosm_dgoogle)


###Graphs

###Plots for Time###
rm(vplot1)
vplot1=ggplot(len_fclass, aes(x=time_our, y=fclass,fill=fclass)) + geom_violin()
vplot1=vplot1+labs(title=" Our Travel Time and Road Type ",x="Minutes ",y="Road Type",caption = "(N=250 for each category)")
vplot1=vplot1+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
vplot1

rm(vplot2)
vplot2=ggplot(len_fclass, aes(x=time_google, y=fclass,fill=fclass)) + geom_violin()
vplot2=vplot2+labs(title=" Google Travel Time and Road Type ",x="Minutes ",y="Road Type",caption = "(N=250 for each category and lengths>1000)")
vplot2=vplot2+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
vplot2

vplot3=ggplot(maxspeed_len_fclass, aes(x=time_our, y=fclass,fill=fclass)) + geom_violin()
vplot3=vplot3+labs(title=" Our Travel Time and Road Type ",x="Minutes ",y="Road Type",caption='(Subsample has OSM Speed values, length>1000)')
vplot3=vplot3+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
vplot3

vplot4=ggplot(maxspeed_len_fclass, aes(x=time_google, y=fclass,fill=fclass)) + geom_violin()
vplot4=vplot4+labs(title=" Google Travel Time and Road Type ",x="Minutes ",y="Road Type",caption='(Subsample has OSM Speed values, length>1000)')
vplot4=vplot4+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
vplot4

vplot5=ggplot(maxspeed_len_fclass, aes(x=time_osm, y=fclass,fill=fclass)) + geom_violin()
vplot5=vplot5+labs(title=" OSM Travel Time and Road Type ",x="Minutes ",y="Road Type",caption='(Subsample has OSM Speed values, length>1000)')
vplot5=vplot5+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
vplot5

#To combine previous plots
ggarrange(vplot3,vplot4,vplot5,vplot1,vplot2 + rremove("x.text"),labels = c("",""), ncol = 3, nrow = 2)

###Plots for difference in minutes###

vplotdif1=ggplot(len_fclass, aes(x=difference_our_google, y=fclass,fill=fclass)) + geom_violin()
vplotdif1=vplotdif1+labs(title="Time Difference for Our and Google Values ",x="Minutes",y="Road Type"
                         ,caption = "(Difference= Our Time - Google Time)",subtitle="(For the sample with n=1500)")
vplotdif1=vplotdif1+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
vplotdif1

vplotdif2=ggplot(maxspeed_len_fclass, aes(x=difference_our_google, y=fclass,fill=fclass)) + geom_violin()
vplotdif2=vplotdif2+labs(title="Time Difference for Our and Google Values ",x="Minutes",y="Road Type"
                         ,subtitle="(For the sample has OSM speed)",caption = "(Difference= Our Time - Google Time)")
vplotdif2=vplotdif2+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
vplotdif2

vplotdif3=ggplot(maxspeed_len_fclass, aes(x=difference_our_osm, y=fclass,fill=fclass)) + geom_violin()
vplotdif3=vplotdif3+labs(title="Time Difference for Our and OSM Values ",x="Minutes",y="Road Type"
                         ,subtitle="(For the sample has OSM speed)",caption = "(Difference= Our Time - OSM Time)")
vplotdif3=vplotdif3+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
vplotdif3

vplotdif4=ggplot(maxspeed_len_fclass, aes(x=difference_osm_google, y=fclass,fill=fclass)) + geom_violin()
vplotdif4=vplotdif4+labs(title="Time Difference for OSM and Google Values ",x="Minutes",y="Road Type"
                         ,subtitle="(For the sample has OSM speed)",caption = "(Difference= OSM Time - Google Time)")
vplotdif4=vplotdif4+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
vplotdif4

#To combine previous plots
ggarrange(vplotdif1,vplotdif2,vplotdif3,vplotdif4 + rremove("x.text"),labels = c("",""), ncol = 2, nrow = 2)


###Plots for difference in ratios###

vplotrat1=ggplot(len_fclass, aes(x=ratio_our_google, y=fclass,fill=fclass)) + geom_violin()
vplotrat1=vplotrat1+labs(title="Our/Google Ratio vs Road Type ",x="Ratio",y="Road Type"
                         ,caption = "(Ratio= Our Time/Google Time)",subtitle="(Sample with n=1500)")
vplotrat1=vplotrat1+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
vplotrat1

vplotrat2=ggplot(len_fclass, aes(x=percent_difference_our, y=fclass,fill=fclass)) + geom_violin()
vplotrat2=vplotrat2+labs(title="Our&Google Ratio vs Road",x="Ratio",y="Road Type"
                         ,caption = "Ratio= (Our Time-Google Time)*100/Our Time"
                         ,subtitle = "Sample with n=1500")
vplotrat2=vplotrat2+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
vplotrat2

vplotrat3=ggplot(maxspeed_len_fclass, aes(x=ratio_our_google, y=fclass,fill=fclass)) + geom_violin()
vplotrat3=vplotrat3+labs(title="Our/Google Ratio vs Road Type ",x="Ratio",y="Road Type"
                         ,subtitle="(For the sample has OSM Speed)",caption = "(Ratio= Our Time/Google Time)")
vplotrat3=vplotrat3+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
vplotrat3

vplotrat4=ggplot(maxspeed_len_fclass, aes(x=ratio_our_osm, y=fclass,fill=fclass)) + geom_violin()
vplotrat4=vplotrat4+labs(title="Our/OSM Ratio vs Road Type ",x="Ratio",y="Road Type"
                         ,subtitle="(For the sample has OSM Speed)",caption = "(Ratio= Our Time/OSM Time)")
vplotrat4=vplotrat4+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
vplotrat4

vplotrat5=ggplot(maxspeed_len_fclass, aes(x=ratio_osm_google, y=fclass,fill=fclass)) + geom_violin()
vplotrat5=vplotrat5+labs(title="OSM/Google Ratio vs Road Type ",x="Ratio",y="Road Type"
                         ,subtitle="(For the sample has OSM Speed)",caption = "(Ratio= OSM Time/Google Time)")
vplotrat5=vplotrat5+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
vplotrat5

vplotrat6=ggplot(maxspeed_len_fclass, aes(x=percent_dour_google, y=fclass,fill=fclass)) + geom_violin()
vplotrat6=vplotrat6+labs(title="Our&Google Ratio vs Road",x="Ratio",y="Road Type"
                         ,caption = "Ratio= (Our Time-Google Time)*100/Our Time")
vplotrat6=vplotrat6+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
vplotrat6

vplotrat7=ggplot(maxspeed_len_fclass, aes(x=percent_dour_dosm, y=fclass,fill=fclass)) + geom_violin()
vplotrat7=vplotrat7+labs(title="Our&OSM Ratio vs Road",x="Ratio",y="Road Type"
                         ,caption = "Ratio= (Our Time-OSM Time)*100/Our Time")
vplotrat7=vplotrat7+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
vplotrat7

vplotrat8=ggplot(maxspeed_len_fclass, aes(x=percent_dosm_dgoogle, y=fclass,fill=fclass)) + geom_violin()
vplotrat8=vplotrat8+labs(title="OSM&Google Ratio vs Road",x="Ratio",y="Road Type"
                         ,caption = "Ratio= (OSM Time-Google Time)*100/OSM Time")
vplotrat8=vplotrat8+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
vplotrat8

#To combine previous plots
ggarrange(vplotrat2,vplotrat6,vplotrat7,vplotrat8 + rremove("x.text"),labels = c("",""), ncol = 2, nrow = 2)

#To combine previous plots
ggarrange(vplotrat1,vplotrat3,vplotrat4,vplotrat5 + rremove("x.text"),labels = c("",""), ncol = 2, nrow = 2)


#Histograms for ratio of difference for google and our, (time_our-time_google)*100/time_our

rm(hist1)
hist1<-ggplot(subset(len_fclass, fclass=='primary') ,aes(x=percent_difference_our))  
hist1<-hist1+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist1=hist1+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist1=hist1+labs(title="Primary",x="Ratio of Difference",y="Density")
hist1

rm(hist2)
hist2<-ggplot(subset(len_fclass, fclass=='secondary') ,aes(x=percent_difference_our))  
hist2<-hist2+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist2=hist2+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist2=hist2+labs(title="Secondary",x="Ratio of Difference",y="Density")
hist2

rm(hist3)
hist3<-ggplot(subset(len_fclass, fclass=='tertiary') ,aes(x=percent_difference_our))  
hist3<-hist3+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist3=hist3+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist3=hist3+labs(title="Tertiary",x="Ratio of Difference",y="Density")
hist3

rm(hist4)
hist4<-ggplot(subset(len_fclass, fclass=='track') ,aes(x=percent_difference_our))  
hist4<-hist4+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist4=hist4+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist4=hist4+labs(title="Track",x="Ratio of Difference",y="Density")
hist4

rm(hist5)
hist5=ggplot(subset(len_fclass, fclass=='trunk') ,aes(x=percent_difference_our))  
hist5=hist5+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist5=hist5+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist5=hist5+labs(title="Trunk",x="Ratio of Difference",y="Density")
hist5

rm(hist6)
hist6=ggplot(subset(len_fclass, fclass=='unclassified') ,aes(x=percent_difference_our))  
hist6=hist6+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist6=hist6+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist6=hist6+labs(title="Unclassified",x="Ratio of Difference",y="Density")
hist6

#To combine previous plots
ggarrange(hist1,hist2,hist3,hist4,hist5,hist6 + rremove("x.text"),labels = c("",""), ncol = 3, nrow = 2)


###Plots for the difference for the data have variable max speed
#Histograms for ratio of difference for google and our (time_our-time_osm)*100/time_our

rm(hist1)
hist1<-ggplot(subset(maxspeed_len_fclass, fclass=='primary') ,aes(x=percent_dour_dosm))  
hist1<-hist1+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist1=hist1+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist1=hist1+labs(title="Primary",x="Ratio of Difference",y="Density")
hist1

rm(hist2)
hist2<-ggplot(subset(maxspeed_len_fclass, fclass=='secondary') ,aes(x=percent_dour_dosm))  
hist2<-hist2+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist2=hist2+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist2=hist2+labs(title="Secondary",x="Ratio of Difference",y="Density")
hist2

rm(hist3)
hist3<-ggplot(subset(maxspeed_len_fclass, fclass=='tertiary') ,aes(x=percent_dour_dosm))  
hist3<-hist3+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist3=hist3+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist3=hist3+labs(title="Tertiary",x="Ratio of Difference",y="Density")
hist3

rm(hist4)
hist4<-ggplot(subset(maxspeed_len_fclass, fclass=='track') ,aes(x=percent_dour_dosm))  
hist4<-hist4+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist4=hist4+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist4=hist4+labs(title="Track",x="Ratio of Difference",y="Density")
hist4

rm(hist5)
hist5=ggplot(subset(maxspeed_len_fclass, fclass=='trunk') ,aes(x=percent_dour_dosm))  
hist5=hist5+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist5=hist5+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist5=hist5+labs(title="Trunk",x="Ratio of Difference",y="Density")
hist5

rm(hist6)
hist6=ggplot(subset(maxspeed_len_fclass, fclass=='unclassified') ,aes(x=percent_dour_dosm))  
hist6=hist6+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist6=hist6+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist6=hist6+labs(title="Unclassified",x="Ratio of Difference",y="Density")
hist6

#To combine previous plots
ggarrange(hist1,hist2,hist3,hist4,hist5,hist6 + rremove("x.text"),labels = c("",""), ncol = 3, nrow = 2)

#Histograms for ratio of difference for google and our, (time_our-time_google)*100/time_our

rm(hist1)
hist1<-ggplot(subset(maxspeed_len_fclass, fclass=='primary') ,aes(x=percent_dour_google))  
hist1<-hist1+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist1=hist1+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist1=hist1+labs(title="Primary",x="Ratio of Difference",y="Density")
hist1

rm(hist2)
hist2<-ggplot(subset(maxspeed_len_fclass, fclass=='secondary') ,aes(x=percent_dour_google))  
hist2<-hist2+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist2=hist2+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist2=hist2+labs(title="Secondary",x="Ratio of Difference",y="Density")
hist2

rm(hist3)
hist3<-ggplot(subset(maxspeed_len_fclass, fclass=='tertiary') ,aes(x=percent_dour_google))  
hist3<-hist3+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist3=hist3+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist3=hist3+labs(title="Tertiary",x="Ratio of Difference",y="Density")
hist3

rm(hist4)
hist4<-ggplot(subset(maxspeed_len_fclass, fclass=='track') ,aes(x=percent_dour_google))  
hist4<-hist4+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist4=hist4+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist4=hist4+labs(title="Track",x="Ratio of Difference",y="Density")
hist4

rm(hist5)
hist5=ggplot(subset(maxspeed_len_fclass, fclass=='trunk') ,aes(x=percent_dour_google))  
hist5=hist5+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist5=hist5+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist5=hist5+labs(title="Trunk",x="Ratio of Difference",y="Density")
hist5

rm(hist6)
hist6=ggplot(subset(maxspeed_len_fclass, fclass=='unclassified') ,aes(x=percent_dour_google))  
hist6=hist6+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist6=hist6+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist6=hist6+labs(title="Unclassified",x="Ratio of Difference",y="Density")
hist6

#To combine previous plots
ggarrange(hist1,hist2,hist3,hist4,hist5,hist6 + rremove("x.text"),labels = c("",""), ncol = 3, nrow = 2)

#Histograms for ratio of difference for google and osm, (time_osm-time_google)*100/time_osm

rm(hist1)
hist1<-ggplot(subset(maxspeed_len_fclass, fclass=='primary') ,aes(x=percent_dosm_dgoogle))  
hist1<-hist1+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist1=hist1+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist1=hist1+labs(title="Primary",x="Ratio of Difference",y="Density")
hist1

rm(hist2)
hist2<-ggplot(subset(maxspeed_len_fclass, fclass=='secondary') ,aes(x=percent_dosm_dgoogle))  
hist2<-hist2+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist2=hist2+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist2=hist2+labs(title="Secondary",x="Ratio of Difference",y="Density")
hist2

rm(hist3)
hist3<-ggplot(subset(maxspeed_len_fclass, fclass=='tertiary') ,aes(x=percent_dosm_dgoogle))  
hist3<-hist3+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist3=hist3+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist3=hist3+labs(title="Tertiary",x="Ratio of Difference",y="Density")
hist3

rm(hist4)
hist4<-ggplot(subset(maxspeed_len_fclass, fclass=='track') ,aes(x=percent_dosm_dgoogle))  
hist4<-hist4+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist4=hist4+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist4=hist4+labs(title="Track",x="Ratio of Difference",y="Density")
hist4

rm(hist5)
hist5=ggplot(subset(maxspeed_len_fclass, fclass=='trunk') ,aes(x=percent_dosm_dgoogle))  
hist5=hist5+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist5=hist5+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist5=hist5+labs(title="Trunk",x="Ratio of Difference",y="Density")
hist5

rm(hist6)
hist6=ggplot(subset(maxspeed_len_fclass, fclass=='unclassified') ,aes(x=percent_dosm_dgoogle))  
hist6=hist6+geom_histogram(aes(y=..density..) , binwidth = 30,color="red",fill="orange")
hist6=hist6+ geom_density(alpha=0.1)+ theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist6=hist6+labs(title="Unclassified",x="Ratio of Difference",y="Density")
hist6

ggarrange(hist1,hist2,hist3,hist4,hist5,hist6 + rremove("x.text"),labels = c("",""), ncol = 3, nrow = 2)

###Difference vs Road length

#Plot for road length vs difference (google and our, (time_our-time_google)*100/time_our)

rm(l_plot1)
l_plot1=ggplot(subset(len_fclass, fclass=='primary'),aes(x = road_len_m, y = percent_difference_our)) 
l_plot1=l_plot1+geom_line(color="orange")
l_plot1= l_plot1 +labs(title="Primary ",x="Length in meter",y="Ratio of Difference ")
l_plot1

rm(l_plot2)
l_plot2=ggplot(subset(len_fclass, fclass=='secondary'),aes(x = road_len_m, y = percent_difference_our)) 
l_plot2=l_plot2+geom_line(color="orange")
l_plot2=l_plot2+labs(title="Secondary ",x="Length in meter",y="Ratio of Difference ")
l_plot2

rm(l_plot3)
l_plot3=ggplot(subset(len_fclass, fclass=='tertiary'),aes(x = road_len_m, y = percent_difference_our)) 
l_plot3=l_plot3+geom_line(color="orange")
l_plot3=l_plot3+labs(title="Tertiary ",x="Length in meter",y="Ratio of Difference ")
l_plot3

rm(l_plot4)
l_plot4=ggplot(subset(len_fclass, fclass=='track'),aes(x = road_len_m, y = percent_difference_our)) 
l_plot4=l_plot4+geom_line(color="orange")
l_plot4=l_plot4+labs(title="Track ",x="Length in meter",y="Ratio of Difference ")
l_plot4

rm(l_plot5)
l_plot5=ggplot(subset(len_fclass, fclass=='trunk'),aes(x = road_len_m, y = percent_difference_our)) 
l_plot5=l_plot5+geom_line(color="orange")
l_plot5=l_plot5+labs(title="Trunk ",x="Length in meter",y="Ratio of Difference ")
l_plot5

rm(l_plot6)
l_plot6=ggplot(subset(len_fclass, fclass=='unclassified'),aes(x = road_len_m, y = percent_difference_our)) 
l_plot6=l_plot6+geom_line(color="orange")
l_plot6=l_plot6+labs(title="Unclassified ",x="Length in meter",y="Ratio of Difference ")
l_plot6

ggarrange(l_plot1,l_plot2,l_plot3,l_plot4,l_plot5,l_plot6 + rremove("x.text"),labels = c("",""), ncol = 3, nrow = 2)

##Plots for the data have variable maxspeed
#Plot for road length vs difference (google and our, (time_our-time_google)*100/time_our)

rm(l_plot1)
l_plot1=ggplot(subset(maxspeed_len_fclass, fclass=='primary'),aes(x = road_len_m, y = percent_dour_google)) 
l_plot1=l_plot1+geom_line(color="orange")
l_plot1= l_plot1 +labs(title="Primary ",x="Length in meter",y="Ratio of Difference ")
l_plot1

rm(l_plot2)
l_plot2=ggplot(subset(maxspeed_len_fclass, fclass=='secondary'),aes(x = road_len_m, y = percent_dour_google)) 
l_plot2=l_plot2+geom_line(color="orange")
l_plot2=l_plot2+labs(title="Secondary ",x="Length in meter",y="Ratio of Difference ")
l_plot2

rm(l_plot3)
l_plot3=ggplot(subset(maxspeed_len_fclass, fclass=='tertiary'),aes(x = road_len_m, y = percent_dour_google)) 
l_plot3=l_plot3+geom_line(color="orange")
l_plot3=l_plot3+labs(title="Tertiary ",x="Length in meter",y="Ratio of Difference ")
l_plot3

rm(l_plot4)
l_plot4=ggplot(subset(maxspeed_len_fclass, fclass=='track'),aes(x = road_len_m, y = percent_dour_google)) 
l_plot4=l_plot4+geom_line(color="orange")
l_plot4=l_plot4+labs(title="Track ",x="Length in meter",y="Ratio of Difference ")
l_plot4

rm(l_plot5)
l_plot5=ggplot(subset(maxspeed_len_fclass, fclass=='trunk'),aes(x = road_len_m, y = percent_dour_google)) 
l_plot5=l_plot5+geom_line(color="orange")
l_plot5=l_plot5+labs(title="Trunk ",x="Length in meter",y="Ratio of Difference ")
l_plot5

rm(l_plot6)
l_plot6=ggplot(subset(maxspeed_len_fclass, fclass=='unclassified'),aes(x = road_len_m, y = percent_dour_google)) 
l_plot6=l_plot6+geom_line(color="orange")
l_plot6=l_plot6+labs(title="Unclassified ",x="Length in meter",y="Ratio of Difference ")
l_plot6

ggarrange(l_plot1,l_plot2,l_plot3,l_plot4,l_plot5,l_plot6 + rremove("x.text"),labels = c("",""), ncol = 3, nrow = 2)


#Plot for road length vs difference (osm and our, (time_our-time_osm)*100/time_our)

rm(l_plot1)
l_plot1=ggplot(subset(maxspeed_len_fclass, fclass=='primary'),aes(x = road_len_m, y = percent_dour_dosm)) 
l_plot1=l_plot1+geom_line(color="orange")
l_plot1= l_plot1 +labs(title="Primary ",x="Length in meter",y="Ratio of Difference ")
l_plot1

rm(l_plot2)
l_plot2=ggplot(subset(maxspeed_len_fclass, fclass=='secondary'),aes(x = road_len_m, y = percent_dour_dosm)) 
l_plot2=l_plot2+geom_line(color="orange")
l_plot2=l_plot2+labs(title="Secondary ",x="Length in meter",y="Ratio of Difference ")
l_plot2

rm(l_plot3)
l_plot3=ggplot(subset(maxspeed_len_fclass, fclass=='tertiary'),aes(x = road_len_m, y = percent_dour_dosm)) 
l_plot3=l_plot3+geom_line(color="orange")
l_plot3=l_plot3+labs(title="Tertiary ",x="Length in meter",y="Ratio of Difference ")
l_plot3

rm(l_plot4)
l_plot4=ggplot(subset(maxspeed_len_fclass, fclass=='track'),aes(x = road_len_m, y = percent_dour_dosm)) 
l_plot4=l_plot4+geom_line(color="orange")
l_plot4=l_plot4+labs(title="Track ",x="Length in meter",y="Ratio of Difference ")
l_plot4

rm(l_plot5)
l_plot5=ggplot(subset(maxspeed_len_fclass, fclass=='trunk'),aes(x = road_len_m, y = percent_dour_dosm)) 
l_plot5=l_plot5+geom_line(color="orange")
l_plot5=l_plot5+labs(title="Trunk ",x="Length in meter",y="Ratio of Difference ")
l_plot5

rm(l_plot6)
l_plot6=ggplot(subset(maxspeed_len_fclass, fclass=='unclassified'),aes(x = road_len_m, y = percent_dour_dosm)) 
l_plot6=l_plot6+geom_line(color="orange")
l_plot6=l_plot6+labs(title="Unclassified ",x="Length in meter",y="Ratio of Difference ")
l_plot6

ggarrange(l_plot1,l_plot2,l_plot3,l_plot4,l_plot5,l_plot6 + rremove("x.text"),labels = c("",""), ncol = 3, nrow = 2)


#Plot for road length vs difference (google and our, (time_our-time_google)*100/time_our)

rm(l_plot1)
l_plot1=ggplot(subset(maxspeed_len_fclass, fclass=='primary'),aes(x = road_len_m, y = percent_dour_google)) 
l_plot1=l_plot1+geom_line(color="orange")
l_plot1= l_plot1 +labs(title="Primary ",x="Length in meter",y="Ratio of Difference ")
l_plot1

rm(l_plot2)
l_plot2=ggplot(subset(maxspeed_len_fclass, fclass=='secondary'),aes(x = road_len_m, y = percent_dour_google)) 
l_plot2=l_plot2+geom_line(color="orange")
l_plot2=l_plot2+labs(title="Secondary ",x="Length in meter",y="Ratio of Difference ")
l_plot2

rm(l_plot3)
l_plot3=ggplot(subset(maxspeed_len_fclass, fclass=='tertiary'),aes(x = road_len_m, y = percent_dour_google)) 
l_plot3=l_plot3+geom_line(color="orange")
l_plot3=l_plot3+labs(title="Tertiary ",x="Length in meter",y="Ratio of Difference ")
l_plot3

rm(l_plot4)
l_plot4=ggplot(subset(maxspeed_len_fclass, fclass=='track'),aes(x = road_len_m, y = percent_dour_google)) 
l_plot4=l_plot4+geom_line(color="orange")
l_plot4=l_plot4+labs(title="Track ",x="Length in meter",y="Ratio of Difference ")
l_plot4

rm(l_plot5)
l_plot5=ggplot(subset(maxspeed_len_fclass, fclass=='trunk'),aes(x = road_len_m, y = percent_dour_google)) 
l_plot5=l_plot5+geom_line(color="orange")
l_plot5=l_plot5+labs(title="Trunk ",x="Length in meter",y="Ratio of Difference ")
l_plot5

rm(l_plot6)
l_plot6=ggplot(subset(maxspeed_len_fclass, fclass=='unclassified'),aes(x = road_len_m, y = percent_dour_google)) 
l_plot6=l_plot6+geom_line(color="orange")
l_plot6=l_plot6+labs(title="Unclassified ",x="Length in meter",y="Ratio of Difference ")
l_plot6

ggarrange(l_plot1,l_plot2,l_plot3,l_plot4,l_plot5,l_plot6 + rremove("x.text"),labels = c("",""), ncol = 3, nrow = 2)


#Plot for road length vs difference (google and osm, (time_osm-time_google)*100/time_osm)

rm(l_plot1)
l_plot1=ggplot(subset(maxspeed_len_fclass, fclass=='primary'),aes(x = road_len_m, y = percent_dosm_dgoogle)) 
l_plot1=l_plot1+geom_line(color="orange")
l_plot1= l_plot1 +labs(title="Primary ",x="Length in meter",y="Ratio of Difference ")
l_plot1

rm(l_plot2)
l_plot2=ggplot(subset(maxspeed_len_fclass, fclass=='secondary'),aes(x = road_len_m, y = percent_dosm_dgoogle)) 
l_plot2=l_plot2+geom_line(color="orange")
l_plot2=l_plot2+labs(title="Secondary ",x="Length in meter",y="Ratio of Difference ")
l_plot2

rm(l_plot3)
l_plot3=ggplot(subset(maxspeed_len_fclass, fclass=='tertiary'),aes(x = road_len_m, y = percent_dosm_dgoogle)) 
l_plot3=l_plot3+geom_line(color="orange")
l_plot3=l_plot3+labs(title="Tertiary ",x="Length in meter",y="Ratio of Difference ")
l_plot3

rm(l_plot4)
l_plot4=ggplot(subset(maxspeed_len_fclass, fclass=='track'),aes(x = road_len_m, y = percent_dosm_dgoogle)) 
l_plot4=l_plot4+geom_line(color="orange")
l_plot4=l_plot4+labs(title="Track ",x="Length in meter",y="Ratio of Difference ")
l_plot4

rm(l_plot5)
l_plot5=ggplot(subset(maxspeed_len_fclass, fclass=='trunk'),aes(x = road_len_m, y = percent_dosm_dgoogle)) 
l_plot5=l_plot5+geom_line(color="orange")
l_plot5=l_plot5+labs(title="Trunk ",x="Length in meter",y="Ratio of Difference ")
l_plot5

rm(l_plot6)
l_plot6=ggplot(subset(maxspeed_len_fclass, fclass=='unclassified'),aes(x = road_len_m, y = percent_dosm_dgoogle)) 
l_plot6=l_plot6+geom_line(color="orange")
l_plot6=l_plot6+labs(title="Unclassified ",x="Length in meter",y="Ratio of Difference ")
l_plot6

ggarrange(l_plot1,l_plot2,l_plot3,l_plot4,l_plot5,l_plot6 + rremove("x.text"),labels = c("",""), ncol = 3, nrow = 2)

#Graphs for speed values for the data have 250 samples for each category
#Histogram for speed values of Google for primary road type

rm(hist1)
hist1<-ggplot(subset(len_fclass, fclass=='primary') ,aes(x=speed_google))  
hist1<-hist1+geom_histogram(aes(y=..density..) , binwidth = 10,color="red",fill="orange")
hist1=hist1+theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist1=hist1+labs(title="Primary",x="Google Speed (km)",y="Density",caption = " Our Speed for Primary:80")
hist1=hist1+labs(caption = "Our Speed:80         \n   Google Mean:62.04   \n   Google Median:63.03")
hist1

#Histogram for speed values of Google for secondary road type

rm(hist2)
hist2<-ggplot(subset(len_fclass, fclass=='secondary') ,aes(x=speed_google))  
hist2<-hist2+geom_histogram(aes(y=..density..) , binwidth = 10,color="red",fill="orange")
hist2=hist2+theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist2=hist2+labs(title="Secondary",x="Google Speed (km)",y="Density",caption = " Our Speed for Secondary:50")
hist2=hist2+labs(caption = "Our Speed:50         \n   Google Mean:50.26   \n   Google Median:49.47")
hist2
summary(subset(len_fclass, fclass=='secondary'))

#Histogram for speed values of Google for tertiary road type

rm(hist3)
hist3<-ggplot(subset(len_fclass, fclass=='tertiary') ,aes(x=speed_google))  
hist3<-hist3+geom_histogram(aes(y=..density..) , binwidth = 10,color="red",fill="orange")
hist3=hist3+theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist3=hist3+labs(title="Tertiary",x="Google Speed (km)",y="Density",caption = " Our Speed for Tertiary:30")
hist3=hist3+labs(caption = "Our Speed:30         \n   Google Mean:44.57   \n    Google Median:45.63 ")
hist3
summary(subset(len_fclass, fclass=='tertiary'))

#Histogram for speed values of Google for track road type

rm(hist4)
hist4<-ggplot(subset(len_fclass, fclass=='track') ,aes(x=speed_google))  
hist4<-hist4+geom_histogram(aes(y=..density..) , binwidth = 10,color="red",fill="orange")
hist4=hist4+theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist4=hist4+labs(title="Track",x="Google Speed (km)",y="Density",caption = " Our Speed for Track:10")
hist4=hist4+labs(caption = "Our Speed:10         \n   Google Mean:34.11   \n   Google Median:36.81")
hist4
summary(subset(len_fclass, fclass=='track'))

#Histogram for speed values of Google for trunk road type

rm(hist5)
hist5=ggplot(subset(len_fclass, fclass=='trunk') ,aes(x=speed_google))  
hist5=hist5+geom_histogram(aes(y=..density..) , binwidth = 10,color="red",fill="orange")
hist5=hist5+theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist5=hist5+labs(title="Trunk",x="Google Speed (km)",y="Density",caption = " Our Speed for Trunk:80")
hist5=hist5+labs(caption = "Our Speed:80         \n   Google Mean:59.91   \n   Google Median:61.98")
hist5
summary(subset(len_fclass, fclass=='trunk'))

#Histogram for speed values of Google for unclassified road type

rm(hist6)
hist6=ggplot(subset(len_fclass, fclass=='unclassified') ,aes(x=speed_google))  
hist6=hist6+geom_histogram(aes(y=..density..) , binwidth = 10,color="red",fill="orange")
hist6=hist6+theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist6=hist6+labs(title="Unclassified",x="Google Speed (km)",y="Density",caption = " Our Speed for Unclassified:40")
hist6=hist6+labs(caption = "Our Speed:40         \n   Google Mean:34.55   \n   Google Median:32.52")
hist6
summary(subset(len_fclass, fclass=='unclassified'))


ggarrange(hist1,hist2,hist3,hist4,hist5,hist6 ,labels = c("",""), ncol = 3, nrow = 2) 

#Line chart for distance vs speed values of Google for primary road type

rm(l_plot1)
l_plot1=ggplot(subset(len_fclass, fclass=='primary'),aes(x = distance, y = speed_google)) 
l_plot1=l_plot1+geom_line(color="orange")
l_plot1= l_plot1 +labs(title="Primary ",x="Length (m)",y="Google Speed (km)")
l_plot1

#Line chart for distance vs speed values of Google for secondary road type

rm(l_plot2)
l_plot2=ggplot(subset(len_fclass, fclass=='secondary'),aes(x = distance, y = speed_google)) 
l_plot2=l_plot2+geom_line(color="orange")
l_plot2=l_plot2+labs(title="Secondary ",x="Length (m)",y="Google Speed (km)")
l_plot2

#Line chart for distance vs speed values of Google for tertiary road type

rm(l_plot3)
l_plot3=ggplot(subset(len_fclass, fclass=='tertiary'),aes(x = distance, y = speed_google)) 
l_plot3=l_plot3+geom_line(color="orange")
l_plot3=l_plot3+labs(title="Tertiary ",x="Length (m)",y="Google Speed (km)")
l_plot3

#Line chart for distance vs speed values of Google for track road type

rm(l_plot4)
l_plot4=ggplot(subset(len_fclass, fclass=='track'),aes(x = distance, y = speed_google)) 
l_plot4=l_plot4+geom_line(color="orange")
l_plot4=l_plot4+labs(title="Track ",x="Length (m)",y="Google Speed (km)")
l_plot4

#Line chart for distance vs speed values of Google for trunk road type

rm(l_plot5)
l_plot5=ggplot(subset(len_fclass, fclass=='trunk'),aes(x = distance, y = speed_google)) 
l_plot5=l_plot5+geom_line(color="orange")
l_plot5=l_plot5+labs(title="Trunk ",x="Length (m)",y="Google Speed (km)")
l_plot5

#Line chart for distance vs speed values of Google for unclassified road type

rm(l_plot6)
l_plot6=ggplot(subset(len_fclass, fclass=='unclassified'),aes(x = distance, y = speed_google)) 
l_plot6=l_plot6+geom_line(color="orange")
l_plot6=l_plot6+labs(title="Unclassified ",x="Length (m)",y="Google Speed (km)")
l_plot6

ggarrange(l_plot1,l_plot2,l_plot3,l_plot4,l_plot5,l_plot6 ,labels = c("",""), ncol = 3, nrow = 2)

#Histogram for speed values of OSM for primary road type

rm(hist1)
hist1<-ggplot(subset(maxspeed_len_fclass, fclass=='primary') ,aes(x=maxspeed))  
hist1<-hist1+geom_histogram(aes(y=..density..) , binwidth = 10,color="red",fill="orange")
hist1=hist1+theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist1=hist1+labs(title="Primary",x="OSM Speed (km)",y="Density",caption = " Our Speed for Primary:80")
hist1=hist1+labs(caption = "     Our Speed:80         \n     OSM Mean:76.77   \nOSM Median:80")
hist1

#Histogram for speed values of OSM for secondary road type

rm(hist2)
hist2<-ggplot(subset(maxspeed_len_fclass, fclass=='secondary') ,aes(x=maxspeed))  
hist2<-hist2+geom_histogram(aes(y=..density..) , binwidth = 10,color="red",fill="orange")
hist2=hist2+theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist2=hist2+labs(title="Secondary",x="OSM Speed (km)",y="Density",caption = " Our Speed for Secondary:50")
hist2=hist2+labs(caption = "        Our Speed:50         \n   OSM Mean:72   \n   OSM Median:80")
hist2
summary(subset(maxspeed_len_fclass, fclass=='secondary'))

#Histogram for speed values of OSM for tertiary road type

rm(hist3)
hist3<-ggplot(subset(maxspeed_len_fclass, fclass=='tertiary') ,aes(x=maxspeed))  
hist3<-hist3+geom_histogram(aes(y=..density..) , binwidth = 10,color="red",fill="orange")
hist3=hist3+theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist3=hist3+labs(title="Tertiary",x="OSM Speed (km)",y="Density",caption = " Our Speed for Tertiary:30")
hist3=hist3+labs(caption = "    Our Speed:30         \n    OSM Mean:54.62   \nOSM Median:60 ")
hist3
summary(subset(maxspeed_len_fclass, fclass=='tertiary'))

#Histogram for speed values of OSM for maxspeed road type

rm(hist4)
hist4<-ggplot(subset(maxspeed_len_fclass, fclass=='track') ,aes(x=maxspeed))  
hist4<-hist4+geom_histogram(aes(y=..density..) , binwidth = 10,color="red",fill="orange")
hist4=hist4+theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist4=hist4+labs(title="Track",x="OSM Speed (km)",y="Density",caption = " Our Speed for Track:10")
hist4=hist4+labs(caption = "     Our Speed:10         \n     OSM Mean:42.33   \nOSM Median:40")
hist4
summary(subset(maxspeed_len_fclass, fclass=='track'))

#Histogram for speed values of OSM for trunk road type

rm(hist5)
hist5=ggplot(subset(maxspeed_len_fclass, fclass=='trunk') ,aes(x=maxspeed))  
hist5=hist5+geom_histogram(aes(y=..density..) , binwidth = 10,color="red",fill="orange")
hist5=hist5+theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist5=hist5+labs(title="Trunk",x="OSM Speed (km)",y="Density",caption = " Our Speed for Trunk:80")
hist5=hist5+labs(caption = "     Our Speed:80         \n     OSM Mean:83.44   \nOSM Median:80")
hist5
summary(subset(maxspeed_len_fclass, fclass=='trunk'))

#Histogram for speed values of OSM for unclassified road type

rm(hist6)
hist6=ggplot(subset(maxspeed_len_fclass, fclass=='unclassified') ,aes(x=maxspeed))  
hist6=hist6+geom_histogram(aes(y=..density..) , binwidth = 10,color="red",fill="orange")
hist6=hist6+theme(plot.caption = element_text(hjust = 0.5),legend.position = "none")
hist6=hist6+labs(title="Unclassified",x="OSM Speed (km)",y="Density",caption = " Our Speed for Unclassified:40")
hist6=hist6+labs(caption = "     Our Speed:40         \n     OSM Mean:49.06   \nOSM Median:50")
hist6
summary(subset(maxspeed_len_fclass, fclass=='unclassified'))

ggarrange(hist1,hist2,hist3,hist4,hist5,hist6 ,labels = c("",""), ncol = 3, nrow = 2)


#Line chart for distance vs speed values of OSM for primary road type

rm(l_plot1)
l_plot1=ggplot(subset(maxspeed_len_fclass, fclass=='primary'),aes(x = distance, y = maxspeed)) 
l_plot1=l_plot1+geom_line(color="orange")
l_plot1= l_plot1 +labs(title="Primary ",x="Length (m)",y="OSM Speed (km)")
l_plot1

#Line chart for distance vs speed values of OSM for secondary road type

rm(l_plot2)
l_plot2=ggplot(subset(maxspeed_len_fclass, fclass=='secondary'),aes(x = distance, y = maxspeed)) 
l_plot2=l_plot2+geom_line(color="orange")
l_plot2=l_plot2+labs(title="Secondary ",x="Length (m)",y="OSM Speed (km)")
l_plot2

#Line chart for distance vs speed values of OSM for tertiary road type

rm(l_plot3)
l_plot3=ggplot(subset(maxspeed_len_fclass, fclass=='tertiary'),aes(x = distance, y = maxspeed)) 
l_plot3=l_plot3+geom_line(color="orange")
l_plot3=l_plot3+labs(title="Tertiary ",x="Length (m)",y="OSM Speed (km)")
l_plot3

#Line chart for distance vs speed values of OSM for track road type

rm(l_plot4)
l_plot4=ggplot(subset(maxspeed_len_fclass, fclass=='track'),aes(x = distance, y = maxspeed)) 
l_plot4=l_plot4+geom_line(color="orange")
l_plot4=l_plot4+labs(title="Track ",x="Length (m)",y="OSM Speed (km)")
l_plot4

#Line chart for distance vs speed values of OSM for trunk road type

rm(l_plot5)
l_plot5=ggplot(subset(maxspeed_len_fclass, fclass=='trunk'),aes(x = distance, y = maxspeed)) 
l_plot5=l_plot5+geom_line(color="orange")
l_plot5=l_plot5+labs(title="Trunk ",x="Length (m)",y="OSM Speed (km)")
l_plot5

#Line chart for distance vs speed values of OSM for unclassified road type

rm(l_plot6)
l_plot6=ggplot(subset(maxspeed_len_fclass, fclass=='unclassified'),aes(x = distance, y = maxspeed)) 
l_plot6=l_plot6+geom_line(color="orange")
l_plot6=l_plot6+labs(title="Unclassified ",x="Length (m)",y="OSM Speed (km)")
l_plot6

ggarrange(l_plot1,l_plot2,l_plot3,l_plot4,l_plot5,l_plot6 ,labels = c("",""), ncol = 3, nrow = 2)