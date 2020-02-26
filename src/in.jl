"""

    in(lonlat, d; with_ezone = false) 
    lonlat in d 
    lonlat ∈ d  

Returns true if `lonlat` is inside Domain `d`
"""
function Base.in(lonlat, d::Domain; with_ezone::Bool = false) 
    
   

    (xn, yn) = lonlat2lcc(d, lonlat) 

    val = with_ezone ? (xl < xn < xre) && (yb < yn < yte) :  (xl < xn < xr) && (yb < yn < yt)
    return val 
end 