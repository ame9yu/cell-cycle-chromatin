#!/usr/bin/env python

import numpy as np
import pandas as pd
import scipy.stats
import sklearn.linear_model
import sys

try:
    indata = sys.argv[1]
except:
    sys.stderr.write("Usage: ./get_gc_residuals.py <INDATA>\n")
    sys.exit(1)

if indata == "-":
    f = sys.stdin
else: f = open(indata, "r")

# Read data
data = pd.read_csv(f, sep="\t", names=["chrom","start","readcount","gc"])

# Regress gc on readcount
xvals = np.array(data["gc"]).reshape((data.shape[0], 1))
yvals = np.array(data["readcount"]).reshape((data.shape[0], 1))
model = sklearn.linear_model.LinearRegression()
model.fit(xvals, yvals)
pred = model.predict(xvals)
data["pred"] = pred
data["resid"] = data["readcount"] - data["pred"]

# Look at model fit
#sys.stderr.write(str(model.score(xvals, yvals))+"\n")
sys.stderr.write(str(scipy.stats.pearsonr(xvals, yvals))+"\n")

# Output residuals
data[["chrom","start","resid","readcount"]].to_csv(sys.stdout, index=False, sep="\t")
