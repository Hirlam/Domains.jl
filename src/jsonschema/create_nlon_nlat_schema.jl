#!/usr/bin/env julia

using OrderedCollections,JSON
filename = @__FILE__

max=3000

i2s = 1:1:convert(Int,floor(log(2,max))) # i2 start from 1 because we need even numbers
i3s = 0:1:convert(Int,floor(log(3,max)))
i5s = 0:1:convert(Int,floor(log(5,max)))

vals = sort(filter(x -> x <= max, [2^i2*3^i3*5^i5 for i2 in i2s for i3 in i3s for i5 in i5s]))


r = OrderedCollections.OrderedDict()
r[raw"$comment"] = "File created by $filename"
r["type"] = "integer"
r["enum"]  = vals

io = open("nlon_nlat.schema.json","w")
JSON.print(io, r, 4)
close(io) 