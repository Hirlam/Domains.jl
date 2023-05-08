# Projections 

There are four projections available in HARMONIE
 * polar stereographic, 
 * lambert, 
 * mercator 
 * rotated mercator. 
 The model itself chooses the best (least distortion) projection among the first three given your domain specifications. The rotated mercator projection is selected through the variable LROTMER.


!!! note "GRIB1 vs GRIB2" 

    The polar stereographic project is defined at 90°N(S) whereas in GRIB1 it is defined at 60°N(S). 

![](assets/projections1.png)

Polar stereographic, Lambert and Mercator projection


![](assets/rotmer.png)

Rotated mercator projection

