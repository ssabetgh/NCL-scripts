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
   a = addfile("combine_d03_melt_modified.nc","r")
   SWE    = a->SNOW
;-------Define time----------------------------------------------------------------
time = a->Times                    ; Times(Time, DateStrLen)    (type character)
;printVarSummary(time)
;time_s = chartostring( time )      ; string
;Time_0 = wrf_times_c( Times, 2 )      ; "hours since" initial time on file   (double)
time_3 = wrf_times_c( time, 3 )      ; yyyymmddhh                           (integer)
;time_3 = cd_calendar( time, 2)      ; yyyymmddhh                           (integer)
;print(time_3)

;--------Access time-------------------------------------------------------
SWE1 = SWE(16:668,:,:)

;---------Average SWE over time-------------------------------------------
SWE_avg = dim_avg_n(SWE1,(/0/))

;--------Create Plot----------------------------------------------------------------

;--------Open workstation

 wks = gsn_open_wks("png","test_Final_D03_Melt_numbered_raster")       ; "ps", "pdf", "png"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;   RESOURCE SECTION    ;
;;;;;;;;;;;;;;;;;;;;;;;;
  pltres                = True
  mpres                 = True
 opts = True
 opts@InitTime = False
 opts@Footer = False
; opts@tiXAxisString = "Longitude"       ; xaxis string
; opts@tiYAxisString = "Latitude"        ; yaxis string
; opts@tiMainFontHeightF =0.025

   res                   = opts                  ; plot mods desired
   res@cnFillOn          = True                  ; turn on contour fill
   res@cnFillMode       = "RasterFill"       ; Raster Mode
   res@cnLinesOn        =  False             ; Turn off contour lines


   gsn_define_colormap(wks,"WhBlGrYeRe")         ;MPL_gist_yarg or WhBlGrYeRe")
   res@gsnLeftString   = "LeftString"            ; add the gsn titles
   res@gsnStringFontHeightF = 0.025
;  res@pmTickMarkDisplayMode  = "Always"          ; turn on tickmarks

   lbAutoManage = False

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
 
;    lbAutoManage = True
;    res@lbBoxMinorExtentF = 0.15  ;-- decrease the height of the labelbar
;    res@lbLabelFontHeightF = 0.025
;    res@lbTitleFontHeightF = 0.036
;    res@lbTitleOn = True
    res@pmLabelBarOrthogonalPosF = 0.0005
;    res@lbLabelStrings =  (/"0","100","200","300","400","500","600","700",\
;	"800","900","1000"/) 

;;;;;;;Overlay plot onto a map (using default plot and map setting):
pltres = True
pltres@PanelPlot = True                         ; it's very important to show point on map

; plot = wrf_map_overlays(a,wks,(/contour/),pltres,res)
   contour_SWE_avg = wrf_contour(a,wks,SWE_avg,res)
   plot=wrf_map_overlays(a,wks,(/contour_SWE_avg/),pltres,res)

 gsres = True
 gsres@gsMarkerIndex = (/16/) ; Use filled dots for markers.
; gsres@gsMarkerIndex = (/12/) ; Use filled dots for markers.
 gsres@gsMarkerColor = "yellow"
 gsres@gsMarkerSizeF = 0.02

 lon =(/-114.60,-114.71,-114.91,-114.99,-115.28,-115.78,-116.13,-116.06,-116.63/)
 lat =(/49.78,50.17,50.49,50.71,50.63,51.08,51.05,51.54,51.70/)

 ;Add the name of the station
  txres = True                                      ; text mods desired
  txres@txFontHeightF = 0.018                       ; text font height
  dum = gsn_add_text(wks,plot,(/"9","8","7","6","5","4","3","2","1"/),lon,lat,txres)
  plot_Stn = gsn_add_polymarker(wks,plot,lon,lat, gsres)

  draw(plot)
  frame(wks)
end


