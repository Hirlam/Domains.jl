"""

    in(lonlat, d; with_ezone = false) 
    lonlat in d 
    lonlat ∈ d  

Returns true if `lonlat` is inside Domain `d`
"""
function Base.in(lonlat, d::Domain; with_ezone::Bool = false)     
    v = get_lcc_val(d::Domain)

    (xn, yn) = lonlat2lcc(d, lonlat) 

    val = with_ezone ? (v.xl < xn < v.xre) && (v.yb < yn < v.yte) :  (v.xl < xn < v.xr) && (v.yb < yn < v.yt)
    return val 
end 