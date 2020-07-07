# Requirements:
* Bash
* Python 2.7 or higher
* Ambertools https://ambermd.org/AmberTools.php (tleap program) 
* ParmED https://github.com/ParmEd

# Description: 

This code creates a classical force-field for a peptide containing 
4-Fluorinated Proline residues. (chooses ACE-PRF-NME by default, but can be changed in tleap_script.txt)
Code supports the following 4-fluorinated prolines:
* PRF is 4R-fluoro proline residue
* PSF is 4S-fluoro proline residue

As an example you may choose the following sequence (shown in snapshot below): 
ACE-GLY-GLY-PRF-GLY-GLY-NME

* All canonical amino acid residues are available too.
* Code also adds a TIP3P waterbox. (1nm^3 default, can be changed in tleap_script.txt)
* Creates force-field parameters and starting configurations for gromacs, amber and charmm (or openMM).
* Creates a plumed.dat file that adds pucker correction for fluorinated proline residues.

You can select a peptide of your choice by editing the tleap_script.txt file.
* As an example you may choose the following sequence (shown in snapshot below): 
ACE-GLY-GLY-PRF-GLY-GLY-NME


![Alt text](code.png/code.png.001.png?raw=true "Title")

# Usage:
```
bash main.sh #(guides the user through the process)
```
main.sh calls several scripts in the following order:
```
tleap -f tleap_script.txt > tleap.LOG  # create peptide based on tleap script 
bash fix_pro_omega.sh                  # fix omega dihedrals potential barriers for Xaa-Pro peptide bonds (This is optional)  
python convert2_gmx_charmm.py          # Convert from amber to gromacs and charmm types
bash make_pucker_correct_plumed.sh     # creates plumed.dat that adds pucker correction as external bias
```
The only thing the user has to do is edit tleap_script.txt

For instance, you can do

**amber=sequence{ACE GLY GLY PSF PRF NME}** #(edit this inside tleap_script.txt)

**solvatebox amber TIP3PBOX 10** #(creates 1nm^3 tip3p waterbox. edit this inside tleap_script.txt)

* Running **bash main.sh** creates the force-field for the chosen peptide in gromacs_ff/ charmm_ff/ and amber_ff/ folders
along with the plumed.dat file that adds the pucker correction as an external bias from **pucker_correction_data** folder

* to implement the ring puckering correction as external bias, you will need to patch your MD code (gromacs/ amber/ openMM) with Plumed (https://github.com/plumed/plumed2). The simplest way to do this (for gromacs atleast) is to use spack package manager. https://github.com/spack/spack
For example, installing gromacs patched with plumed is as easy as:
```
spack install gromacs +plumed
```


# Citation:
**Article:** [![DOI](https://img.shields.io/badge/doi-10.1021/acs.jpcb.0c04312-blue.svg?style=flat&labelColor=whitesmoke)](https://doi.org/10.1021/acs.jpcb.0c04312)

**Code:** [![DOI](https://img.shields.io/badge/doi-10.6084/m9.figshare.12568550.v2-blue.svg?style=flat&labelColor=whitesmoke)](https://doi.org/10.6084/m9.figshare.12568550.v2)


# Slides (Talk at APS)
https://absuploads.aps.org/presentation.cfm?pid=18448

or

https://doi.org/10.6084/m9.figshare.12302780



