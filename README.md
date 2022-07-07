Domains.jl
==========

[![Build Status](https://travis-ci.com/Hirlam/Domains.jl.svg?branch=master)](https://travis-ci.com/Hirlam/Domains.jl)
[![Coverage Status](https://coveralls.io/repos/github/Hirlam/Domains.jl/badge.svg?branch=master)](https://coveralls.io/github/Hirlam/Domains.jl?branch=master)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://hirlam.github.io/Domains.jl/dev)


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

## Unit tests

The domains in `src/json/` are validated against the json schema file in `src/jsonschema/domain.schema.json`
The schema validates:
 * Required  fields are present: `TSTEP`, `NLON`, `NLAT`, `LONC`, `LATC`, `LON0`, `LAT0`, `GSIZE`
 * `TSTEP` is a divisor of 3600
 * `NLON` (`NLAT`) is of the form 2ᵃ 3ᵇ 5ᶜ with either a≥1, b≥0,c≥0 or a=b=c=0
 * -180 ≤ `LON0`, `LONC` ≤ 180
 * -90 ≤ `LAT0`, `LATC` ≤ 90
 
 `EZONE` is not required but currently present in all domains `EZONE=11`
 
 In addition, for domains that use the Lambert projection, tests validate that the north pole is outside the domain. 

[Documentation](https://hirlam.github.io/Domains.jl/dev)


