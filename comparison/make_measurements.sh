ROOTDIR="$(dirname "$(realpath "$0")")"

if [ $# -eq 1 ]; then
    OUTDIR="$1"
else
    echo "Usage: $0 outdir"
    exit 1
fi

NCPUS=4
NRUNS=1
TIMEOUT=120
TIMEOUT=10

OUTDIR=test


# clean last outputs and prep folder for new outputs
rm -rf "$OUTDIR"
mkdir -p "$OUTDIR"
mkdir -p "$OUTDIR/domain_scaling"
mkdir -p "$OUTDIR/step_scaling"

# lpx
echo running clingolpx domain scaling
conda run -n clingo-lpx ../scripts/test.sh ./clingolpx-tasks.sh ../hybrid-clingo/ ../comparison/$OUTDIR/domain_scaling/clingolpx $NCPUS $NRUNS $TIMEOUT > /dev/null

echo running clingolpx step scaling
conda run -n clingo-lpx ../scripts/test.sh ./clingolpx-tasks-step_scaling.sh ../hybrid-clingo/ ../comparison/$OUTDIR/step_scaling/clingolpx $NCPUS $NRUNS $TIMEOUT > /dev/null

./prep_csv.sh ./$OUTDIR/domain_scaling/clingolpx/test_run.log ./$OUTDIR/domain_scaling/clingolpx.csv
./prep_csv.sh ./$OUTDIR/step_scaling/clingolpx/test_run.log ./$OUTDIR/step_scaling/clingolpx.csv


# clingcon
echo running clingcon domain scaling
conda run -n clingcon ../scripts/test.sh ./clingcon-tasks.sh ../hybrid-clingo/ ../comparison/$OUTDIR/domain_scaling/clingcon $NCPUS $NRUNS $TIMEOUT > /dev/null
echo running clingcon step scaling
conda run -n clingcon ../scripts/test.sh ./clingcon-tasks-step_scaling.sh ../hybrid-clingo/ ../comparison/$OUTDIR/step_scaling/clingcon $NCPUS $NRUNS $TIMEOUT > /dev/null

./prep_csv.sh ./$OUTDIR/domain_scaling/clingcon/test_run.log ./$OUTDIR/domain_scaling/clingcon.csv
./prep_csv.sh ./$OUTDIR/step_scaling/clingcon/test_run.log ./$OUTDIR/step_scaling/clingcon.csv


# clingo
echo running clingo domain scaling
conda run -n clingcon ../scripts/test.sh ./clingo-tasks.sh ../clingo/ ../comparison/$OUTDIR/domain_scaling/clingo $NCPUS $NRUNS $TIMEOUT > /dev/null
echo running clingo step scaling
conda run -n clingcon ../scripts/test.sh ./clingo-tasks-step_scaling.sh ../clingo/ ../comparison/$OUTDIR/step_scaling/clingo $NCPUS $NRUNS $TIMEOUT > /dev/null

./prep_csv.sh ./$OUTDIR/domain_scaling/clingo/test_run.log ./$OUTDIR/domain_scaling/clingo.csv
./prep_csv.sh ./$OUTDIR/step_scaling/clingo/test_run.log ./$OUTDIR/step_scaling/clingo.csv


# make graphs
python ./gen-plot.py ./$OUTDIR/domain_scaling/  Domain
python ./gen-plot.py ./$OUTDIR/step_scaling/    EventPrecision