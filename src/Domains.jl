
module Domains

using  Glob, JSON, Proj, JSON3

export Domain, isin


const moduledir = @__DIR__ 
const jsondir = joinpath(moduledir, "json")
const jsonschemafile = joinpath(moduledir, "jsonschema/domain.schema.json")
const domains = getindex.(splitext.(basename.(Glob.glob("*.json", jsondir))), 1) # Array with domain names  
const Rearth = 6.37122e6

"""
    Domain(name::String)

Reads domain definition from json file and returns a `Domain` dictionary
"""
Domain(name::String) =  JSON3.read(read(joinpath(jsondir, "$name.json")))

""" 
    projstr(d) 

Return proj string for domain d. Call without arguments to get longlat proj string
"""
projstr(d) = "+proj=lcc +R=$Rearth +lat_0=$(d.LAT0) +lon_0=$(d.LON0) +lat_1=$(d.LAT0) +lat_2=$(d.LAT0) +a=$Rearth +b=$Rearth" 
projstr()  = "+proj=longlat +R=$Rearth"


"""
    lonlat2lcc(d)

Returns a Proj.Transformation` based on domain definitions in `d` converts from lonlat to xy
"""
lonlat2lcc(d) =Proj.Transformation(projstr(), projstr(d))  


lcc2lonlat(d) =Proj.Transformation(projstr(d), projstr())  

"""
    getgridpoints(d; gsize=d.GSIZE)

Returns an array with the lonlat coordinates of the grid points
"""
function getgridpoints(d; gsize = d.GSIZE)
    v = get_lcc_val(d) 
    xval = range(v.xl, stop = v.xr, step = gsize)
    yval = range(v.yb, stop = v.yt, step = gsize)
    trans = lcc2lonlat(d) 
    return [trans([x, y]) for x in xval for y in yval]
end 

"""

    isin(lonlat, d; with_ezone = false)     

Returns true if `lonlat` is inside Domain `d`
"""
function isin(lonlat, d; with_ezone::Bool = false)     
    xl,xr,yt,yb,xre,yte = get_lcc_val(d)
    trans = lonlat2lcc(d)
    (xn, yn) = trans(lonlat) 

    val = with_ezone ? (xl < xn < xre) && (yb < yn < yte) :  (xl < xn < xr) && (yb < yn < yt)
    return val 
end 


"""
    get_lcc_val(d)

Returns a named tuple with boundary values of the domain in projected coordinates
"""
function get_lcc_val(d)
    nlon, nlat   = d.NLON, d.NLAT    
    lonc, latc   = d.LONC, d.LATC
    gsize        = d.GSIZE
    ezone        = d.EZONE
    
    trans = lonlat2lcc(d)
    (xc, yc)   = trans([lonc,latc])
     

    xl  = xc - gsize * (nlon - ezone - 1) / 2
    xr  = xc + gsize * (nlon - ezone - 1) / 2
    yt  = yc + gsize * (nlat - ezone - 1) / 2
    yb  = yc - gsize * (nlat - ezone - 1) / 2
    xre = xr + gsize * ezone
    yte = yt + gsize * ezone

    return (xl = xl, xr = xr, yt = yt, yb = yb, xre = xre, yte = yte)
end 

end # module Domains





