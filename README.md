# Solenoid-Magnetic-Field-Simulation
 A MATLAB simulation of the magnetic field (B) interactions surrounding two current induced solenoids using the Biot-Savart law. Created for an AP Physics C project in grade 12. 
 
 One of the simulations show the interactions of the B lines, and the other simulation shows a heatmap of the magnitudes of the B field. The output can be viewed [here.](output.pdf). 
 
## Specifications
Using the first solenoid (L1) centered at the origin with its longitudinal axis parallel with the z-axis as a frame of reference, a second identical solenoid (L2) was added. Two rotation matrices rotated L2 315° about the y-axis and 30° about the x-axis.
L2 was then translated -3 cm along the x-axis and 2.9 cm along the y-axis. L1 and L2 were graphed with a radius and length of
about 6.03 cm.
Using the Biot-Savart law, the B field, dB for a current length element with a maximum discretization of <0.1006 cm was computed and repeated across the entire lengths of L1 and L2 using vacuum permeability. This was repeated for an entire volume with a point density resolution of 1.4 cm<sup>-3</sup>. A current of 0.80 A for L1 and -0.84 A for L2 was simulated. To plot the magnetic field, field lines were anchored on the xy-plane 15 cm below L1.
