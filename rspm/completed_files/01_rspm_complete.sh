# RStudio Package Manager has a command line tool, run the command on its own to see the available commands
rspm

# List all configured packages
rspm list

# Performing an initial sync with the RSPM sync API to get the lists of packages and snapshots
rspm sync --no-wait

# Create a repository called 'cran' (name can be modified)
rspm create repo --name cran

# “Subscribe” is the command we use to attach a source to a repo 
# cran and pypi are pre-configured sources
rspm subscribe --repo=cran --source=cran

# see all available options
rspm list requirements --help

# CHALLENGE list system requirements for ggplot2 and plumber
rspm list requirements --repo=cran --packages=ggplot2,plumber --distribution=ubuntu --release=20.04

# list system requirements for all packages
rspm list requirements --repo=cran --packages=* --distribution=ubuntu --release=20.04

