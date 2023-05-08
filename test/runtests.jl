

using Test
using Domains, JSONSchema,JSON

schema = JSONSchema.Schema(read(Domains.jsonschemafile, String), parent_dir = dirname(Domains.jsonschemafile)) 

# For now exclude non lambert domains from tests 
for domain in filter(d->d ∉ ["SCANDINAVIA_ROTM","NORWAY_POLAR", "RCR_POLAR"], Domains.domains) 

    d = Domain(domain)      
    
    @testset "$domain" begin 

        # Validate against JSON schema         
        @test JSONSchema.isvalid(d, schema) 

        # Test that the North Pole [0, 90] is outside the domain with ezone. 
        @test !isin([0, 90], d, with_ezone = true)

    end # @testset "$domain" begin  

end  

