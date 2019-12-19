## ---- results='hide', message=FALSE--------------------------------------
include <- function(library_name){
  if( !(library_name %in% installed.packages()) )
    install.packages(library_name)
  library(library_name, character.only = TRUE)
}

include("rvest")
include("tidyr")
include("tidyverse")
include("stringr")
include("data.table")
include("rjson")
#fire arm table for data by state for firearm mortality


## ------------------------------------------------------------------------
web_scraper <- function(url){
  
    webpage <- read_html(url)
    
    table <- webpage %>% html_nodes("table")
    
    year <-            table %>%
                       html_nodes("td.cellleft") %>%
                       html_text() %>%
                       as.integer()
    
    ammount <-         table %>%
                       html_nodes("td.cellright") %>%
                       html_text()
    

    
        
    Juvenile_arrest <- tibble(
                            Year = year,
                            Ammount = ammount,
                            )

}

Arrests = web_scraper("https://www.ojjdp.gov/ojstatbb/crime/JAR_Display.asp?ID=qa05200&selOffenses=1&text=yes")
head(Arrests)


## ------------------------------------------------------------------------

result <- fromJSON(file = "data.json")

crime_Per_State <- as.data.frame(result)

head(crime_Per_State)


## ------------------------------------------------------------------------
People <- read_csv("https://raw.githubusercontent.com/AdamGonzalezJr/DataScienceProject/master/data(1).csv")

old = c("Percent Educational Attainment", "Percent Peace Index", "Percent Above Poverty Rate", "Percent Non-religious")
new = c("Educational_Attainment", "Peace_Index", "Above_Poverty_Rate", "Non_religious")
setnames(People, old, new)
g = ggplot(People, aes(x=State, y = Above_Poverty_Rate)) + geom_col(color = 'red', width = .5)
g + coord_flip()


## ------------------------------------------------------------------------

a = ggplot(People, aes(x = State, y = Educational_Attainment)) + geom_col(color = 'blue', width = .5)
a + coord_flip()


