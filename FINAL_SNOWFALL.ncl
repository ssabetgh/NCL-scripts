; script creates a basic color-filled contour plot of the "SWE" 
; variable on the "combine*.nc" NetCDF file.
;
;----------------------------------------------------------------------
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
;---------------------------------------------------------------------
begin
;---Read data--------------------------------------------------------
;   a = addfile("combine_d03_accum.nc","r")
   a = addfile("combine_d01_melt_modified.nc","r")
   SNOWNC    = a->SNOWNC
;  printVarSummary(SWE)

;--------Define position---------------------------------------------
; lat=wrf_user_getvar(a, "lat", 0)
; lon=wrf_user_getvar(a, "lon", 0)
;lat1d=lat(:,:)
;lon1d=lon(:,:)
;print (dim_avg_n_Wrap(lat1d,(/1/)))
;print (dim_avg_n_Wrap(lon1d,(/0/)))

;-------Define time----------------------------------------------------------------
time = a->Times                    ; Times(Time, DateStrLen)    (type character)
;printVarSummary(time)
;time_s = chartostring( time )      ; string
;Time_0 = wrf_times_c( Times, 2 )      ; "hours since" initial time on file   (double)
time_3 = wrf_times_c( time, 3 )      ; yyyymmddhh                           (integer)
;time_3 = cd_calendar( time, 2)      ; yyyymmddhh                           (integer)
;print(time_3)

;--------Access time-------------------------------------------------------
SNOWNC1 = SNOWNC(16:668,47:83,82:94)
;printVarSummary(SWE1)

;---------Average SWE over time-------------------------------------------
SNOWNC_avg = dim_avg_n(SNOWNC,(/0/))
;print(T2M_avg)
;printVarSummary(SWE_avg)

;--------Create Plot----------------------------------------------------------------

;--------Open workstation

 wks = gsn_open_wks("png","Final_D01_Melt_SnownadIce")       ; "ps", "pdf", "png"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;   RESOURCE SECTION    ;
;;;;;;;;;;;;;;;;;;;;;;;;
  pltres                = True
  mpres                 = True
;mpres@mpOutlineBoundarySets = "National" 
;mpres@mpNationalLineThicknessF = 1.5 
;mpres@mpNationalLineColor = "Black" 
;mpres@mpGeophysicalLineColor = "Black" 
;mpres@mpGeophysicalLineThicknessF = 1.5

 opts = True
 opts@InitTime = False
 opts@Footer = False
; opts@tiXAxisString = "Longitude"       ; xaxis string
; opts@tiYAxisString = "Latitude"        ; yaxis string
; opts@tiMainFontHeightF =0.025

   res                   = opts                  ; plot mods desired
   res@cnFillOn          = True                  ; turn on contour fill
   gsn_define_colormap(wks,"WhBlGrYeRe")         ;MPL_gist_yarg or WhBlGrYeRe")
   res@gsnLeftString   = "LeftString"            ; add the gsn titles
   res@gsnStringFontHeightF = 0.025

;  res@pmTickMarkDisplayMode  = "Always"          ; turn on tickmarks
   lbAutoManage = False
 
;  res@lbLabelFontHeightF = 0.025
;  res@lbTitleFontHeightF = 0.036
;  res@lbTitleOn = True
;  res@pmLabelBarOrthogonalPosF = 0.02

   res@mpLimitMode  = "Points"                    ; Change the area of the map
   res@mpLeftPointLatF = 51.37               ; viewed.
   res@mpLeftPointLonF = -117.453
   res@mpRightPointLatF = 49.76
   res@mpRightPointLonF = -113.405
   res@mpBottomPointLatF= 49.171
   res@mpBottomPointLonF = -114.58
   res@mpTopPointLatF = 52.0154
   res@mpTopPointLonF = -116.26
   res@mpGridLonSpacingF      = 0.001
 
 ;  lbAutoManage = True
    res@lbLabelFontHeightF = 0.025
;    res@lbTitleFontHeightF = 0.036
;    res@lbTitleOn = True
    res@pmLabelBarOrthogonalPosF = 0.0005


; Resources to control labelbar title, size, and location.
;  opts@lbTitleString            = "SWE"
;  opts@pmLabelBarWidthF         = 0.8
;  opts@pmLabelBarHeightF        = 0.35
;  opts@pmLabelBarOrthogonalPosF = 0.23

   
   contour_SNOWNC_avg = wrf_contour(a,wks,SNOWNC_avg,res)
   plot=wrf_map_overlays(a,wks,(/contour_SNOWNC_avg/),pltres,res)

end



