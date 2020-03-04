Domains.jl
==========

[![Build Status](https://travis-ci.com/Hirlam/Domains.jl.svg?branch=master)](https://travis-ci.com/Hirlam/Domains.jl)
[![Coverage Status](https://coveralls.io/repos/github/Hirlam/Domains.jl/badge.svg?branch=master)](https://coveralls.io/github/Hirlam/Domains.jl?branch=master)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://hirlam.github.io/Domains.jl/dev)

## Unit tests

The domains in `src/json/` are validated against the json schema file in `src/jsonschema/domains.schema.json`
The schema validates 
 * `TSTEP` is a divisor of 3600
 * `NLON` (`NLAT`) are of the form 2ᵃ 3ᵇ 5ᶜ with either a≥1, b,c>0 or a=b=c=1
 * -180≤ `NLON` ≤ 180
 * -90 ≤ `NLAT` ≤ 90
 
 In addition for domains that use the Lambert projection unit test validate that the north pole is outside the domain. 

[Documentation](https://hirlam.github.io/Domains.jl/dev)


