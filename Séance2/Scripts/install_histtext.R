# In order to use this file, R and RStudio first need to be installed
# For MacOS X and Windows (make sure to choose the correct Operating System and architecture download links!):
# Download and install R from https://cloud.r-project.org/
# Download and install RStudio from https://www.rstudio.com/products/rstudio/download/#download
# For Fedora 35+:
# Install R: dnf install R R-devel
# Install RStudio: dnf install rstudio-desktop
# Install libxml2: dnf install libxml2 libxml2-devel

# Required package in order to install HistText from gitlab
install.packages("devtools")
install.packages("ggplot2")
install.packages("gridExtra")
install.packages("plotly")
install.packages("tidytext")
install.packages("tidyverse")

# Installation of the HistText package itself
devtools::install_gitlab("enpchina/histtext-r-client")

# Configuration of the package (replace fields with actual server information)
histtext::set_config_file(domain = "https://rapi.enpchina.eu",
                          user = "enp_restudio", password = "uOvgXiNTFR8XQ")


# Faster 

histtext::set_config_file(domain = "https://rapi2025.enpchina.eu",
                          user = "enp_restudio", password = "uOvgXiNTFR8XQ")

# If successfully configured, the following command will return "OK"
histtext::get_server_status()

# Optional dependencies
install.packages(c("pdftools", "qpdf"))


devtools::install_gitlab("enpchina/histtext-r-client")

histtext::set_config_file(domain = "https://rapi.enpchina.eu",
                          user = "enp_restudio", password = "uOvgXiNTFR8XQ")

histtext::get_server_status()