library(RCurl)
#### Download vacant lot data
vacants_oak_raw <- getURL("https://raw.githubusercontent.com/map-communities/old-oakland-vacant-lots/master/vacants.csv")
vacants_oak <- read.csv(text = vacants_oak_raw)

## tax rates
taxrate <- .01
agtaxrate <- 12100

## Parcel roll for taxes
proptax_oak <- read.csv("/home/dan/SpiderOak Hive/Food deserts/Oakland_Parcels2014.csv")

## Add column w/ estimated tax rev based on 1% prop tax
proptax_oak$tax <- proptax_oak$TotalNetVa * taxrate

## subset by eligible for AB551
eligible <- subset(vacants_oak, Acre > .1)
AB551 <- subset(eligible, Acre < 3)

## combine vacant lots and property tax data
AB551tax <- merge(AB551, proptax_oak, by = "APN")

## Calculate expected agriculture tax burden
AB551tax$agtax <- AB551tax$Acre * agtaxrate

## Subset plots where agtax burden is less than normal property tax
AB551tax$elig <- AB551tax$agtax < AB551tax$tax
AB551_targets <- subset(AB551tax, agtax < tax)

## Cost if all parcels switch to farms
total cost <- sum(AB551_targets$tax - AB551_targets$agtax)


## Outputs
write.csv(AB551, file = "/home/dan/SpiderOak Hive/Food deserts/AB551")
write.csv(vacants_oak, file  = "/home/dan/SpiderOak Hive/Food deserts/vacants")
write.csv(AB551tax, file  = "/home/dan/SpiderOak Hive/Food deserts/AB551tax")
write.csv(AB551tax, file  = "/home/dan/SpiderOak Hive/Food deserts/AB551all")
write.csv(AB551_targets, file  = "/home/dan/SpiderOak Hive/Food deserts/AB551targets_corrected")
