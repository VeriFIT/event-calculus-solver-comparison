ROOTDIR="$(dirname "$(realpath "$0")")"

if [ $# -eq 1 ]; then
    OUTDIR="$1"
else
    echo "Usage: $0 outdir"
    exit 1
fi

NCPUS=16
NRUNS=4
TIMEOUT=300

# clean last outputs and prep folder for new outputs
rm -rf "$OUTDIR"
mkdir -p "$OUTDIR"
mkdir -p "$OUTDIR/domain"
mkdir -p "$OUTDIR/step-falling"

# lpx
echo running clingolpx domain
conda run -n clingo-lpx ../scripts/test.sh ./clingolpx-tasks.sh ../hybrid-clingo/ ../comparison/$OUTDIR/domain/clingolpx $NCPUS $NRUNS $TIMEOUT > /dev/null

echo running clingolpx step-falling
conda run -n clingo-lpx ../scripts/test.sh ./clingolpx-tasks-step-falling.sh ../hybrid-clingo/ ../comparison/$OUTDIR/step-falling/clingolpx $NCPUS $NRUNS $TIMEOUT > /dev/null

./prep_csv.sh ./$OUTDIR/domain/clingolpx/test_run.log ./$OUTDIR/domain/clingolpx.csv
./prep_csv.sh ./$OUTDIR/step-falling/clingolpx/test_run.log ./$OUTDIR/step-falling/clingolpx.csv


# clingcon
echo running clingcon domain
conda run -n clingcon ../scripts/test.sh ./clingcon-tasks.sh ../hybrid-clingo/ ../comparison/$OUTDIR/domain/clingcon $NCPUS $NRUNS $TIMEOUT > /dev/null
echo running clingcon step-falling
conda run -n clingcon ../scripts/test.sh ./clingcon-tasks-step-falling.sh ../hybrid-clingo/ ../comparison/$OUTDIR/step-falling/clingcon $NCPUS $NRUNS $TIMEOUT > /dev/null

./prep_csv.sh ./$OUTDIR/domain/clingcon/test_run.log ./$OUTDIR/domain/clingcon.csv
./prep_csv.sh ./$OUTDIR/step-falling/clingcon/test_run.log ./$OUTDIR/step-falling/clingcon.csv


# clingo
echo running clingo domain
conda run -n clingcon ../scripts/test.sh ./clingo-tasks.sh ../clingo/ ../comparison/$OUTDIR/domain/clingo $NCPUS $NRUNS $TIMEOUT > /dev/null
echo running clingo step-falling
conda run -n clingcon ../scripts/test.sh ./clingo-tasks-step-falling.sh ../clingo/ ../comparison/$OUTDIR/step-falling/clingo $NCPUS $NRUNS $TIMEOUT > /dev/null

./prep_csv.sh ./$OUTDIR/domain/clingo/test_run.log ./$OUTDIR/domain/clingo.csv
./prep_csv.sh ./$OUTDIR/step-falling/clingo/test_run.log ./$OUTDIR/step-falling/clingo.csv


# make graphs
python ./gen-plot.py ./$OUTDIR/domain/  Domain
python ./gen-plot.py ./$OUTDIR/step-falling/    EventPrecision