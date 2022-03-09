*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


equations
 q31_carbon(j,ag_pools)                                 Above ground carbon content calculation for pasture (mio tC)
 q31_cost_prod_past(i)                                  Costs for putting animals on pastures (mio. USD05MER per yr)
 q31_bv_manpast(j,potnatveg)                            Biodiversity value for managed pastures (Mha)
 q31_bv_rangeland(j,potnatveg)                          Biodiversity value for rangeland (Mha)
;


positive variables
v31_grass_area(j,grassland,w)                           Grass production area (mio. ha)
v31_grass_yld(j,grassland,w)                            Grassland Yields (tDM per ha per yr)
;

parameters
i31_manpast_suit(t_all,j)                               Areas suitable for managed pastures (mio. ha)
pc31_grass(j,grassland)                                 Grassland areas in previous time step (mio. ha)
i31_grass_calib(t_all,j,grassland)                      Regional grassland calibration factor correcting for FAO yield levels (1)
i31_grass_modeled_yld(t_all,i,grassland)                Biophysical input yields average over region and grassland cover type at the historical reference year (tDM per ha per yr)
i31_grass_yields(t_all,j,grassland,w)                   Cellular biophysical input yields (tDM per ha per yr)
i31_grassl_areas(t_all,j)                            Celullar grassland areas (mio. ha)
i31_lambda_grass(t,i,grassland)                         Grassland Scaling factor for non-linear management calibration (1)
i31_grassl_yld_hist_reg(t,i,grassland)                  Grassland FAO yields per region at the historical referende year (tDM per ha per yr)
i31_grass_hist_yld(t_all,i, grassland)                   FAO gassland yields (tDM per ha per yr)
;

equations
q31_pasture_areas(j)                                     Total grassland calculation (mio. ha)
q31_manpast_suitability(i)                               Constraint on areas suitable for managed pastures (mio. ha)
q31_prod_pm(j)                                           Cellular grass production constraint (mio. tDM per yr)
q31_expansion_cost(j)                                    Grassland transition cost constraint
q31_yield_grassl_range(j)                    Rangelands yield calculation (tDM per ha per yr)
q31_yield_grassl_pastr(j)                    Managed pastures yield calculation (tDM per ha per yr)
;

positive variables
v31_cost_grass_expansion(j)                              Costs for grassland transitions (mio. USD05MER per yr)
;




*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov31_grass_area(t,j,grassland,w,type)         Grass production area (mio. ha)
 ov31_grass_yld(t,j,grassland,w,type)          Grassland Yields (tDM per ha per yr)
 ov31_cost_grass_expansion(t,j,type)           Costs for grassland transitions (mio. USD05MER per yr)
 oq31_carbon(t,j,ag_pools,type)                Above ground carbon content calculation for pasture (mio tC)
 oq31_cost_prod_past(t,i,type)                 Costs for putting animals on pastures (mio. USD05MER per yr)
 oq31_bv_manpast(t,j,potnatveg,type)           Biodiversity value for managed pastures (Mha)
 oq31_bv_rangeland(t,j,potnatveg,type)         Biodiversity value for rangeland (Mha)
 oq31_pasture_areas(t,j,type)                  Total grassland calculation (mio. ha)
 oq31_manpast_suitability(t,i,type)            Constraint on areas suitable for managed pastures (mio. ha)
 oq31_prod_pm(t,j,type)                        Cellular grass production constraint (mio. tDM per yr)
 oq31_expansion_cost(t,j,type)                 Grassland transition cost constraint
 oq31_yield_grassl_range(t,j,grassland,w,type) Rangelands yield calculation (tDM per ha per yr)
 oq31_yield_grassl_pastr(t,j,grassland,w,type) Managed pastures yield calculation (tDM per ha per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
