## Library

library(tidyverse)
library(rebus)
library(readxl)

## Read file

Online_Retail <- read_excel("Online Retail.xlsx")

summary(Online_Retail) # Summary

## Review Invoice Number
## No NA's

head(Online_Retail$InvoiceNo)

Online_Retail %>% filter(is.na(InvoiceNo))

str_subset(string = Online_Retail$InvoiceNo, pattern = ALPHA)  ## Does have alphabets
                                                              ## Looks like most start with 'C'

str_subset(string = str_subset(string = Online_Retail$InvoiceNo, pattern = ALPHA), 
           pattern = START %R% negated_char_class('C') 
           %R% ANY_CHAR)  ## 3 of them start with 'A'


Online_Retail %>% distinct(InvoiceNo) ## only 25K distinct Invoice Number

## Review Stockcode
## No NA's
head(Online_Retail$StockCode)

Online_Retail %>% filter(is.na(StockCode))

Online_Retail %>% distinct(StockCode) ## 4070
Online_Retail %>% distinct(Description) ## 4212

## seems like same stock code has different description 

Online_Retail %>% group_by(StockCode) %>% 
  distinct(StockCode, Description) %>% 
  count(Description)  ## Looks like some NA's in description

Online_Retail %>% group_by(StockCode) %>% 
  distinct(StockCode, Description) %>% 
  count(StockCode) %>% filter(n>1)

Online_Retail %>% filter(is.na(Description))  ## 1454 NA's

Online_Retail %>% filter(!is.na(Description)) %>% group_by(StockCode) %>% 
  distinct(StockCode, Description) %>% 
  count(Description)  ## seems like duplicates have some with lower case

lowercase <- str_subset(string = Online_Retail$Description, pattern = LOWER)

lowercase <- as.data.frame(lowercase)

review <- lowercase %>% group_by(lowercase) %>% count()

ggplot(data = lowercase, aes(lowercase)) + geom_histogram(stat = 'count')






