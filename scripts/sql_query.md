**CHARTIO SQL API ENDPOINT**: https://lucidv01d.cartodb.com/api/v2/sql?q=

### QUERIES
---
* Tax Savings:
`select v.savings, v.the_geom from public.vacant_lots v, public.food_desert f where v.census_track = f.census_track`

* Avalible Garden Plots:
`select v.acrage, v.the_geom from public.vacant_lots v, public.food_desert f where v.census_track = f.census_track`

* Population Impact:
`select temp.population, temp.the_geom from (select p.population, v.the_geom, v.census_track from vacant_lots v join population p on p.census_track = v.census_track) as temp, food_desert f where temp.census_track = f.census_track and temp.elig = FALSE`

