#Requirements
*Bash
*Python 2.7 or higher
*ParmED (https://github.com/ParmEd)

##################################################################
Usage:

* Executing main.sh guides the user through the process.
* This creates the force-field for the chosen peptide in gromacs_ff/ charmm_ff/ and amber_ff/ folders
* The user has to specify the desired peptide to be simulated in tleap_script.txt
* Otherwise a default peptide sequence is chosen (ACE-PRF-NME)
##################################################################
Info: 

* This code creates a classical force-field for a peptide containing 
4-Fluorinated Proline (non-natural) residues. (also works for any cannonical peptide)

* Creates input files for gromacs or amber or charmm (or openMM)
* Adds a 1nm^3 TIP3P waterbox.

* As an example you may choose the following sequence: 
ACE-GLY-GLY-PRF-GLY-PSF-NME
where PRF is 4R-fluoro proline residue
      PSF is 4S-fluoro proline residue

You can select a peptide of your choice by editing the tleap_script.txt file.

##################################################################
Citation:
@article{muralidharan2020solvation,
  title={A solvation induced ring puckering effect in fluorinated prolines and its inclusion in classical force-fields},
  author={Muralidharan, A and Schmidt, JR and Yethiraj, A},
  journal={bioRxiv},
  year={2020},
  publisher={https://www.biorxiv.org/content/10.1101/2020.05.11.088963v2.full}
}



