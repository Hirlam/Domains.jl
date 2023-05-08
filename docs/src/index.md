# Installation 

Domains.jl is in the [HarmonieRegistry](https://github.com/Hirlam/HarmonieRegistry). If you haven't added the Harmonie registry yet: In Julia enter REPL-mode (hitting `]` as the first character of the command prompt) and add the registry  


```julia 
(@v1.7) pkg> registry add https://github.com/Hirlam/HarmonieRegistry.git
```

```
     Cloning registry from "https://github.com/Hirlam/HarmonieRegistry.git"
       Added registry `HarmonieRegistry` to `~/.julia/registries/HarmonieRegistry`
```

You might also want to `registry add General`  if this is the first time you use Julia. After that `Domains.jl` can be added by

```julia
(@v1.7) pkg> add Domains
```
```julia
   Resolving package versions...
   Installed JSONSchema ─ v1.0.1
   Installed Glob ─────── v1.3.0
     Cloning [8047f4c8-798f-41f9-bdd5-7e8534b999d6] Domains from https://github.com/Hirlam/Domains.jl
   Installed Domains ──── v0.2.1
    Updating `~/.julia/environments/v1.7/Project.toml`
  [8047f4c8] + Domains v0.2.1
    Updating `~/.julia/environments/v1.7/Manifest.toml`
  [8047f4c8] + Domains v0.2.1
  [c27321d9] + Glob v1.3.0
  [7d188eb4] + JSONSchema v1.0.1
```

