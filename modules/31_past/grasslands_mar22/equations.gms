*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations


*' Grassland yileds are calculated separetely for rangelands and managed pastures.
*' Technological change can increase the initial calibrated
*' yields of manged pastures, whereas rangeland yields are kept unaltered
*' after calibration.

q31_yield_grassl_range(j2)..
 v31_grass_yld(j2,"range","rainfed") =e=
 sum(ct,i31_grass_yields(ct,j2,"range","rainfed"));

q31_yield_grassl_pastr(j2)..
  v31_grass_yld(j2,"pastr","rainfed") =e=
  sum(ct,i31_grass_yields(ct,j2,"pastr","rainfed"))
  * sum((cell(i2,j2), supreg(h2,i2)), vm_tau(h2, "pastr") / fm_pastr_tau_hist("y1995",h2));


*' Production of grass biomass is calculated by multiplying grassland areas
*' `v31_grass_area` with cellular rainfed rangelands and managed pasture yields
*' `v31_grass_yld`:

q31_prod_pm(j2) ..
  vm_prod(j2,"pasture") =e= sum(grassland, v31_grass_area(j2,grassland,"rainfed")
                            * v31_grass_yld(j2,grassland,"rainfed"));

*' the sum of all managed pastures and rangelands equals the areas of the parent
*' land class "pastures".

q31_pasture_areas(j2)..
  vm_land(j2,"past") =e= sum(grassland, v31_grass_area(j2,grassland,"rainfed"));

*' Socio economic and environmental conditions constraints the areas available for
*' pasture management

q31_manpast_suitability(i2)..
  sum(cell(i2,j2), v31_grass_area(j2,"pastr","rainfed")) =l= sum((cell(i2,j2),ct),i31_manpast_suit(ct,j2));

*' To avoid unrealistic conversions between rangelands and managed pastures areas,
*' a cost is associated with the expansion of rangelands and managed pastures stored in
*' v31_cost_grass_expansion

q31_expansion_cost(j2) ..
  v31_cost_grass_expansion(j2) =g=
                            sum(grassland, v31_grass_area(j2, grassland, "rainfed") - pc31_grass(j2,grassland));

q31_cost_prod_past(i2) ..
  vm_cost_prod(i2,"pasture") =e= sum((cell(i2,j2), grassland),
                            v31_grass_area(j2, grassland, "rainfed") *
                            v31_grass_yld(j2, grassland, "rainfed") +
                            v31_cost_grass_expansion(j2));

*' On the basis of the required pasture area, cellular above ground carbon stocks are calculated:

q31_carbon(j2,ag_pools) ..
 vm_carbon_stock(j2,"past",ag_pools) =e=
         sum(ct, vm_land(j2,"past")*fm_carbon_density(ct,j2,"past",ag_pools));

*' By estimating the different area of managed pasture and rangeland via the luh2 side layers, the biodiversity value for pastures and rangeland is calculated in following:
  q31_bv_manpast(j2,potnatveg) .. vm_bv(j2,"manpast",potnatveg)
  					=e=
					vm_land(j2,"past") * fm_luh2_side_layers(j2,"manpast") * fm_bii_coeff("manpast",potnatveg) * fm_luh2_side_layers(j2,potnatveg);

  q31_bv_rangeland(j2,potnatveg) .. vm_bv(j2,"rangeland",potnatveg)
  					=e=
					vm_land(j2,"past") * fm_luh2_side_layers(j2,"rangeland") * fm_bii_coeff("rangeland",potnatveg) * fm_luh2_side_layers(j2,potnatveg);


*' In the initial calibration time step, where the pasture calibration factor
*' is calculated that brings pasture biomass demand and pasture area in balance,
*' small costs are attributed to the production of pasture biomass in order to
*' avoid overproduction of pasture in the model:

*' For all following time steps, factor requriements `s31_test_scalar` are set
*' to zero.

*** EOF constraints.gms ***
