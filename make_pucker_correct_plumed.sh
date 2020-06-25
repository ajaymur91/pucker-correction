#!/bin/bash

echo "printdetails :PRF@CD" | parmed -n amber_ff/amber.prmtop | sed -n '/Reading /,$p' | tail -n +6 | sed '1!G;h;$!d' | tail -n +3 | sed '1!G;h;$!d' | awk '{print $1}' > temp/RF_CD
echo "printdetails :PRF@N"  | parmed -n amber_ff/amber.prmtop | sed -n '/Reading /,$p' | tail -n +6 | sed '1!G;h;$!d' | tail -n +3 | sed '1!G;h;$!d' | awk '{print $1}' > temp/RF_N
echo "printdetails :PRF@CA" | parmed -n amber_ff/amber.prmtop | sed -n '/Reading /,$p' | tail -n +6 | sed '1!G;h;$!d' | tail -n +3 | sed '1!G;h;$!d' | awk '{print $1}' > temp/RF_CA
echo "printdetails :PRF@CB" | parmed -n amber_ff/amber.prmtop | sed -n '/Reading /,$p' | tail -n +6 | sed '1!G;h;$!d' | tail -n +3 | sed '1!G;h;$!d' | awk '{print $1}' > temp/RF_CB
echo "printdetails :PRF@CG" | parmed -n amber_ff/amber.prmtop | sed -n '/Reading /,$p' | tail -n +6 | sed '1!G;h;$!d' | tail -n +3 | sed '1!G;h;$!d' | awk '{print $1}' > temp/RF_CG
paste temp/RF_CD temp/RF_N temp/RF_CA temp/RF_CB temp/RF_CG > temp/RF-all ; rm temp/RF_*

echo "printdetails :PSF@CD" | parmed -n amber_ff/amber.prmtop | sed -n '/Reading /,$p' | tail -n +6 | sed '1!G;h;$!d' | tail -n +3 | sed '1!G;h;$!d' | awk '{print $1}' > temp/SF_CD
echo "printdetails :PSF@N"  | parmed -n amber_ff/amber.prmtop | sed -n '/Reading /,$p' | tail -n +6 | sed '1!G;h;$!d' | tail -n +3 | sed '1!G;h;$!d' | awk '{print $1}' > temp/SF_N
echo "printdetails :PSF@CA" | parmed -n amber_ff/amber.prmtop | sed -n '/Reading /,$p' | tail -n +6 | sed '1!G;h;$!d' | tail -n +3 | sed '1!G;h;$!d' | awk '{print $1}' > temp/SF_CA
echo "printdetails :PSF@CB" | parmed -n amber_ff/amber.prmtop | sed -n '/Reading /,$p' | tail -n +6 | sed '1!G;h;$!d' | tail -n +3 | sed '1!G;h;$!d' | awk '{print $1}' > temp/SF_CB
echo "printdetails :PSF@CG" | parmed -n amber_ff/amber.prmtop | sed -n '/Reading /,$p' | tail -n +6 | sed '1!G;h;$!d' | tail -n +3 | sed '1!G;h;$!d' | awk '{print $1}' > temp/SF_CG
paste temp/SF_CD temp/SF_N temp/SF_CA temp/SF_CB temp/SF_CG > temp/SF-all ; rm temp/SF_*

perl -pne 's/[^\S\n]+/,/g' < temp/RF-all > temp/RF-ALL2
perl -pne 's/[^\S\n]+/,/g' < temp/SF-all > temp/SF-ALL2

rm -f gromacs_ff/plumed.dat;
rm -f amber_ff/plumed.dat;
rm -f charmm_ff/plumed.dat;

i=1; while read p; do echo "PUCKERING ATOMS=$p LABEL=p_rf$i" >> plumed.dat; echo "EXTERNAL ARG=p_rf$i.Zx,p_rf$i.Zy FILE=./pucker_correction_data/RF-correct.dat LABEL=ext_prf$i">>plumed.dat; echo " ">>plumed.dat ; i=$((i+1)); done<temp/RF-ALL2

i=1; while read p; do echo "PUCKERING ATOMS=$p LABEL=p_sf$i" >> plumed.dat; echo "EXTERNAL ARG=p_sf$i.Zx,p_sf$i.Zy FILE=./pucker_correction_data/SF-correct.dat LABEL=ext_psf$i">>plumed.dat; echo " ">>plumed.dat ; i=$((i+1)); done<temp/SF-ALL2

cp plumed.dat charmm_ff/
cp plumed.dat amber_ff/
mv plumed.dat gromacs_ff/
