# Let's add a bioconductor repo
rspm create repo --name bioconductor --type bioconductor

rspm sync --type bioconductor


# STOP HERE for now

# Let's create a curated CRAN repo
# Create a list of packages for our repo
echo tidyverse > curated.txt 

rspm create repo --name=curated

rspm create add source --name=curated --type=curated-cran

rspm add --source=curated ---file-in=curated.txt

# Run the command with the commit flag and the snapshot date from previous output
rspm add --source=curated ---file-in=curated.txt --commit--snapshot=<SNAPSHOT> 

rspm subscribe --repo=curated --source=curated

# review the list of repos
rspm list



