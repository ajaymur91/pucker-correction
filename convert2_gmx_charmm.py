import parmed as pmd

# convert AMBER topology to GROMACS, CHARMM formats
amber = pmd.load_file('amber_ff/amber.prmtop', 'amber_ff/amber.inpcrd')

# Save a GROMACS topology and GRO file
amber.save('gromacs_ff/gromacs.top',overwrite=True)
amber.save('gromacs_ff/gromacs.gro',overwrite=True)

# Save a CHARMM PSF and crd file
amber.save('charmm_ff/charmm.psf',overwrite=True)
amber.save('charmm_ff/charmm.crd',overwrite=True)
