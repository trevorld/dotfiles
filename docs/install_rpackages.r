packages <- c("argparse", # writing scripts
                "devtools", # tools to aid in package development
                "dplyr", # data parsing
                "ggplot2", # high level graphics
                "Hmisc", # data profiling ``describe``
                "knitr", # 'new' Sweave
                "optparse", # writing scripts
                "rio", # input output
                "roxygen2", # alternative documentation
                "sandwich", # standard error corrections
                "stargazer", # pretty table output
                "testthat", # unit testing
                "vimcom", # helps communicate between R and Vim
                "xtable", # convert R objects into latex
                "zipcode" # zipcode data for making pretty maps
                )
for(package in packages) {
    if(require(package, character.only=TRUE)) { } else { install.packages(package, repos="http://cran.cnr.berkeley.edu") }
}

