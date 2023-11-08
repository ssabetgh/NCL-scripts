;cript shows how to overlay line contours and wind barbs on
; top of a filled contour plot over a map.
;----------------------------------------------------------------------
; Not needed in NCL V6.3.0 or later.
; load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

;-----
a = addfile("/scratch/c/cgf/ssabet/WRF_CODE/WRF-4.3.2/run/wrfout_d03_2017-10-01_00:00:00","r")
; a = addfile("combine_d02_melt_modified.nc","r")

; a = addfile("combine_d01_accum.nc","r")

;--- Open a file and get several diagnostics
;-----slp = wrf_user_getvar(f, "slp", 0)

;---sd1  = wrf_user_getvar(f, "SNOW",  -1)
; SWE    = a->SNOW
;HEIGHT    = a->HGT
 T2M    = a->T2
;; precipsnow    = a->SNOWNC
;LU  = a->LU_INDEX
;printVarSummary(LU)


;;;sd2=sd1(:,:,:)
;;;sd = dim_max_n( sd2, (/0/))
;------
;------
;-----
; Time lat lon Here
;--------
;-------
;--sd3=sd1(:,73,88)
;SWE1 = SWE(:,70,89)
;HEIGHT1 = HEIGHT(:,219,68)
;HEIGHT1 = HEIGHT(:,70,89)
T2M1 = T2M(:,123,68)-273
;LU1= LU(:,120,68)
;precipsnow1 = precipsnow(:,71,90)

;sd_point = dim_max_n( sd3, (/0/))
;print (precipsnow1)
print (T2M1)
exit
wks = gsn_open_wks("png","1_test2")


;--- Line contours
os                  = True
os@cnLineColor      = "Blue"
os@cnLineThicknessF = 2.0
;plt_slp               = wrf_contour(f,wks,slp,os)

;--- Filled contours
ot             = True
ot@cnFillOn    = True
ot@ContourParameters = (/ 0.1, 2, 0.1 /)  ; Start, end, spacing of contour levels

ot@cnFillPalette="WhViBlGrYeOrRe"
 ot@NoHeaderFooter = True

plt_sd           = wrf_contour(f,wks,sd,ot)

;--- Overlay vectors, line contours, and filled contours on a map
pltres = True
  mpres = True
   mpres@mpGeophysicalLineColor = "Black"
  mpres@mpGeophysicalLineThicknessF  = 5
  mpres@mpNationalLineColor    = "Black"
  mpres@mpNationalLineThicknessF  =5
  mpres@mpUSStateLineColor     = "Black"
  mpres@mpGridLineColor        = "Black"
  mpres@mpLimbLineColor        = "Black"
  mpres@mpPerimLineColor       = "Black"
  mpres@mpOutlineBoundarySets = "National"
  mpres@tmXBLabelFontHeightF = 0.02
  mpres@tmYLLabelFontHeightF = 0.02
plot   = wrf_map_overlays(f,wks,(/plt_sd/),pltres,mpres)
