
module Domains

using JSON, Proj4

struct Domain     
    NLON::Int
    NLAT::Int
    LONC::Float64
    LATC::Float64
    LON0::Float64
    LAT0::Float64    
    GSIZE::Float64
    EZONE::Int   
end


end #module Domains





