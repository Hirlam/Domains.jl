
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
readdomain(domainname::String) =  unmarshal(Domain,JSON.parsefile(joinpath(jsondir, "$domainname.json")))

"""
    lonlat2lcc(d,lonlat)  
    
Returns Lambert Conformal Conic projection coordinates for lonlat using domain definition from `d`
"""
function lonlat2lcc(d::Domain,lonlat)     

    lon0, lat0   = d.LON0, d.LAT0
    Plonlat = Proj4.Projection("+proj=longlat +R=$Rearth")
    Plcc    = Proj4.Projection("+proj=lcc     +R=$Rearth +lat_0=$lat0 +lon_0=$lon0 +lat_1=$lat0 +lat_2=$lat0 +a=$Rearth +b=$Rearth") 

    return Proj4.transform(Plonlat, Plcc,  lonlat)
end 

"""
    lcc2lonlat(d,xy)  
    
Returns lonlat coordinates for Lambert Conformal Conic projection coordinates `xy` using domain definitions from `d`
"""
function lcc2lonlat(d::Domain,xy)    

    lon0, lat0   = d.LON0, d.LAT0
    Plonlat = Proj4.Projection("+proj=longlat +R=$Rearth")
    Plcc    = Proj4.Projection("+proj=lcc     +R=$Rearth +lat_0=$lat0 +lon_0=$lon0 +lat_1=$lat0 +lat_2=$lat0 +a=$Rearth +b=$Rearth") 

    return Proj4.transform(Plcc, Plonlat,  xy)

end 

"""
    getgridpoints(d; gsize=d.GSIZE)

Returns an array with the latlon coordinates of the grid points
"""
function getgridpoints(d; gsize=d.GSIZE)
    v = get_lcc_val(d) 
    xval = range(v.xl,stop = v.xr, step = gsize)
    yval = range(v.yb,stop = v.yt, step = gsize)

    lon0, lat0   = d.LON0, d.LAT0
    Plonlat = Proj4.Projection("+proj=longlat +R=$Rearth")
    Plcc    = Proj4.Projection("+proj=lcc     +R=$Rearth +lat_0=$lat0 +lon_0=$lon0 +lat_1=$lat0 +lat_2=$lat0 +a=$Rearth +b=$Rearth") 

    return [Proj4.transform(Plcc, Plonlat, [x,y]) for x in xval for y in yval]
end 


include("in.jl")
include("get_lcc_val.jl")

end #module Domains





