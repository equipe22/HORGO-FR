# An ontology-based temporal database to describe the hospital organizational structures ####
# Creation : 2019-04-02
# Last modification : 2019-04-02
# V Looten, C Khnaisser

mindate <- "2013-01-01"
maxdate <- "2019-01-01"

# Load packages  ####
listepackages<-c("tidyverse","ggplot2","lubridate","rmarkdown","cowplot")
for (pack in listepackages) {
  if (!is.element(pack, installed.packages()[,1])){
    install.packages(pack, dep = TRUE)
  }
  eval(parse(text=paste0("library(",pack,")")))
}
rm(pack)

theme_gantt <- function(base_size=11, base_family="Source Sans Pro Light") {
  ret <- theme_bw(base_size, base_family) %+replace%
    theme(panel.background = element_rect(fill="#ffffff", colour=NA),
          axis.title.x=element_text(vjust=-0.2), axis.title.y=element_text(vjust=1.5),
          title=element_text(vjust=1.2, family="Source Sans Pro Semibold"),
          panel.border = element_blank(), axis.line=element_blank(),
          panel.grid.minor=element_blank(),
          panel.grid.major.y = element_blank(),
          panel.grid.major.x = element_line(size=0.5, colour="grey80"),
          axis.ticks=element_blank(),
          legend.position="bottom", 
          axis.title=element_text(size=rel(0.8), family="Source Sans Pro Semibold"),
          strip.text=element_text(size=rel(1), family="Source Sans Pro Semibold"),
          strip.background=element_rect(fill="#ffffff", colour=NA),
          panel.spacing.y=unit(1.5, "lines"),
          legend.key = element_blank())
  ret
}

# Load data ####
data_codes <- readRDS("data_codes.rds")
data_struct_AP <- read.csv("Structure_nutrition_HAP.csv", stringsAsFactors = F)
data_struct_HEGP <- read.csv("Structure_nutrition_HEGP.csv", stringsAsFactors = F)
data_struct_CCV <- read.csv("Structure_specialite-CCV-ANESTHESIE.csv", stringsAsFactors = F)
data_codes_cdw <- readRDS("data_hegp_rea.rds")

# Data preprocessing ####
data_codes$keyident <- paste0(data_codes$ident,"_",data_codes$annee)
#
data_struct_AP$START_DATE <- ymd(lapply(strsplit(x = data_struct_AP$validtime,","), `[[`, 1))
try(data_struct_AP$START_DATE[is.na(data_struct_AP$START_DATE)] <- ymd(mindate))
data_struct_AP$END_DATE <- ymd(lapply(strsplit(x = data_struct_AP$validtime,","), `[[`, 2))
try(data_struct_AP$END_DATE[is.na(data_struct_AP$END_DATE)] <- ymd(maxdate))
#
data_struct_HEGP$START_DATE <- ymd(lapply(strsplit(x = data_struct_HEGP$validtime,","), `[[`, 1))
try(data_struct_HEGP$START_DATE[is.na(data_struct_HEGP$START_DATE)] <- ymd(mindate))
data_struct_HEGP$END_DATE <- ymd(lapply(strsplit(x = data_struct_HEGP$validtime,","), `[[`, 2))
try(data_struct_HEGP$END_DATE[is.na(data_struct_HEGP$END_DATE)] <- ymd(maxdate))
#
data_struct_CCV$START_DATE <- ymd(lapply(strsplit(x = data_struct_CCV$validtime,","), `[[`, 1))
try(data_struct_CCV$START_DATE[is.na(data_struct_CCV$START_DATE)] <- ymd(mindate))
data_struct_CCV$END_DATE <- ymd(lapply(strsplit(x = data_struct_CCV$validtime,","), `[[`, 2))
try(data_struct_CCV$END_DATE[is.na(data_struct_CCV$END_DATE)] <- ymd(maxdate))

# Plot 1 ####

