# In order to use this file, R and RStudio first need to be installed
# For MacOS X and Windows (make sure to choose the correct Operating System and architecture download links!):
# Download and install R from https://cloud.r-project.org/
# Download and install RStudio from https://www.rstudio.com/products/rstudio/download/#download

# HistText Installation

# Required packages 

install.packages("devtools")
install.packages("ggplot2")
install.packages("gridExtra")
install.packages("plotly")
install.packages("tidytext")
install.packages("tidyverse")

# Installation of HistText from GitLab

devtools::install_gitlab("enpchina/histtext-r-client")

# Configuration of the package

histtext::set_config_file(domain = "https://rapi.enpchina.eu",
                          user = "enp_restudio", password = "uOvgXiNTFR8XQ")

# If successfully configured, the following command will return "OK"

histtext::get_server_status()

# Optional dependencies

install.packages(c("pdftools", "qpdf"))

# Load HistText package

library(histtext)

# Test (list available corpora)

list_corpora()

