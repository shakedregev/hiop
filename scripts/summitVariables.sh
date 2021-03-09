
if [ ! -v BUILDDIR ]; then
  echo BUILDDIR is not set! Your paths may be misconfigured.
fi

if [ ! -v COINHSL_MODULE_DIR ]; then
  echo COINHSL_MODULE_DIR is not set! Your paths may be misconfigured.
fi

export INSTALL_DIR=$PROJWORK/csc359/installs/ExaSGD
export EXASGD_ROOT=$INSTALL_DIR

module purge

module use $INSTALL_DIR/Modulefiles/Core

module load gcc-esgd/9.2.0
module load spectrum-mpi-esgd
module load cuda/11.0.1
module load mpfr/4.1.0
module load openblas/0.3.10
module load hdf5/1.10.4
module load hwloc/2.0.2-py3
module load cmake/3.15.2
module load umpire/4.0.1-cuda11
#module load metis/5.1.0
module load raja/0.12.1-cuda11
module load suitesparse/5.8.1-cuda11
module load valgrind/3.14.0

module use /gpfs/alpine/csc359/proj-shared/llnl/ExaSGD_Spack/spack/share/spack/modules/linux-rhel7-power9le
module load magma-2.5.4-gcc-9.2.0-f3llsv7
module load metis-5.1.0-gcc-9.2.0-xycedbi

module use $COINHSL_MODULE_DIR
module load coinhsl-2015.06.23-gcc-9.2.0-kizzx7n


export MY_RAJA_DIR=$RAJA_ROOT
export MY_UMPIRE_DIR=$UMPIRE_ROOT
export MY_METIS_DIR=$OLCF_METIS_ROOT
export MY_HIOP_MAGMA_DIR=$MAGMA_ROOT
export MY_UMFPACK_DIR=$SUITESPARSE_ROOT
export MY_NVCC_ARCH="sm_70"

if [[ ! -f $BUILDDIR/nvblas.conf ]]; then
  cat > $BUILDDIR/nvblas.conf <<EOD
  NVBLAS_LOGFILE  nvblas.log
  NVBLAS_CPU_BLAS_LIB  /autofs/nccs-svm1_sw/summit/.swci/1-compute/opt/spack/20180914/linux-rhel7-ppc64le/gcc-8.1.1/netlib-lapack-3.8.0-p74bsneivus4jck562lq7drw2s7i4ytd/lib64/libblas.so
  NVBLAS_GPU_LIST ALL
  NVBLAS_TILE_DIM 2048
  NVBLAS_AUTOPIN_MEM_ENABLED
EOD
fi
export NVBLAS_CONFIG_FILE=$BUILDDIR/nvblas.conf
EXTRA_CMAKE_ARGS="$EXTRA_CMAKE_ARGS -DHIOP_TEST_WITH_BSUB=ON"
