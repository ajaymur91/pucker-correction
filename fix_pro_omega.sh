#!/bin/bash

# This is an optional script that fixes the energy barrier height between cis and trans
# by Changing the dihedral angle (omega) force constants for the peptide bonds that precede Pro and 4F-Pro residues!
# Does not affect the energy difference between cis and trans states (only barriers) 
# See Doshi et al. J Phys Chem B 113(52):16590-5

# Identify the residue numbers for PRO or F-PRO residues
uniqArr=($(echo "printDetails :PRF,PSF,PRO" | parmed -n amber_ff/amber.prmtop | sed -n '/Reading /,$p' | tail -n +7 | sed '1!G;h;$!d' | tail -n +3 | sed '1!G;h;$!d' | awk '{print $2}' | uniq))

#Remove pre-existing dihedral files
rm -f temp/dihedrals

#Identify the dihedral angles to mend
for i in "${uniqArr[@]}"
do
echo "printDihedrals :$((i-1)) :$((i-1)) :$i :$i" | parmed -n amber_ff/amber.prmtop | sed -n '/Reading /,$p' | tail -n +3 | sed '1!G;h;$!d' | tail -n +3 | sed '1!G;h;$!d' | awk '{ print $1" "$5" "$9" "$13}' >> temp/dihedrals
done

#Remove pre-existing parmed script file
rm -f temp/script_edit


#Create a parmed script to delete dihedrals and add fresh values from Doshi et al.
while read p
do 
a=($(echo $p | awk '{print $1}')) 
b=($(echo $p | awk '{print $2}')) 
c=($(echo $p | awk '{print $3}')) 
d=($(echo $p | awk '{print $4}')) 
echo "deleteDihedral @$a @$b @$c @$d" >> temp/script_edit
echo "adddihedral @$a @$b @$c @$d 3.5000 2.0000 180.000" >> temp/script_edit
done < temp/dihedrals
echo "outparm amber_ff/amber.prmtop" >> temp/script_edit

parmed -n -O amber_ff/amber.prmtop temp/script_edit

