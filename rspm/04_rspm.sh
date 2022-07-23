# Let's add a git build to our curated repo  
rspm create source --name=git --type=git

rspm subscribe --repo=curated --source=git

rspm create git-builder --source=git \
--url="https://github.com/johannesbjork/LaCroixColoR.git"

# Check out the UI for your packages
# Try to install LaCroixColoR in the R 
# install.packages("LaCroixColoR")

# Now, let's add another repo to your defaults in Workbench
sudo vim /opt/R/<R_VERSION>/lib/R/etc/Rprofile.site
# options("repos" = c("RSPM" = <YOUR_RSPM_CRAN_URL>, "curated" = <YOUR_CURATED_URL>)

# And now ... a star wars example.  
# writeManifest()

# What about RStudio Connect?
sudo cat /etc/rstudio-connect/rstudio-connect.gcfg


