

using Test
using Domains, JSONSchema,JSON


# Validate domain against schema file
@testset "JSONSchema" begin   
    schema = JSONSchema.Schema(read(Domains.jsonschemafile, String), parentFileDirectory = dirname(Domains.jsonschemafile)) 
    for domainname in Domains.domains  
        d = JSON.parsefile(joinpath(Domains.jsondir, "$domainname.json"))
        @test JSONSchema.isvalid(d, schema) 
    end 
end # @testset "JSONSchema" begin   

# Test that the North Pole is outside the domain with ezone. 
@testset "North Pole" begin          
    # For now exclude non lambert domains from test    
    for domain in filter(d->d ∉ ["SCANDINAVIA_ROTM","NORWAY_POLAR", "RCR_POLAR"], Domains.domains)     
        d = readdomain(domain) 

        # North Pole
        lonlatNP = [0, 90]

        @test !in(lonlatNP,d, with_ezone=true)
    end 
end # @testset "North Pole" begin 

  


