install.packages("rstan", repos = "https://cloud.r-project.org/", dependencies = TRUE)

pkgbuild::has_build_tools(debug = TRUE)

# If the above line ultimately returns TRUE, then your C++ toolchain is properly installed

#optional, but faster
dotR <- file.path(Sys.getenv("HOME"), ".R")
if (!file.exists(dotR)) dir.create(dotR)
M <- file.path(dotR, ifelse(.Platform$OS.type == "windows", "Makevars.win", "Makevars"))
if (!file.exists(M)) file.create(M)
cat("\nCXX14FLAGS=-O3 -march=native -mtune=native",
    if( grepl("^darwin", R.version$os)) "CXX14FLAGS += -arch x86_64 -ftemplate-depth-256" else 
      if (.Platform$OS.type == "windows") "CXX11FLAGS=-O3 -march=native -mtune=native" else
        "CXX14FLAGS += -fPIC",
    file = M, sep = "\n", append = TRUE)

library("rstan") # observe startup messages

#multicore
options(mc.cores = parallel::detectCores())

#package install
packages <- c(
  'bayesplot', 
  'ggplot2', 
  'lubridate', 
  'rmarkdown', 
  'shinystan', 
  'tidyverse',
  'brms'
)
install.packages(packages)
