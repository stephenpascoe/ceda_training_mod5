#!/bin/sh

HERE=$PWD
BUILD_DIR=$HERE/build
LATEX_TEMPLATE=article

#!TODO: replace http://raw.github.com/SciTools/courses/master/course_content/

pushd $BUILD_DIR
for nb in $HERE/*.ipynb
do
    ipython nbconvert --to=latex --template=$LATEX_TEMPLATE --config=$HERE/nbconvert_config.py $nb
    tex=$(basename ${nb%.*}).tex
    python $HERE/adjust_latex.py $tex
    pdflatex -interaction nonstopmode $tex
done
