
module Domains

using  Glob, JSON, Proj4
import Base: show

export Domain,
       lonlat2lcc,
       lcc2lonlat,
       in,       
       getgridpoints


const moduledir = dirname(pathof(Domains))
const jsondir = joinpath(moduledir, "json")
const jsonschemafile = joinpath(moduledir, "jsonschema/domain.schema.json")
const domains = getindex.(splitext.(basename.(Glob.glob("*.json", jsondir))), 1) # Array with domain names  
const Rearth = 6.37122e6

"""
   Domain definitions
"""
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

"""
    Domain(d::Dict)

Constructor for domains from Dictionaries
"""
Domain(d::Dict) = Domain(
       d["NAME"],d["TSTEP"],d["NLON"], d["NLAT"], d["LONC"],
       d["LATC"], d["LON0"], d["LAT0"],d["GSIZE"], d["EZONE"]
    )


"""
    Domain(name::String)

Constructor for `Domain`  
"""
Domain(name::String) =  Domain(JSON.parsefile(joinpath(jsondir, "$name.json")))


function Base.show(io::IO,::MIME"text/plain",d::Domain)
    println(io, "NAME = $(d.NAME)")
    println(io, "NLON = $(d.NLON)")
    println(io, "NLAT = $(d.NLAT)")
    println(io, "LON0 = $(d.LON0)")
    println(io, "LAT0 = $(d.LAT0)")
    println(io, "LONC = $(d.LONC)")
    println(io, "LATC = $(d.LATC)")
  
    #println(io, ), d.LON0, d.LAT0])
    
end







"""
    Plcc(d)

Returns a Lambert Conformal Conic `Proj4.Projection` based on domain definitions in `d`
"""
Plcc(d::Domain) = Proj4.Projection("+proj=lcc +R=$Rearth +lat_0=$(d.LAT0) +lon_0=$(d.LON0) +lat_1=$(d.LAT0) +lat_2=$(d.LAT0) +a=$Rearth +b=$Rearth") 

"""
    Plonlat()

Returns longlat `Proj4.Projection`
"""
Plonlat() = Proj4.Projection("+proj=longlat +R=$Rearth")



"""
    lonlat2lcc(d,lonlat)  
    
Returns Lambert Conformal Conic projection coordinates for `lonlat` using domain definition from `d`
"""
lonlat2lcc(d::Domain, lonlat) = Proj4.transform(Plonlat(), Plcc(d),  lonlat)

"""
    lcc2lonlat(d,xy)  
    
Returns lonlat coordinates for Lambert Conformal Conic projection coordinates `xy` using domain definitions from `d`
"""
lcc2lonlat(d::Domain, xy) = Proj4.transform(Plcc(d), Plonlat(),  xy)


"""
    getgridpoints(d; gsize=d.GSIZE)

Returns an array with the lonlat coordinates of the grid points
"""
function getgridpoints(d; gsize = d.GSIZE)
    v = get_lcc_val(d) 
    xval = range(v.xl, stop = v.xr, step = gsize)
    yval = range(v.yb, stop = v.yt, step = gsize)
    lcc = Plcc(d)
    lonlat = Plonlat()   
    return [Proj4.transform(lcc, lonlat, [x, y]) for x in xval for y in yval]
end 


include("in.jl")
include("get_lcc_val.jl")

end # module Domains





