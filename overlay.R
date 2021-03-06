# This script will overlay multiple recordings together

# Import packages
library(broom)

plot1_name <- readline(prompt = "Enter name of first csv file to plot: ")
plot2_name <- readline(prompt = "Enter name of second csv file to plot: ")

# load, explore and process the datasset
plot1 <- read.csv(paste0(dir_name, "/", plot1_name, ".csv"))
plot2 <- read.csv(paste0(dir_name, "/", plot2_name, ".csv"))

# Making variables to be used for plotting trace
t <- plot1$Time
y1 <- plot1$Micromolar # first trace
y2 <- plot2$Micromolar # second trace

# Reorganize data 
df4 <- tibble(t = t, y = y1, condition = 'Control') %>% 
  rbind(. , data.frame(t = t, y = y2, condition = 'Drug'))

# define color scheme
cls <- c("Control"="black", "Drug"="red")

overlay_plot <- df4%>%
  ggplot(aes(x=t, y=y , colour = condition)) + 
  geom_line() +
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  labs(x = "Time (s)", y = paste0(nt, " uM")) +
  scale_color_manual(values = cls)
ggplotly(overlay_plot)

# Saves single trace to folder
ggsave(paste0(dir_name,"/", rem_ext,"_", plot1_name, "_", plot2_name, ".png"))

# Prints out to move to the following bit of code
cat(red("Move to line 32!"))


