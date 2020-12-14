# Load the package required to read JSON files.
library(rjson)
library(sf)

# Give the input file name to the function.
result <- fromJSON(file = "layer_202012140955.json")

names(result) <- "camada"

for (i in 1:length(result$camada)) {
  attr <- data.frame(camada = result$camada[[i]]$camada,
                     procedimento = result$camada[[i]]$procedimento,
                     resumo = result$camada[[i]]$resumo,
                     descricao = ifelse(is.null(result$camada[[i]]$descricao), 
                                        NA, 
                                        result$camada[[i]]$descricao))
  
  geometry <- st_as_sfc(result$camada[[i]]$poligonais, crs = 4326) %>% 
    st_transform(pipeline = "+proj=pipeline +step +proj=axisswap +order=2,1")
  
  obj <- st_sf(attr, 
               geom = geometry)
  
  st_write(obj, paste("E:/GeoSPU/SPU-SC-NUJUC/obj/", "nujuc", i , ".geojson", 
                      sep = ""), delete_dsn = TRUE)    
}
