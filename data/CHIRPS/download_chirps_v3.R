download_chirps_v3 <- function(start_date, end_date, out_dir = "./chirps_data", version = "sat") {
  
  # Validar versión
  if (!version %in% c("sat", "rnl")) {
    stop("version debe ser 'sat' o 'rnl'")
  }
  
  # Convertir fechas
  start_date <- as.Date(start_date)
  end_date   <- as.Date(end_date)
  
  # Crear carpeta
  dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
  
  # Secuencia de fechas
  dates <- seq(start_date, end_date, by = "day")
  
  # URL base según versión
  base_url <- paste0(
    "https://data.chc.ucsb.edu/products/CHIRPS/v3.0/daily/final/",
    version, "/"
  )
  
  options(timeout = 300)
  
  for (i in seq_along(dates)) {
    
    d <- dates[i]  # Mantiene clase Date
    
    year <- format(d, "%Y")
    file <- paste0("chirps-v3.0.", version, ".", format(d, "%Y.%m.%d"), ".tif")
    
    url  <- paste0(base_url, year, "/", file)
    dest <- file.path(out_dir, file)
    
    if (!file.exists(dest)) {
      tryCatch({
        download.file(url, destfile = dest, mode = "wb", quiet = TRUE)
        cat("✔ Descargado:", file, "\n")
      }, error = function(e) {
        cat("✖ Error:", file, "\n")
      })
    } else {
      cat("• Ya existe:", file, "\n")
    }
  }
  
  cat("\nDescarga finalizada\n")
}

download_chirps_v3(
  start_date = "2025-01-01",
  end_date   = "2025-01-02",
  out_dir    = "C:/Users/hllauca/Desktop/",
  version    = "rnl"
)
