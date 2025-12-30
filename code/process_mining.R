# packages 
library(tidyverse)
library(lubridate)
library(scales)
library(bupaR)
# data - hospital billing 

# EDA -----------------------
df <- hospital_billing
table(df$activity)
df %>% summarise(count = n_distinct(resource))

df <- df %>% mutate(date = as.Date(timestamp))
df <- df %>% mutate(weekday = wday(date, label = TRUE)) 
# sum of entries
df %>% group_by(date, weekday) %>% summarise(n = n())
# plot by years
df %>% group_by(date, weekday) %>% 
  summarise(n = n()) %>% 
  ggplot(aes(date,n)) + geom_line(aes(color = weekday)) + 
  theme(panel.background = element_rect(color = 'black', fill = 'white'),
        panel.grid.major = element_blank(),legend.title = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(face = "bold", color = '#1F618D')) +  
  xlab('') + ylab('') + 
  ggtitle(label = 'Sum of entries by weekdays')

# plot by weekday

# custom colours
palette <- c("#005b96", "#008080", "#004c4c", 'steelblue1', 'violet', 'wheat2',
             'red4', 'purple2', 'navy', 'maroon4') 

df %>% filter(!is.na(state)) %>% 
  ggplot(aes(weekday)) + geom_histogram(stat = 'count',
                                        aes(fill = state)) +
  scale_fill_manual(values = palette) +
  theme(panel.background = element_rect(color = 'black', fill = 'white'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(face = "bold", color = '#1F618D')) + 
  xlab('') + ylab('') + 
  ggtitle(label = 'Sum of entries by weekdays') + 
  guides(fill = guide_legend('Activities')) 

# standard times for activities 
df <- df %>% mutate(minutes = minute(timestamp))
activity_time <- df %>% group_by(case_id, activity, minutes) %>% 
  summarise(count = n())

# mean activity times 
activity_time %>% group_by(activity) %>% summarise(mean(minutes))

# bupaR - Process Mapping # bupplot()aR - Process Mapping 
# Activity Presence
df %>% activity_presence() %>% plot() + 
  theme(panel.background = element_rect(color = 'black', fill = 'white'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) 

# idle time - when there is no activity in a case or for a resource
df %>% idle_time('resource', units = 'days')

# processing time 
df %>% processing_time('activity') %>% plot

# frequency map 
df %>% process_map(frequency('absolute'))

# animate process map 
library(processanimateR)
animate_process(df, mode = "relative", jitter = 10, legend = "color",
                mapping = token_aes(color = token_scale("employee", 
                                                        scale = "ordinal", range = RColorBrewer::brewer.pal(7, "Paired"))))