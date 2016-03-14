library(rbokeh)
df$Date <- as.Date(df$date, "%m/%d/%Y")
df$count <- as.integer(df$count)

figure() %>%
  ly_lines(Date, count, df) %>%
  ly_points(Date,count,df, size=3, ,
            hover = c(Date, count))

with(df, plot(Date, count,type='l'))

ggplot(df, aes(Date, count)) + geom_line() +
  scale_x_date(date_labels = "%b-%Y") + xlab("") + ylab("Daily Counts")

df.busy <- df2
df.busy$Date <- as.character(df.busy$Date)
df.busy <-head(arrange(df.busy, desc(count)), n=10)

str(p <- plot_ly(df2, x = Date, y = count))
p %>%
  layout(title = "Median duration of unemployment (in weeks)",
         showlegend = FALSE) 
