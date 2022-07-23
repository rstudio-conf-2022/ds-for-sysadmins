# In the R CONSOLE run the following to find out
# where package installations are coming from by default
# options("repos")

# In the TERMINAL: Set up your RStudio Workbench so package 
# installations come from RStudio Package Manager by default. 
sudo vim /opt/R/<R_VERSION>/lib/R/etc/Rprofile.site

# Add the url from your rspm instance to the 
options("repos" = c("RSPM" = <YOUR_RSPM_CRAN_URL>)

# We need to restart rstudio now
sudo rstudio-server restart

# In the R CONSOLE Lets confirm that we've set the default repo 
# options("repos")

# In R CONSOLE install a package and load it
# install.packages("curl")
# library(curl)

# In the R CONSOLE install another package
# install.packages('sf')
# library(sf)