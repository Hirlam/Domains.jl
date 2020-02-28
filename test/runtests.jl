

using Test
using Domains, JSONSchema,JSON, Unmarshal

schema = JSONSchema.Schema(read(Domains.jsonschemafile, String), parentFileDirectory = dirname(Domains.jsonschemafile)) 

# For now exclude non lambert domains from test 
for domain in filter(d->d ∉ ["SCANDINAVIA_ROTM","NORWAY_POLAR", "RCR_POLAR"], Domains.domains)     
    @testset "$domain" begin 
        # Validate agains JSON schema
        d = JSON.parsefile(joinpath(Domains.jsondir, "$domain.json"))    
        @test JSONSchema.isvalid(d, schema) 

        # Test that the North Pole is outside the domain with ezone. 
        # North Pole
        lonlatNP = [0, 90]
        @test !in(lonlatNP, unmarshal(Domain, d), with_ezone = true)
    end 

end # @testset "JSONSchema" begin   

