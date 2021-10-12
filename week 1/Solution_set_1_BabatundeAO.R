#1 Exercises
#1.1 Exercise 1: Familiarizing Yourself with Base Plotting
#Type the following commands into a script and then execute them together:
plot(x = 1, y = 1, type = 'n',
       xlim = c(-2, 2), ylim = c(-2, 2))
points(x = -1, y = 1)
segments(x0 = -0.5, y0 = -1, x1 = 0.5, y1 = -1)
#The first line opens up an empty plot with a point at the coordinates x = 1 and y = 1. The type = 'n' argument means that this point is not actually displayed.
#xlim and ylim specify the plot margins.
#The points() function plots a single point at the specified coordinates. The segments() function plots a line segment. The beginning of the line segment is given by the arguments x0 and y0. The end points are given by x1 and y1.
#What is displayed in your plotting window is actually a one-eyed smiley. By adding additional points() and segments(), can you create a more elaborate smiley?
#This exercise will help to wrap your head around working with coordinate systems.
points(x = -2, y = 1.5)
segments(x0 = 1, y0 = -1.5, x1 = -1.5, y1 = -2)

#1.2 Exercise 2: Swirl
#The interactive swirl package teaches you R inside R.
install.packages('swirl')
library(swirl)
swirl()
#Complete the first four modules of the R programming course. If you have extra time, complete the first five courses of the Exploratory Data Analysis course. Throughout your R journey, you can come back to swirl at any time and complete more courses.


#1.3. Exercise 3: Spot-the-Error #1
#Type the following two lines of code into your R script, exactly as they are printed here on the page. Then execute them. This will result in two error messages.
x_values <- c(1, 2 3, 4, 5, 6, 7, 8, 9)
mean_x <- mean(X_values)

#Each line contains one error. Can you find them and correct them?
#The line 26 has an error because the number 2 should take a comma after or probably be written together with 3 as 23)
#The line 27 has an error because the x was written in upper case.
x_values <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
x_values
mean_x <- mean(x_values)
mean_x
#1.4. Exercise 4: Spot-the-Error #2
#Why does the following command return an NA value?
  x <- c(2, 3, 4, '4')
mean(x)
#Can you use the function as.numeric() to solve this problem?
  x_new <- as.numeric(x)
mean(x_new)
#1.5. Exercise 5: Spot-the-Error: #3
#The following line of code tries to extract the row from the nettle data frame that contains information on the country Yemen. Why does this return an error and can you fix this?

nettle[nettle$Country = 'Yemen', ]

#I found out that the error here is the presence of a single equal to sign, it should be doubled. Also I could do this with slicing.
nettle[nettle$Country == "Yemen", ]
nettle[71, ]


#1.6. Exercise 6: Indexing Data Frames
#Gillespie and Lovelace (2017: 4) say that “R is notorious for allowing users to solve problems in many ways”. In this section, you will learn a bunch of different ways of extracting information from the same data frame. Some of these ways are redundant, but knowing multiple paths to the same goal gives you flexibility in how to approach data analysis problems. This exercise also teaches you how indexing statements can be used recursively, stacked on top of each other.
head(nettle) # display first 6 rows
#Country Population Area MGS Langs
#1 Algeria 4.41 6.38 6.60 18
#2 Angola 4.01 6.10 6.22 42
#3 Australia 4.24 6.89 6.00 234
#4 Bangladesh 5.07 5.16 7.40 37
#5 Benin 3.69 5.05 7.14 52
#6 Bolivia 3.88 6.04 6.92 38
#Next, the following statements extract information from this data frame. You haven’t been taught all of these ways of indexing yet. However, try to understand what the corresponding code achieves and I’m sure you’ll be able to figure it out. Importantly, think about what is being extracted first, only then type in the command to see whether the output matches your expectations.
nettle[2, 5]
# load nettle row 2, column 5
nettle[1:4, ]
#load nettle from row 1 to 4 given all the column
nettle[1:4, 1:2]
#load nettle row 1 to 4, given the first 2 columns i.e column 1 nd 2
nettle[nettle$Country == 'Bangladesh', ]
#load nettle for row with country equals Bangladesh
nettle[nettle$Country == 'Bangladesh', 5]
#load nettle row with country as Bangladesh with column 5
nettle[nettle$Country == 'Bangladesh', ] [, 5]
#load nettle row with country as Bangladesh with column 5
nettle[nettle$Country == 'Bangladesh', ] $Langs
#load nettle row with country as Bangladesh with column of language output
nettle[nettle$Country == 'Bangladesh', 'Langs']
#load nettle row with country as Bangladesh with column 5
nettle[1:4, ] $Langs[2]
#load nettle row 1 to 4 and output value in the second column of languages
nettle[1:4, c('Country', 'Langs')]
#load nettle rows 1 to 4 with only columns of Country and Langs
head(nettle[,])