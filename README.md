# Randomize_New_REMD
Takes four random geometries from a previous REMD run and uses them to create a new REMD directory.

Must insert 3 values:

1. $REMD_DIR - This is the reference directory of a previous successful REMD run. This should only be a local reference, ie. 'REMD_RUNS/REMD2/'

2. $REMD - This is the REMD number. For example, if there are 5 previous REMD runs, this value should be 6. The new directory with be called 'REMD6' and will be created here '.'

3. $atoms - Enter the number of atoms in your molecule. For example, alpha-Terpinene has 26 molecules.


