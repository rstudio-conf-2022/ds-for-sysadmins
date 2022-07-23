# Let's add a bioconductor repo
# See if you can us the rspm cli 
# to identify the 2 commands and 2 arguments needed
#1.


# 2. Then, in another line, don't forget to sync! 


# STOP HERE for now

# Let's create a curated CRAN repo
# Create a list of packages for our repo
echo tidyverse > curated.txt 

# 1. use the cli to create the repo, call it curated

# 2. Add the curated cran source to your new repo 'curated'

# 3. Add the specific packages to the repo
rspm add --source=curated ---file-in=curated.txt

# 4. Run the command with the commit flag and the snapshot date from previous output
rspm add --source=curated ---file-in=curated.txt --commit--snapshot=<SNAPSHOT> 
# 5. Subscribe your repo to the source
rspm subscribe --repo=curated --source=curated

# review the list of repos
rspm list



