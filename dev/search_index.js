var documenterSearchIndex = {"docs":
[{"location":"#Domains.jl-documentation-1","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"","category":"section"},{"location":"#Installation-1","page":"Domains.jl documentation","title":"Installation","text":"","category":"section"},{"location":"#","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"You can obtain Domains.jl using Julia's Pkg REPL-mode (hitting ] as the first character of the command prompt):","category":"page"},{"location":"#","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"(v1.3) pkg> add https://github.com/Hirlam/Domains.jl","category":"page"},{"location":"#Domain-projections-1","page":"Domains.jl documentation","title":"Domain projections","text":"","category":"section"},{"location":"#","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"There are four projections available in HARMONIE","category":"page"},{"location":"#","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"polar stereographic, \nlambert, \nmercator \nrotated mercator. ","category":"page"},{"location":"#","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"The model itself chooses the best (least distortion) projection among the first three given your domain specifications. The rotated mercator projection is selected through the variable LROTMER.","category":"page"},{"location":"#","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"note: GRIB1 vs GRIB2\nThe polar stereographic project is defined at 90°N(S) whereas in GRIB1 it is defined at 60°N(S). ","category":"page"},{"location":"#","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"(Image: )","category":"page"},{"location":"#","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"Polar stereographic, Lambert and Mercator projection","category":"page"},{"location":"#","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"(Image: )","category":"page"},{"location":"#","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"Rotated mercator projection","category":"page"},{"location":"#Model-domain-settings-1","page":"Domains.jl documentation","title":"Model domain settings","text":"","category":"section"},{"location":"#","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"For each domain we set variables related to the geometry and the resolution like:","category":"page"},{"location":"#","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"The following variables related to the geometry and the resolution are required:","category":"page"},{"location":"#","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"Variable Description\nTSTEP model timestep in seconds\nNLON number of points in x-direction\nNLAT number of points in y-direction\nLONC longitude of domain centre in degrees\nLATC latitude of domain center in degrees\nLON0 reference longitude of the projection in degrees\nLAT0 reference latitude of the projection in degrees\nGSIZE grid size in meters in both x- and y-direction\nEZONE number of points over extension zone in both x- and y-direction\nLMRT switch for rotated Mercator projection. If LMRT=.TRUE. LAT0 should be zero","category":"page"},{"location":"#","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"note: Note\nIf LAT0 = 90, the projection is polar stereographic. \nIf LAT0 < 90, the projection is lambert unless LMRT=.TRUE.._","category":"page"},{"location":"#","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"note: Restriction on NLON and NLAT\nNLON and NLAT should satisfy the equation 5^a  3^b  2^c, where either a  1 b  0 c  0  or a=b=c=0 ","category":"page"},{"location":"#Example-1","page":"Domains.jl documentation","title":"Example","text":"","category":"section"},{"location":"#","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"using Domains, Plots\nd = readdomain(\"METCOOP25C\")\ngp = getgridpoints(d,gsize=100000)\nscatter(getindex.(gp,1),getindex.(gp,2),legend=false)","category":"page"},{"location":"#","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"Will give ","category":"page"},{"location":"#","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"(Image: )","category":"page"},{"location":"#Modules-functions-1","page":"Domains.jl documentation","title":"Modules functions","text":"","category":"section"},{"location":"#","page":"Domains.jl documentation","title":"Domains.jl documentation","text":"   Modules = [Domains]","category":"page"},{"location":"#Domains.Domain","page":"Domains.jl documentation","title":"Domains.Domain","text":"Domain definitions\n\n\n\n\n\n","category":"type"},{"location":"#Base.in-Tuple{Any,Domain}","page":"Domains.jl documentation","title":"Base.in","text":"in(lonlat, d; with_ezone = false) \nlonlat in d \nlonlat ∈ d\n\nReturns true if lonlat is inside Domain d\n\n\n\n\n\n","category":"method"},{"location":"#Domains.getgridpoints-Tuple{Any}","page":"Domains.jl documentation","title":"Domains.getgridpoints","text":"getgridpoints(d; gsize=d.GSIZE)\n\nReturns an array with the lonlat coordinates of the grid points\n\n\n\n\n\n","category":"method"},{"location":"#Domains.lcc2lonlat-Tuple{Domain,Any}","page":"Domains.jl documentation","title":"Domains.lcc2lonlat","text":"lcc2lonlat(d,xy)\n\nReturns lonlat coordinates for Lambert Conformal Conic projection coordinates xy using domain definitions from d\n\n\n\n\n\n","category":"method"},{"location":"#Domains.lonlat2lcc-Tuple{Domain,Any}","page":"Domains.jl documentation","title":"Domains.lonlat2lcc","text":"lonlat2lcc(d,lonlat)\n\nReturns Lambert Conformal Conic projection coordinates for lonlat using domain definition from d\n\n\n\n\n\n","category":"method"},{"location":"#Domains.readdomain-Tuple{String}","page":"Domains.jl documentation","title":"Domains.readdomain","text":"readdomain(domainname)\n\nReturns a Domain  \n\n\n\n\n\n","category":"method"},{"location":"#Domains.Plcc-Tuple{Domain}","page":"Domains.jl documentation","title":"Domains.Plcc","text":"Plcc(d)\n\nReturns a Lambert Conformal Conic Proj4.Projection based on domain definitions in d\n\n\n\n\n\n","category":"method"},{"location":"#Domains.Plonlat-Tuple{}","page":"Domains.jl documentation","title":"Domains.Plonlat","text":"Plonlat()\n\nReturns longlat Proj4.Projection\n\n\n\n\n\n","category":"method"},{"location":"#Domains.get_lcc_val-Tuple{Domain}","page":"Domains.jl documentation","title":"Domains.get_lcc_val","text":"get_lcc_val(d)\n\nReturns a named tuple with boundary values of the domain in projected coordinates\n\n\n\n\n\n","category":"method"}]
}
