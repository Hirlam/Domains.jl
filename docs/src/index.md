# Domains.jl documentation

## Installation 

Domains.jl is in the [HarmonieRegistry](https://github.com/Hirlam/HarmonieRegistry). If you haven't added the Harmonie registry yet: In Julia enter REPL-mode (hitting `]` as the first character of the command prompt) and add the registry  


```julia 
(@v1.7) pkg> registry add https://github.com/Hirlam/HarmonieRegistry.git
```

```
     Cloning registry from "https://github.com/Hirlam/HarmonieRegistry.git"
       Added registry `HarmonieRegistry` to `~/.julia/registries/HarmonieRegistry`
```

You might also want to `registry add General`  if this is the first time you use Julia. After that `Domains.jl` can be added by

```julia
(@v1.7) pkg> add Domains
```
```julia
   Resolving package versions...
   Installed JSONSchema ─ v1.0.1
   Installed Glob ─────── v1.3.0
     Cloning [8047f4c8-798f-41f9-bdd5-7e8534b999d6] Domains from https://github.com/Hirlam/Domains.jl
   Installed Domains ──── v0.2.1
    Updating `~/.julia/environments/v1.7/Project.toml`
  [8047f4c8] + Domains v0.2.1
    Updating `~/.julia/environments/v1.7/Manifest.toml`
  [8047f4c8] + Domains v0.2.1
  [c27321d9] + Glob v1.3.0
  [7d188eb4] + JSONSchema v1.0.1
```

## Domain projections 

There are four projections available in HARMONIE
 * polar stereographic, 
 * lambert, 
 * mercator 
 * rotated mercator. 
 The model itself chooses the best (least distortion) projection among the first three given your domain specifications. The rotated mercator projection is selected through the variable LROTMER.


!!! note "GRIB1 vs GRIB2" 

    The polar stereographic project is defined at 90°N(S) whereas in GRIB1 it is defined at 60°N(S). 

![](assets/projections1.png)

Polar stereographic, Lambert and Mercator projection


![](assets/rotmer.png)

Rotated mercator projection


## Model domain settings

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

## Example

```julia 
using Domains, Plots
d = Domain("METCOOP25C")
gp = getgridpoints(d,gsize=100000)
scatter(getindex.(gp,1),getindex.(gp,2),legend=false)
```

Will give 

![](assets/scatter_metcoop25c_100km.png)


## Module functions    


```@autodocs
   Modules = [Domains]
```

