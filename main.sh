        echo "A solvation induced ring puckering effect in fluorinated prolines and its inclusion in classical force-fields."
        echo "See BioRxiv: https://doi.org/10.1101/2020.05.11.088963"
        echo "Just accepted: J Phys Chem (2020) Muralidharan et al."
        sleep 3

# Step1: Edit tleap_script.txt file to select the peptide you want to simulate
# tleap_script.txt uses standard tleap syntax from Ambertools 
# generates amber_ff/amber.prmtop and amber_ff/amber.inpcrd
        echo "-----"
	echo "Executing tleap_script.txt..."
	sleep 3
	echo "Did you choose your desired peptide from tleap_script.txt?.. Default is ACE-PRF-NME"
	sleep 3 
	tleap -f tleap_script.txt > tleap.LOG
        echo "Created peptide solvated in ~1nm^3 TIP3P water box.. Can be changed in tleap_script.txt"
        sleep 3
        echo "Created FF in amber_FF/*"
        echo "-----"

# Step2: Optional 
# Change the dihedral angle (omega) force constants for the peptide bonds that precede Pro and 4F-Pro residues!
# Fixes the barrier between cis and trans prolines - does not affect the energy difference between cis and trans 
# See Doshi et al. J Phys Chem B 113(52):16590-5
	echo "Fixing force constants for omega dihedrals preceeding PRO and F-PRO residues ..."
        sleep 3
        echo "This is optional.. Behavior can be changed in main.sh"
	sleep 3
	bash fix_pro_omega.sh  #comment this line if energy barrier between cis and trans does not matter
        echo "-----"

# Step3: convert to gromacs or charmm input files if required 
# generates gromacs.gro and gromacs.top (and charmm.psf, charmm.crd)
	echo "Converting.. see charmm_ff/* and gromacs_ff/* "
        sleep 3
	python convert2_gmx_charmm.py
        echo "-----"

# Step4: apply ring puckering correction (as external bias using plumed.dat)
        echo "Creating plumed.dat that adds pucker correction as external bias ..."
        echo 
        sleep 3
	bash make_pucker_correct_plumed.sh
        echo "Done"
        echo "-----"
