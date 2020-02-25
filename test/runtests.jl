

using Test
using Domains, JSON, Proj4, JSONSchema

moduledir = dirname(pathof(Domains))
jsondir = joinpath(moduledir, "json")
jsonschemafile = joinpath(moduledir, "jsonschema/domain.schema.json")
domains = readdir(jsondir)
schema = JSONSchema.Schema(read(jsonschemafile, String), parentFileDirectory = "$moduledir/jsonschema")

# For now exclude non lambert domains from tests
filter!(d->d ∉ ["SCANDINAVIA_ROTM.json","NORWAY_POLAR.json", "RCR_POLAR.json"], domains)   

 
Rearth = 6.37122e6

# Test that the North Pole is outside the domain. 
@testset "North Pole" begin  
    for domain in domains  
        d = JSON.parsefile(joinpath(jsondir, domain))        
        
        nlon, nlat   = d["NLON"], d["NLAT"]
        lon0, lat0   = d["LON0"], d["LAT0"]
        lonc, latc   = d["LONC"], d["LATC"]
        gsize        = d["GSIZE"]
        ezone        = get(d, "EZONE", 11)   # Perhaps include ezone in json files 

        Plonlat = Proj4.Projection("+proj=longlat +R=$Rearth")
        Plcc    = Proj4.Projection("+proj=lcc     +R=$Rearth +lat_0=$lat0 +lon_0=$lon0 +lat_1=$lat0 +lat_2=$lat0 +a=$Rearth +b=$Rearth") 
        
        lonlat2lcc(lonlat) = Proj4.transform(Plonlat, Plcc,  lonlat)
        lcc2lonlat(xy)     = Proj4.transform(Plcc, Plonlat,  xy)

        (xc, yc)   = lonlat2lcc([lonc,latc])
        
        

        xl  = xc - gsize * (nlon - ezone - 1) / 2
        xr  = xc + gsize * (nlon - ezone - 1) / 2
        yt  = yc + gsize * (nlat - ezone - 1) / 2
        yb  = yc - gsize * (nlat - ezone - 1) / 2
        xre = xr + gsize * ezone
        yte = yt + gsize * ezone

        # North pole
        (xn, yn) = lonlat2lcc([ 0 , 90])        

        @test !((xl < xn < xre) & (yb < yn < yte ))
    end 
end # @testset "North Pole" begin 

# Validate domain against schema file
@testset "JSONSchema" begin
    
    for domain in domains  
        d = JSON.parsefile(joinpath(jsondir, domain)) 
        @test JSONSchema.isvalid(d, schema) 
    end 
end
  


