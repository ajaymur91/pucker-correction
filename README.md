# Requirements:
* Bash
* Python 2.7 or higher
* ParmED (https://github.com/ParmEd)

# Description: 

* This code creates a classical force-field for a peptide containing 
4-Fluorinated Proline (non-natural) residues.
* You can use the code for cannonical peptides too.

* Creates input files for gromacs or amber or charmm (or openMM).
* Adds a 1nm^3 TIP3P waterbox.
* Creates a plumed.dat file that adds pucker correction for fluorinated proline residues.

* As an example you may choose the following sequence: 
ACE-GLY-GLY-PRF-GLY-PSF-NME
where PRF is 4R-fluoro proline residue
      PSF is 4S-fluoro proline residue

You can select a peptide of your choice by editing the tleap_script.txt file.


# Usage:
```
bash main.sh #(guides the user through the process)
```
main.sh calls several scripts in the following order:
```
tleap -f tleap_script.txt > tleap.LOG 
```
This creates peptide configurations and force-field in amber_ff folder. The peptide to be simulated can be editing the tleap_script.txt.
For instance, you can do
```
amber=sequence{ACE PRF GLY PSF PRF NME} #(edit this inside tleap_script.txt)
```

* This creates the force-field for the chosen peptide in gromacs_ff/ charmm_ff/ and amber_ff/ folders
* The user has to specify the desired peptide to be simulated in tleap_script.txt
* Otherwise a default peptide sequence is chosen (ACE-PRF-NME)


# Citation:
@article{muralidharan2020solvation,
  title={A solvation induced ring puckering effect in fluorinated prolines and its inclusion in classical force-fields},
  author={Muralidharan, A and Schmidt, JR and Yethiraj, A},
  journal={bioRxiv},
  year={2020},
  publisher={https://www.biorxiv.org/content/10.1101/2020.05.11.088963v2.full}
}



