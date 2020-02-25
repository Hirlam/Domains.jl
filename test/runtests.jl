

using Test
using Domains, JSON, Proj4

jsondir = joinpath(dirname(pathof(Domains)), "json")
domains = readdir(jsondir)

# For now exclude non lambert domains
filter!(d -> d!="SCANDINAVIA_ROTM.json", domains)   
 
Rearth = 6.371e6

testlon(lon) = -180.0 <= lon <= 180.0
testlat(lat) =  -90.0 <= lat <=  90.0
testlonlat(lonlat) = testlon(lonlat[1]) & testlat(lonlat[2])


@testset "Proj" begin  
    for domain in domains  
        d = JSON.parsefile(joinpath(jsondir, domain)) 

        Plonlat = Proj4.Projection("+proj=longlat +R=$Rearth")
        Plcca   = Proj4.Projection("+proj=lcca    +R=$Rearth +lat_0=$(d["LAT0"]) +lon_0=$(d["LON0"])") 
        
        lcca2lonlat(xy)     = Proj4.transform(Plcca, Plonlat, xy)
        lonlat2lcca(lonlat) = Proj4.transform(Plonlat, Plcca, lonlat)

        (xc, yc) = lonlat2lcca([d["LONC"], d["LATC"]])
        gsize = d["GSIZE"]
        nlon = d["NLON"]
        nlat = d["NLAT"]
        ezone = get(d,"EZONE",11)   # we should include ezone in json files 

        xl  = xc - gsize * (nlon - ezone - 1) / 2
        xr  = xc + gsize * (nlon - ezone - 1) / 2
        yt  = yc + gsize * (nlat - ezone - 1) / 2
        yb  = yc - gsize * (nlat - ezone - 1) / 2
        xre = xr + gsize*ezone
        yte = yt + gsize*ezone

        # North pole
        (xn, yn) = lonlat2lcca([ 0 , 90])        

        # Check that North pole is not inside domain
        println(d["NAME"])
        @test !((xl < xn < xre) & (yb < yn < yte ))

    end 
end


