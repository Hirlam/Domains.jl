
module Domains

using Unmarshal, Glob,JSON, Proj4
import Base
export readdomain, Domain, in, lonlat2lcc, lcc2lonlat

struct Domain     
    NAME::String
    TSTEP::Int
    NLON::Int
    NLAT::Int
    LONC::Float64
    LATC::Float64
    LON0::Float64
    LAT0::Float64    
    GSIZE::Float64
    EZONE::Int   
end

const moduledir = dirname(pathof(Domains))
const jsondir = joinpath(moduledir, "json")
const jsonschemafile = joinpath(moduledir , "jsonschema/domain.schema.json")
const Rearth = 6.37122e6

# const domains = [unmarshal(Domain, JSON.parsefile(f)) for f in Glob.glob("*.json",jsondir)] 

# domains is an array with domain filenames 
const domains = getindex.(splitext.(basename.(Glob.glob("*.json",jsondir))),1)

"""
    readdomain(domainname)

    returns a `Domain` 

"""
readdomain(domainname) =  unmarshal(Domain,JSON.parsefile(joinpath(jsondir, "$domainname.json")))



function lonlat2lcc(d,lonlat)     

    nlon, nlat   = d.NLON, d.NLAT
    lon0, lat0   = d.LON0, d.LAT0
    lonc, latc   = d.LONC, d.LATC
    gsize        = d.GSIZE
    ezone        = d.EZONE
    Plonlat = Proj4.Projection("+proj=longlat +R=$Rearth")
    Plcc    = Proj4.Projection("+proj=lcc     +R=$Rearth +lat_0=$lat0 +lon_0=$lon0 +lat_1=$lat0 +lat_2=$lat0 +a=$Rearth +b=$Rearth") 

    return Proj4.transform(Plonlat, Plcc,  lonlat)
end 

function lcc2lonlat(d,xy)    

    nlon, nlat   = d.NLON, d.NLAT
    lon0, lat0   = d.LON0, d.LAT0
    lonc, latc   = d.LONC, d.LATC
    gsize        = d.GSIZE
    ezone        = d.EZONE
    Plonlat = Proj4.Projection("+proj=longlat +R=$Rearth")
    Plcc    = Proj4.Projection("+proj=lcc     +R=$Rearth +lat_0=$lat0 +lon_0=$lon0 +lat_1=$lat0 +lat_2=$lat0 +a=$Rearth +b=$Rearth") 

    return Proj4.transform(Plcc, Plonlat,  xy)

end 



include("in.jl")

end #module Domains