list_finess <- unique(data_codes$finess)
datapat_0 <- data_codes %>% group_by(mois,annee) %>% summarise(count_total=n_distinct(anonyme))
datapat <- data_codes %>% group_by(mois,annee,finess) %>% summarise(count_hospital=n_distinct(anonyme))
datapat <- left_join(datapat,datapat_0, by=c("mois","annee"))
datapat$relative_act <- datapat$count_hospital/datapat$count_total
datapat$time <- ymd(paste0(datapat$annee,"_",datapat$mois,"_01"))

# Plot activity ####
# Number of patients
length(unique(data_codes$anonyme[which(data_codes$finess=='750803447')]))
length(unique(data_codes$anonyme[which(data_codes$finess=='920100013')]))

length(unique(data_codes$keyident[which(data_codes$finess=='750803447')]))
length(unique(data_codes$keyident[which(data_codes$finess=='920100013')]))

# Ambroise Paré hospital : 920100013
# HEGP : 750803447
data_activity <- datapat %>% filter(finess %in% c('750803447','920100013') )
data_activity$finess <- as.factor(data_activity$finess)
activity <- ggplot(data_activity,aes(x = time, y=relative_act,col=finess)) + geom_point(aes(fill=finess)) +
  ylab("Relative proportion of patients") + xlab("") + 
  theme(axis.text.x = element_text(angle=45, hjust = 1, size=7), legend.position = "none",
        axis.text.y = element_text(size=7),
        panel.background = element_blank(), 
        panel.border = element_blank(), 
        panel.grid.major = element_line(colour = "grey", size = 0.5, linetype = "dashed"), 
        panel.grid.minor = element_blank(),
        axis.title=element_text(size=7, family="Source Sans Pro Semibold")) +
  scale_x_date(breaks = seq(as.Date(mindate), as.Date(maxdate), by="6 months"), date_labels = "%m/%Y",
               limits = as.Date(c(mindate,maxdate)) )
ggsave("Figure_1_activity.jpg",activity,device = "jpeg", dpi=600)

# Timeline HEGP ####
data_structg <- data_struct_HEGP %>% filter(label!="CANCEROLOGIE SPEC")
data_structg$START_DATE <- pmax(data_structg$START_DATE,ymd(mindate))
data_structg$unitcategory_en <- gsub("[[:space:]]","",data_structg$unitcategory_en)
data_structg$STRUCT_NAME <- paste0(data_structg$label," (id:",data_structg$id,")")
data_structg <- data_structg[,c("unitcategory_en","START_DATE","END_DATE", "STRUCT_NAME")]
data_structg$unitcategory_en <- factor(data_structg$unitcategory_en, levels = c("FU", "HDIV", "HU", "MAU", "MC", "MGU", "SD"))
tasks.long <- data_structg %>%
  mutate(START_DATE = ymd(START_DATE),
         END_DATE = ymd(END_DATE)) %>%
  gather(date.type, task.date, -c(unitcategory_en, STRUCT_NAME)) %>%
  arrange(date.type, task.date) %>%
  mutate(STRUCT_NAME = factor(STRUCT_NAME, levels=rev(unique(STRUCT_NAME)), ordered=TRUE))
x.breaks <- seq(length(data_structg$STRUCT_NAME) + 0.5 - 3, 0, by=-3)
tasks.long$unitcategory_en <- factor(tasks.long$unitcategory_en, levels = c("FU", "HDIV", "HU", "MAU", "MC", "MGU", "SD"))
timeline_hegp <- ggplot(tasks.long, aes(x=STRUCT_NAME, y=task.date, colour=unitcategory_en)) + 
  geom_line(size = 3) + scale_colour_discrete(drop=FALSE) +
  geom_vline(xintercept=x.breaks, colour="grey80", linetype="dotted") + 
  guides(colour=guide_legend(title=NULL)) + guides(colour = guide_legend(nrow = 1))+
  labs(x=NULL, y=NULL) + coord_flip() + 
  scale_y_date(breaks = seq(as.Date(mindate), as.Date(maxdate), by="6 months"), date_labels = "%m/%Y",
               limits = as.Date(c(mindate,maxdate)) ) +
  theme_gantt() + theme(axis.text.x=element_text(angle=45, hjust=1),legend.position = "top")

