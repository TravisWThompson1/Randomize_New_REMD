#!/bin/bash
#
# Author: Travis Thompson
# 07.10.2017
# Dr. Enrico Tapavicza Computational Chemisty Lab
# 
# This script will reference a previous REMD run ($REMD_DIR), 
# copy necessary files, and choose four random geometries as 
# starting geometries for the new REMD# ($REMD) to run.
#
# TO DO:
# Insert relevant values for $REMD_DIR, $REMD, and $atoms.
#

# Reference REMD directory
REMD_DIR='REMD1'

# Initialize new REMD run value
REMD=6

# Number of atoms
atoms=26



# Begin script.
###################################################################
# Get a list of time steps
grep 't=   ' $REMD_DIR'/T300/mdlog.1' | awk '{print $2}' > times_avail.dat

# Get total number of lines
num_of_lines=$(grep -c '' 'times_avail.dat')

# Set up atom2
atom2=$(echo "$atoms * 2 + 1" | bc -l)

# Get four random numbers between 1 and num_of_lines
rand1=$(shuf -i 1-$num_of_lines -n1)
rand2=$(shuf -i 1-$num_of_lines -n1)
rand3=$(shuf -i 1-$num_of_lines -n1)
rand4=$(shuf -i 1-$num_of_lines -n1)

# Get four times from list of times using rand# as an index
time1=$(sed "${rand1}q;d" times_avail.dat)
time2=$(sed "${rand2}q;d" times_avail.dat)
time3=$(sed "${rand3}q;d" times_avail.dat)
time4=$(sed "${rand4}q;d" times_avail.dat)

# Print times
echo $time1 ' ' $time2 ' ' $time3 ' ' $time4

# Make new REMD directory
mkdir 'REMD_'$REMD

# Set up new REMD directoy
cp -r $REMD_DIR'/bcup/' 'REMD_'$REMD'/.'
cp $REMD_DIR'/remd.4.script' 'REMD_'$REMD'/.'


# Move to bcup directory and set up T300, T600, T900, and T1200
cd 'REMD_'$REMD'/bcup/'


# T300: #################################
# Move to T300 directory
cd T300/
echo "T300: $time1"

# Remove files to be replaced
rm mdlog.1
rm coord

# Setup new mdlog.1 and coord files
echo '# AIMD log file' > mdlog.1
echo '$log' >> mdlog.1
echo '$current' >> mdlog.1
echo 't=   0.00000000000' >> mdlog.1
grep -A$atoms2 "t=   $time1" '../../../'$REMD_DIR'/T300/mdlog.1' | tail -n+2 >> mdlog.1
echo '$end' >> mdlog.1
echo '$coord' > coord
grep -A$atoms "t=   $time1" '../../../'$REMD_DIR'/T300/mdlog.1' | tail -n+2 >> coord
echo '$end' >> coord

cd ../


# T600: #################################
# Move to T600 directory
cd T600/
echo "T600: $time2"

# Remove files to be replaced
rm mdlog.1
rm coord

# Setup new mdlog.1 and coord files
echo '# AIMD log file' > mdlog.1
echo '$log' >> mdlog.1
echo '$current' >> mdlog.1
echo 't=   0.00000000000' >> mdlog.1
grep -A53 "t=   "$time2 '../../../'$REMD_DIR'/T600/mdlog.1' | tail -n+2 >> mdlog.1
echo '$end' >> mdlog.1
echo '$coord' > coord
grep -A26 "t=   "$time2 '../../../'$REMD_DIR'/T600/mdlog.1' | tail -n+2 >> coord
echo '$end' >> coord

cd ../


# T900: #################################
# Move to T900 directory
cd T900/
echo "T900: $time3"

# Remove files to be replaced
rm mdlog.1
rm coord

# Setup new mdlog.1 and coord files
echo '# AIMD log file' > mdlog.1
echo '$log' >> mdlog.1
echo '$current' >> mdlog.1
echo 't=   0.00000000000' >> mdlog.1
grep -A53 "t=   $time3" '../../../'$REMD_DIR'/T900/mdlog.1' | tail -n+2 >> mdlog.1
echo '$end' >> mdlog.1
echo '$coord' > coord
grep -A26 "t=   $time3" '../../../'$REMD_DIR'/T900/mdlog.1' | tail -n+2 >> coord
echo '$end' >> coord

cd ../


# T1200: #################################
# Move to T1200 directory
cd T1200/
echo "T1200: $time4"

# Remove files to be replaced
rm mdlog.1
rm coord

# Setup new mdlog.1 and coord files
echo '# AIMD log file' > mdlog.1
echo '$log' >> mdlog.1
echo '$current' >> mdlog.1
echo 't=   0.00000000000' >> mdlog.1
grep -A53 "t=   $time4" '../../../'$REMD_DIR'/T1200/mdlog.1' | tail -n+2 >> mdlog.1
echo '$end' >> mdlog.1
echo '$coord' > coord
grep -A26 "t=   $time4" '../../../'$REMD_DIR'/T1200/mdlog.1' | tail -n+2 >> coord
echo '$end' >> coord

cd ../



####################################################################

cd ../../
# Clean up:
rm times_avail.dat


# Ready for submission, use the following command without the #:
# nohup ./remd.4.script &

# Check if you job is still running with top, or htop if installed.






