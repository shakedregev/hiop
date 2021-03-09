#!/bin/bash

export INSTALL_DIR=$PROJWORK/csc359/installs/ExaSGD

module purge
export EXASGD_ROOT=$INSTALL_DIR
module use $INSTALL_DIR/Modulefiles/Core

#Then a project-specific compiler module so you can access
#software built with that compiler.

module load gcc-esgd/9.2.0

#Then a project-specific MPI module so you can access
#software built with that compiler and MPI library.

module load spectrum-mpi-esgd

module load cuda/11.0.1
module load mpfr/4.1.0
module load openblas/0.3.10
module load hdf5/1.10.4

module load hwloc/2.0.2-py3
module load cmake/3.15.2
module load umpire/4.0.1-cuda11
module load magma/master-9ce41caa-cuda11
module load metis/5.1.0
module load raja/0.12.1-cuda11
module load suitesparse/5.8.1-cuda11