ggsave("Figure_1_nutrition_hegp.jpg",timeline_hegp,device = "jpeg", dpi=600)


# Timeline AP ####
data_structg <- data_struct_AP
data_structg$START_DATE <- pmax(data_structg$START_DATE,ymd(mindate))
data_structg$unitcategory_en <- gsub("[[:space:]]","",data_structg$unitcategory_en)
data_structg$STRUCT_NAME <- paste0(data_structg$label," (id:",data_structg$id,")")
data_structg <- data_structg[,c("unitcategory_en","START_DATE","END_DATE", "STRUCT_NAME")]
data_structg$unitcategory_en <- factor(data_structg$unitcategory_en, levels = c("FU", "HDIV", "HU", "MAU", "MC", "MGU", "SD"))
tasks.long <- data_structg %>%
  mutate(START_DATE = ymd(START_DATE),
         END_DATE = ymd(END_DATE)) %>%
  gather(date.type, task.date, -c(unitcategory_en, STRUCT_NAME)) %>%
  arrange(date.type, task.date) %>%
  mutate(STRUCT_NAME = factor(STRUCT_NAME, levels=rev(unique(STRUCT_NAME)), ordered=TRUE))
x.breaks <- seq(length(data_structg$STRUCT_NAME) + 0.5 - 3, 0, by=-3)
timeline_ap <- ggplot(tasks.long, aes(x=STRUCT_NAME, y=task.date, colour=unitcategory_en)) + 
  geom_line(size = 3) + scale_colour_discrete(drop=FALSE) +
  geom_vline(xintercept=x.breaks, colour="grey80", linetype="dotted") + 
  guides(colour=guide_legend(title=NULL)) + guides(colour = guide_legend(nrow = 1))+
  labs(x=NULL, y=NULL) + coord_flip() +
  scale_y_date(breaks = seq(as.Date(mindate), as.Date(maxdate), by="6 months"), date_labels = "%m/%Y",
               limits = as.Date(c(mindate,maxdate)) ) +
  theme_gantt() + theme(axis.text.x=element_text(angle=45, hjust=1),legend.position = "top")
ggsave("Figure_1_nutrition_ap.jpg",timeline_ap,device = "jpeg", dpi=600)

# Compute the figure 1 plot ####
plot2by2 <- plot_grid(activity, timeline_hegp, timeline_ap, labels = c("A", "B", "C"), ncol = 1)
# ggsave(plot2by2)
# ggsave("plot2by2.jpg",plot2by2,device = "jpeg", dpi=600)
save_plot("Figure_1_Combined.jpg", plot2by2,
          ncol = 1,
          nrow = 3,base_height = 6.49/2, base_width = 8.5)

# Plot 2 ####
maxdate <- "2019-04-01"

# Activity resuscitation HEGP ####
data_codes_cdw$month <- month(data_codes_cdw$END_DATE)
data_codes_cdw$year <- year(data_codes_cdw$END_DATE)
data_prov2 <- data_codes_cdw %>% group_by(month,year,PROVIDER_ID) %>% summarise(count_provider=n_distinct(ENCOUNTER_NUM))
data_prov2$time <- ymd(paste0(data_prov2$year,"_",data_prov2$month,"_01"))
data_prov2$PROVIDER_ID <- as.factor(data_prov2$PROVIDER_ID)
levels(data_prov2$PROVIDER_ID) <- c("HU 331", "HU 339", "HU 681", "HU 682")
activity_cdw <- ggplot(data_prov2,aes(x = time, y=count_provider,col=PROVIDER_ID)) + geom_point(aes(fill=PROVIDER_ID), size=2) +
  ylab("Number of hospitalization") + xlab("") + geom_vline(xintercept=ymd("2018-09-01")) +
  geom_vline(xintercept=ymd(maxdate)) + scale_colour_discrete(drop=FALSE) +
  theme(axis.text.x = element_text(angle=45, hjust = 1, size=7),
        axis.text.y = element_text(size=7),
        panel.background = element_blank(), 
        panel.border = element_blank(), 
        panel.grid.major = element_line(colour = "grey", size = 0.5, linetype = "dashed"), 
        panel.grid.minor = element_blank(),
        axis.title=element_text(size=7, family="Source Sans Pro Semibold")) +
  scale_x_date(breaks = seq(as.Date(mindate), as.Date(maxdate), by="6 months"), date_labels = "%m/%Y",
               limits = as.Date(c(mindate,maxdate)) ) + 
  theme(axis.text.x=element_text(angle=45, hjust=1),legend.position = "top")

