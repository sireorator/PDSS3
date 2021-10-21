# Problem set 2. 
# Adapted from Statistics for linguists (Bodo Winters).

#2.1 Please, take your time to review the tidyverse style guide: 
# http://style.tidyverse.org/


#2.2 Now, have a look at the RStudio keyboard shortcut list:
#  https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts


#2.3 Cool, right? Now, think about which shortcuts you want to use in the future in your practice.
install.packages('readr')
library(readr)
library(tidyverse)

#2.4 Let's Subset a data frame with Tidyverse Function
# This exercise uses the nettle data frame to explore different ways of indexing using filter() and select(). First, load in the nettle data:
nettle <- read.csv('nettle_1999_climate.csv')
head(nettle) # display first 6 rows
nettle
#Next, attempt to understand what the following commands do. Then execute them in R and see whether the output matches your expectations.
filter(nettle, Country== 'Benin')
#above we filter out of the Benin from the dataset
filter(nettle, Country %in% c('Benin', 'Zaire'))
#above we filter out of the Benin and Zairefrom the dataset
select(nettle, Langs)
#here we select only the language column 
filter(nettle, Country == 'Benin') %>% select(Langs)
#select the language column for Benin and give the output
filter(nettle, Country == 'Benin') %>%
  select(Population:MGS)
#From the dataset, select Benin and give the population, area and MGS
filter(nettle, Langs > 200)
#select data with language value greater than 200 from nettle
filter(nettle, Langs > 200, Population < median(Population))
#select data with value greater than 200 

#2.5 Exercise: Creating a Pipeline
#Execute the following code in R (you may omit the comments for now) and then read the explanation below.
# Reduce the nettle tibble to small countries:
smallcountries <- filter(nettle, Population < 4)
# Create categorical MGS variable:
nettle_MGS <- mutate(smallcountries,
                     MGS_cat = ifelse(MGS < 6, 'dry', 'fertile'))
# Group tibble for later summarizing:
nettle_MGS_grouped <- group_by(nettle_MGS, MGS_cat)
# Compute language counts for categorical MGS variable:
summarize(nettle_MGS_grouped, LangSum = sum(Langs))
#The previous code reduces the nettle tibble to small countries (Population < 4). The resulting tibble, smallcountries, is changed using the ifelse() function. In this case, the function splits the dataset into countries with high and low ecological risk, using six months as a threshold. The ifelse() function spits out 'dry' when MGS < 6 is TRUE and 'fertile' when MGS < 6 is FALSE. Then, the resulting tibble is grouped by this categorical ecological risk measure. As a result of the grouping, the subsequently executed summarize() function knows that summary statistics should be computed based on this grouping variable. This code is quite cumbersome! In particular, there are many intervening tibbles (smallcountries, nettle_MGS, and nettle_MGS_grouped) that might not be used anywhere else in the analysis. For example, the grouping is only necessary so that the summarize() function knows what groups to perform summary statistics for. These tibbles are fairly dispensable. Can you condense all of these steps into a single pipeline where the nettle tibble is first piped to filter(), then to mutate(), then to group_by(), and finally to summarize()?


#2.6. Plotting a Histogram of the Emotional Valence Ratings:
#With the Warriner et al. (2013) data, create a ggplot2 histogram and plot the mean as a vertical line into the plot using geom_vline() and the xintercept aesthetic. Can you additionally add vertical dashed lines to indicate where 68% and 95% of the data lie? (Ignore any warning messages about binwidth that may arise).

war <- read.csv('warriner_2013_emotional_valence.csv', sep = ",")
war
install.packages("ggplot2")
library(ggplot2)
meanval= mean(war$Val)
meanval

ggplot(war, aes(x = Val)) +
  geom_histogram(fill = 'peachpuff3') +
  geom_vline(aes(xintercept = meanval), linetype = 2, 
             color = "blue", size=1.5) +
  geom_vline(xintercept=c(quantile(war$Val,0.68),quantile(war$Val,0.95)), linetype="dotted")+
  theme_minimal()

#2.7 Plotting Density Graphs:
#In the plot you created in the last exercise, exchange geom_histogram() with geom_density(), which produces a kernel density graph. This is a plot that won't be covered in this book, but by looking at it you may be able to figure out that it is essentially a smoothed version of a histogram. There are many other geoms to explore. Check out the vast ecosystem of online tutorials for different types of ggplot2 functions.
ggplot(war, aes(x=Val)) +
  geom_density(fill = 'peachpuff3', col= 'red') +
  geom_vline(aes(xintercept = mean(war$Val)), linetype = 1) +
  theme_minimal()

ggplot(war, aes(x=Val, y =Word)) +
  geom_point(fill = 'red', color= 'seagreen') +
  geom_vline(aes(xintercept = mean(war$Val)), linetype = 3) +
  theme_minimal() 
install.packages('plotly')
library(plotly)
ggplotly(ggplot(war, aes(x=Val, y =Word)) +
           geom_point(fill = 'red', color= 'seagreen') +
           geom_vline(aes(xintercept = mean(war$Val)), linetype = 3) +
           theme_minimal())
