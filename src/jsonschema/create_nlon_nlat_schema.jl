#!/usr/bin/env julia

using OrderedCollections,JSON
filename = @__FILE__

max=3000

# Maximum possible values e.g. 2^i2m < max
i2m = floor(Int,log(2,max))
i3m = floor(Int,log(3,max))
i5m = floor(Int,log(5,max))

# i2 start from 1 because we need even numbers
vals = [2^i2*3^i3*5^i5 for i2 =1:i2m for i3 =0:i3m for i5=0:i5m]
vals = sort(filter(x -> x <= max, vals))


r = OrderedCollections.OrderedDict()
r[raw"$comment"] = "File created by $filename"
r["type"] = "integer"
r["enum"]  = vals

io = open("nlon_nlat.schema.json","w")
JSON.print(io, r, 4)
close(io) 