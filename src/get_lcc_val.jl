"""
    get_lcc_val(d)

Returns a named tuple with boundary values of the domain in projected coordinates
"""
function get_lcc_val(d::Domain)
    nlon, nlat   = d.NLON, d.NLAT    
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

    return (xl = xl, xr = xr, yt = yt, yb = yb, xre = xre, yte = yte)
end 