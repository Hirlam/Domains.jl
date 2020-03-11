using Documenter, Domains

makedocs(sitename="Domains")

deploydocs(
    repo = "github.com/Hirlam/Domains.jl.git",
    versions = ["stable" => "v1.0.0","v1.0.1"]
)
