# Problem set 2. 
# Adapted from Statistics for linguists (Bodo Winters).

#2.1 Please, take your time to review the tidyverse style guide: 
# http://style.tidyverse.org/


#2.2 Now, have a look at the RStudio keyboard shortcut list:
#  https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts


#2.3 Cool, right? Now, think about which shortcuts you want to use in the future in your practice.


#2.4 Let's Subset a data frame with Tidyverse Function
# This exercise uses the nettle data frame to explore different ways of indexing using filter() and select(). First, load in the nettle data:
nettle <- read.csv('nettle_1999_climate.csv')
head(nettle) # display first 6 rows
#Next, attempt to understand what the following commands do. Then execute them in R and see whether the output matches your expectations.
filter(nettle, Country == 'Benin')
filter(nettle, Country %in% c('Benin', 'Zaire'))
select(nettle, Langs)
filter(nettle, Country == 'Benin') %>% select(Langs)
filter(nettle, Country == 'Benin') %>%
  select(Population:MGS)
filter(nettle, Langs > 200)
filter(nettle, Langs > 200, Population < median(Population))


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


#2.7 Plotting Density Graphs:
#In the plot you created in the last exercise, exchange geom_histogram() with geom_density(), which produces a kernel density graph. This is a plot that won't be covered in this book, but by looking at it you may be able to figure out that it is essentially a smoothed version of a histogram. There are many other geoms to explore. Check out the vast ecosystem of online tutorials for different types of ggplot2 functions.
  
  