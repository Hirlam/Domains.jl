
module Domains

using Unmarshal, Glob,JSON

export readdomain

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

# const domains = [unmarshal(Domain, JSON.parsefile(f)) for f in Glob.glob("*.json",jsondir)] 

const domains = getindex.(splitext.(basename.(Glob.glob("*.json",jsondir))),1)

readdomain(domainname) =  JSON.parsefile(joinpath(jsondir, "$domainname.json"))        

# This struct is not used at the moment 
# Could parse JSON to struct



"""
    Returns true if [lon,lat] is inside domain 
"""
#function ∈(lonlat,d::Domain) = 

#end

end #module Domains