ggsave("Figure_2_activity_cdw",activity_cdw,device = "jpeg", dpi=600)

# Timeline  ####
data_structg <- data_struct_CCV
data_structg$START_DATE <- pmax(data_structg$START_DATE,ymd(mindate))
data_structg$unitcategory_en <- gsub("[[:space:]]","",data_structg$unitcategory_en)
idx_select <- which( (data_structg$unitcategory_en=="HU" & data_structg$id %in% c("331","339","681","682") ) |
                       (data_structg$unitcategory_en=="MAU" & data_structg$id %in% c("556","386") ) |
                       (data_structg$unitcategory_en=="MGU" & data_structg$id %in% c("0613","0332") ) |
                       (data_structg$unitcategory_en=="UG" & data_structg$id %in% c("337","610") ) |
                       (data_structg$unitcategory_en=="HDIV" & data_structg$id %in% c("103","105") ) |
                       (data_structg$unitcategory_en=="MC" & data_structg$id %in% c("075") ) |
                       (data_structg$unitcategory_en=="SD" & data_structg$id %in% c("55","38") ) |
                       (data_structg$unitcategory_en=="UF" & data_structg$supid %in% c("103","105") ))
data_structg <- data_structg[idx_select,]

data_structg$STRUCT_NAME <- paste0(data_structg$label," (id:",data_structg$id,")")
data_structg <- data_structg[,c("unitcategory_en","START_DATE","END_DATE", "STRUCT_NAME")]
data_structg$unitcategory_en <- factor(data_structg$unitcategory_en, levels = c("FU", "HDIV", "HU", "MAU", "MC", "MGU", "SD"))
tasks.long <- data_structg %>%
  mutate(START_DATE = ymd(START_DATE),
         END_DATE = ymd(END_DATE)) %>%
  gather(date.type, task.date, -c(unitcategory_en, STRUCT_NAME)) %>%
  arrange(date.type, task.date) %>%
  mutate(STRUCT_NAME = factor(STRUCT_NAME, levels=rev(unique(STRUCT_NAME)), ordered=TRUE))
x.breaks <- seq(length(data_structg$STRUCT_NAME) + 0.5 - 3, 0, by=-3)
timeline_ccv <- ggplot(tasks.long, aes(x=STRUCT_NAME, y=task.date, colour=unitcategory_en)) + 
  geom_line(size = 3) + scale_colour_discrete(drop=FALSE) +
  geom_vline(xintercept=x.breaks, colour="grey80", linetype="dotted") + 
  guides(colour=guide_legend(title=NULL)) + guides(colour = guide_legend(nrow = 1))+
  labs(x=NULL, y=NULL) + coord_flip() +
  scale_y_date(breaks = seq(as.Date(mindate), as.Date(maxdate), by="6 months"), date_labels = "%m/%Y",
               limits = as.Date(c(mindate,maxdate)) ) +
  theme_gantt() + theme(axis.text.x=element_text(angle=45, hjust=1),legend.position = "top")
ggsave("Figure_2_data_struct_CCV.jpg",timeline_ccv,device = "jpeg", dpi=600)

# Compute the figure 2 plot ####
plot2by2 <- plot_grid(activity_cdw, timeline_ccv, labels = c("A", "B"), ncol = 1)
save_plot("Figure_2_Combined.jpg", plot2by2,
          ncol = 1,
          nrow = 3,base_height = 6.49/2, base_width = 8.5)



