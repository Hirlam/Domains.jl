# Model domain settings

For each domain we set variables related to the geometry and the resolution like:

The following variables related to the geometry and the resolution are required:

| Variable | Description | 
| :------- | :---------- |
| `TSTEP`  | model timestep in seconds |
| `NLON`   | number of points in x-direction |
| `NLAT`   | number of points in y-direction |
| `LONC`   | longitude of domain centre in degrees |
| `LATC`   | latitude of domain center in degrees |
| `LON0`   | reference longitude of the projection in degrees |
| `LAT0`   | reference latitude of the projection in degrees| 
| `GSIZE`  | grid size in meters in both x- and y-direction |
| `EZONE`  | number of points over extension zone in both x- and y-direction |
| `LMRT`   | switch for rotated Mercator projection. If LMRT=.TRUE. LAT0 should be zero | 

!!! note 
      * If `LAT0 = 90`, the projection is polar stereographic. 
      * If `LAT0 < 90`, the projection is lambert unless `LMRT=.TRUE.`._

!!! note "Restriction on NLON and NLAT"

    `NLON` and `NLAT` should satisfy the equation ``2^a ⋅ 3^b ⋅ 5^c``, where either ``a ≥ 1, b ≥ 0, c ≥ 0``  or ``a=b=c=0`` 

