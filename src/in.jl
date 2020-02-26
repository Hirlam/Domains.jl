"""
    in(lonlat, d; with_ezone = false) 
    lonlat in d 
    lonlat ∈ d  
    Returns true if `lonlat` is inside Domain `d`
"""
function Base.in(lonlat, d::Domain; with_ezone::Bool = false) 
    
    nlon, nlat   = d.NLON, d.NLAT
    lon0, lat0   = d.LON0, d.LAT0
    lonc, latc   = d.LONC, d.LATC
    gsize        = d.GSIZE
    ezone        = d.EZONE

    (xc, yc)   = lonlat2lcc(d, [lonc,latc])
        
        

    xl  = xc - gsize * (nlon - ezone - 1) / 2
    xr  = xc + gsize * (nlon - ezone - 1) / 2
    yt  = yc + gsize * (nlat - ezone - 1) / 2
    yb  = yc - gsize * (nlat - ezone - 1) / 2
    xre = xr + gsize * ezone
    yte = yt + gsize * ezone

    (xn, yn) = lonlat2lcc(d, lonlat) 

    val = with_ezone ? (xl < xn < xre) && (yb < yn < yte) :  (xl < xn < xr) && (yb < yn < yt)
    return val 
end 