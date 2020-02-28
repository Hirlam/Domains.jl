Domains.jl
==========

[![Build Status](https://travis-ci.com/Hirlam/Domains.jl.svg?branch=master)](https://travis-ci.com/Hirlam/Domains.jl)
[![Coverage Status](https://coveralls.io/repos/github/Hirlam/Domains.jl/badge.svg?branch=master)](https://coveralls.io/github/Hirlam/Domains.jl?branch=master)


There are four projections available in HARMONIE, polar stereographic, lambert, mercator and rotated mercator. The model itself chooses the best (least distortion) projection among the first three given your domain specifications. The rotated mercator projection is selected through the variable LROTMER. Note that the polar stereographic project is defined at 90°N(S) whereas in GRIB1 it is defined at 60°N(S). 

## Model domain settings

For each domain we set variables related to the geometry and the resolution like:

The following variables related to the geometry and the resolution are required:

* TSTEP is model timestep in seconds
* NLON is number of points in x-direction.
* NLAT is number of points in y-direction.
* LONC is the longitude of domain centre in degrees.
* LATC is the latitude of domain center in degrees.
* LON0 is the reference longitude of the projection in degrees.
* LAT0 is the reference latitude of the projection in degrees. 
    * If LAT0 = 90, the projection is polar stereographic. 
    * If LAT0 < 90, the projection is lambert unless LMRT=.TRUE.._
* GSIZE is grid size in meters in both x- and y-direction.
* EZONE is number of points over extension zone in both x- and y-direction. Default value 11.
* LMRT switch for rotated Mercator projection. If LMRT=.TRUE. LAT0 should be zero. 

NLON and NLAT should satisfy the equation 5^a * 3^b * 2^c, where a-c are integers >= 0. 

