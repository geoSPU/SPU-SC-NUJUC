library(sf)

nujuc = list()

for (i in 1:37){
  nujuc[[i]] <- st_read(paste("obj/nujuc", i, ".geojson", sep = ""))  
}

df <- do.call(rbind, nujuc)

st_write(df, "nujuc.geojson", delete_dsn = T)
