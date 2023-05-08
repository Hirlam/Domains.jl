using Documenter, Domains


pages= [
        
    "Installation" => "index.md", 
    "Projections" => "Projections.md",
    "Settings" => "Settings.md", 
    "Module functions" => "Module.md"
]


format = Documenter.HTML(
    prettyurls = get(ENV, "CI", nothing) == "true"
)

makedocs(
    sitename = "Harmonie Domains",
    pages = pages,
    format = format
)

deploydocs(
    repo = "github.com/Hirlam/Domains.jl.git",
)
