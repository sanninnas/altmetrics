counts_raw <- read.delim("data//counts-raw.txt.gz")
dim(counts_raw)
head(counts_raw)
tail(counts_raw)
counts_raw[1, 10]
counts_raw[1:3, 10:12]
counts_raw[1:3,]
counts_raw[1:10, "pmid"]
str(counts_raw$daysSincePublished)
head(counts_raw$daysSincePublished / 7) # weeks since published
head(counts_raw$daysSincePublished / c(7,1)) # divide first value by 7, the second by 1, then 7 then 1...
is.numeric(counts_raw$daysSincePublished)
str(counts_raw$journal)
levels(counts_raw$journal) # factors stored as num, sometimes problems: set stringasfactor=false to avoid issues
counts_raw$authorsCount[1:10]
is.na(counts_raw$authorsCount[1:10])
anyNA(counts_raw$authorsCount[1:10])
summary(counts_raw$wosCountThru2011)
mean(counts_raw$wosCountThru2011)
hist(sqrt(counts_raw$wosCountThru2011))
plot(counts_raw$daysSincePublished, counts_raw$wosCountThru2011)
counts_raw$authorsCount[1:10]
counts_raw$authorsCount[1:10] > 7
dim(counts_raw[counts_raw$journal == "pone",])
dim(counts_raw[counts_raw$journal != "pone",])
dim(counts_raw[counts_raw$journal %in% c("pone", "pbio", "pgen"),])
dim(counts_raw[grepl("Immunology", counts_raw$plosSubjectTags),])
if(anyNA(counts_raw$authorsCount)) {
    print("Be Careful!")
} else {
    print("Looking good!")
}
if(anyNA(c(1,1,1))) {
    print("Be Careful!")
} else {
    print("Looking good!")
}

# running rmarkdown via commandline instead of pressing the knit button
library("rmarkdown")
render("altmetrics_analysis.Rmd")
# unlike knitting, this is just going to save a file (no popups), nice for running on things on cluster without popups etc

for(i in 1:10){
    print(i)
}

# loops in R notoriously slow
# example slow code:
x <- numeric()
for (i in 1:length(counts_raw$wosCountThru2011)){
    x <- c(x, counts_raw$wosCountThru2011[i] + 1)
}
# adding things to a vector is slow
# better way: indexing
x <- numeric(length = length(counts_raw$wosCountThru2011))
for (i in 1:length(counts_raw$wosCountThru2011)){
    x[i] <- counts_raw$wosCountThru2011[i] + 1
}

# what journals we have
levels(counts_raw$journal)
# count average citation in each journal
results <- numeric(length = length(levels(counts_raw$journal)))
results
names(results) <- levels(counts_raw$journal)
results
results["pone"]

for (j in levels(counts_raw$journal)){
    results[j] <- mean(counts_raw$wosCountThru2011[counts_raw$journal == j])
}
results


