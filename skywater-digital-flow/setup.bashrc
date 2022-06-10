export MFLOWGEN_PATH=/home/users/canswang/mflowgen
export MFLOWGEN_HOME=/home/users/canswang/mflowgen
export PDKPATH=/farmshare/home/classes/ee/372/PDKs

export PATH=/cad/mentor/2019.11/Catapult_Synthesis_10.4b-841621/Mgc_home/bin:$PATH
export MGLS_LICENSE_FILE=1717@cadlic0.stanford.edu

source /cad/modules/tcl/init/sh

module load base
module load vcs
module load lc
module load syn
module load xcelium
module load genus
module load innovus
module load calibre/2019.1
module load prime
module load magic/latest
module load netgen/latest
module load ic/6.18.020

# export PATH=/cad/openlane/build/bin:$PATH

# Autocomplete for make
complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' ?akefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make
