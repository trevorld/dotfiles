* Simplified version of ``graph export`` which also lets us save pdf graphs
*! version 1.0 2011-04-02
* Usage: graph_export using filename
* Warning: Uses replace option to Stata's ``graph export`` command
/* Examples: 
clear
set obs 100
generate x = _n
generate y = runiform()
graph twoway scatter y x
* Create some pdf graphs (even in Unix console!)
graph_export using example1.pdf
* If graph type not specified then save as pdf
graph_export using example2
* Create a eps file in anywhere
graph_export using example3.eps
* Create a png in Unix GUI (but not console)
graph_export using example4.png
*/
program define graph_export
    syntax using/
    
    if regexm("`using'", "\.(.*$)") {
          local filetype = regexs(1)
    } 
    else {
          local filetype = ""
    }
    if "`filetype'" == "pdf" {
        local file_pdf = "`using'"
        local file_eps = regexr("`file_pdf'", "\.pdf", ".eps")
    }
    else if "`filetype'" == "" {
        local file_pdf = "`using'" + ".pdf"
        local file_eps = "`using'" + ".eps"
    } 
    else {
        quietly: graph export `using', replace
        exit
    }
    quietly: graph export `file_eps', replace
    * shell ps2pdf `file_eps' `file_pdf'
    shell epstopdf `file_eps' --outfile=`file_pdf'
    * display "file `file_eps converted into PDF format"
    if "`filetype'" == "pdf" {
        rm `file_eps' 
        * display "file `file_eps deleted"
    }
end
