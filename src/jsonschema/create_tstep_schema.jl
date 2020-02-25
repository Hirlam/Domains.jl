#!/usr/bin/env julia

using OrderedCollections,JSON

# tstep needs to be a divisor of 
# 3600 = 2^4 ⋅ 3^2 ⋅ 5^2
tsteps = sort([2^i2*3^i3*5^i5  for i2=0:4 for i3=0:2 for i5=0:2])
filename = @__FILE__

r = OrderedCollections.OrderedDict()
r[raw"$comment"] = "File created by $filename"
r["type"] = "integer"
r["enum"]  = tsteps

io = open("tstep.schema.json","w")
JSON.print(io, r, 4)
close(io) 

