# 1. R installation

1. Define R version 

```
export R_VERSION=4.2.1
```

2. Identify Operating System

```
cat /etc/os-release
```

3. Download R 

```
curl -O https://cdn.rstudio.com/r/ubuntu-1804/pkgs/r-${R_VERSION}_1_amd64.deb
```

4. Install R 

```
sudo gdebi r-${R_VERSION}_1_amd64.deb
```

Check R version 
```
/opt/R/${R_VERSION}/bin/R --version
```

5. Create symbolic link

```
sudo rm -f /usr/local/bin/R /usr/local/bin/Rscript
sudo ln -s /opt/R/${R_VERSION}/bin/R /usr/local/bin/R
sudo ln -s /opt/R/${R_VERSION}/bin/Rscript /usr/local/bin/Rscript
```
**Note:** we are clearing out any pre-existing symlinks here to make sure the new symbolic links are created without any error.

Since we work with RStudio Workbench, we also need to restart the service so that RSW can pick up the new version

```
sudo rstudio-server restart
```
**Note:** your session will crash but you can browse to the initial starting point and connect again to RStudio. 


# 2. Exploring the R installation 

1. How many R packages have been pre-installed ? 
2. Where have they been installed into ? 
2. What type/category of R packages are those ? 

```
names(which(available.packages(repos = c(CRAN = "https://cran.r-project.org"))[ ,"Priority"] == "recommended", ))
names(which(installed.packages()[ ,"Priority"] == "base", ))
```

Bonus question: Do the numbers add up ? 

# 3. Pointing to package repository

```
options(repos = c(CRAN = "https://cran.r-project.org"))
```

# 4. Installing a package

```
install.packages("rlog")
```

# 5. `.libPaths()`

```
.libPaths()
Sys.getenv("R_LIBS_SITE")
Sys.getenv("R_LIBS_USER")
```

# 6. Package dependency on OS

Let's break something !

Remove a package from the operating system. In the RStudio terminal, run

```
sudo apt remove -y libcurl4-openssl-dev
```

Now, let's install package `curl` in the R console

```
install.packages("curl")
```

What happens ? Can you spot the error message ? 

Let's reinstall the OS package again

```
sudo apt install -y libcurl4-openssl-dev
```

And repeat the package installation.

NB: You will find the hint on which OS packages need to be installed for `curl` on [CRAN](https://cran.r-project.org/web/packages/curl/index.html) as well. 

# 7. `renv` Quick glance

Let's assume we want a code a colleague has developed. We want to make sure we use exact the same version of R packages. 

First, let's create a new directory in the RStudio Terminal and move into there

```
mkdir test-renv && cd test-renv
```

Now, let's get the code and the `renv.lock` file

```
wget https://raw.githubusercontent.com/rstudio-conf-2022/ds-for-sysadmins/main/materials/package-management/test/code.R
https://raw.githubusercontent.com/rstudio-conf-2022/ds-for-sysadmins/main/materials/package-management/test/renv.lock
```

In the R console or in the File Browser we now set the working directory to `test-renv`, after which we simply can run 

```
renv::restore()
```

to restore all needed R packages in their very specific version.

Once done, check `sessionInfo()` and comopare with your neighbour. 
