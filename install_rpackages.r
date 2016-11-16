packages <- c("devtools", # tools to aid in package development
                "elliptic", # complex integrals
                "formula.tools", # manipulate formulas 
                "gdata", # read.xls
                "ggplot2", # high level graphics
                "Hmisc", # data profiling ``describe``
                "knitr", # 'new' Sweave
                "ks", # kernel density routines
                "quantreg", # quantile regression
                "maps", # map functions
                "numDeriv", # numeric derivatives
                "optparse", # writing scripts
                "plm",  # panel data models
                "ProjectTemplate", 
                "reshape2", # data manipulation tools
                "r2lh", # some alternative data profiling
                "roxygen2", # alternative documentation
                "Rd2roxygen", # convert Rd to roxygen format
                "setwidth", # adjusts value of options("width")
                "statnet", # networks functions
                "systemfit", # fit system's of regressions
                "testthat", # unit testing
                "R.matlab", # Read MATLAB data sets
                "vimcom", # helps communicate between R and Vim
                "xtable", # convert R objects into latex
                "zipcode" # zipcode data for making pretty maps
                )
for(package in packages) {
    if(require(package, character.only=TRUE)) { } else { install.packages(package, repos="http://cran.cnr.berkeley.edu") }
}

