Domains.jl
==========

[![Build Status](https://travis-ci.com/Hirlam/Domains.jl.svg?branch=master)](https://travis-ci.com/Hirlam/Domains.jl)
[![Coverage Status](https://coveralls.io/repos/github/Hirlam/Domains.jl/badge.svg?branch=master)](https://coveralls.io/github/Hirlam/Domains.jl?branch=master)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://hirlam.github.io/Domains.jl/dev)

## Installation 

You can obtain Domains.jl using Julia's Pkg REPL-mode (hitting `]` as the first character of the command prompt):

```julia
(v1.3) pkg> add https://github.com/Hirlam/Domains.jl
```
## Unit tests

The domains in `src/json/` are validated against the json schema file in `src/jsonschema/domain.schema.json`
The schema validates:
 * Required  fields are present: `TSTEP`,`NLON`,`NLAT`,`LONC`,`LATC`,`LON0`,`LAT0`,`GSIZE`
 * `TSTEP` is a divisor of 3600
 * `NLON` (`NLAT`) are of the form 2ᵃ 3ᵇ 5ᶜ with either a≥1, b≥0,c≥0 or a=b=c=0
 * -180≤ `LON0`,`LONC` ≤ 180
 * -90 ≤ `LAT0`,`LATC` ≤ 90
 
 `EZONE` is not required but currently present in all domains `EZONE=11`
 
 In addition ,for domains that use the Lambert projection. tests validate that the north pole is outside the domain. 

[Documentation](https://hirlam.github.io/Domains.jl/dev)


