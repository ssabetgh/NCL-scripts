
 load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
 load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
 load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
 load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

a = addfile("/scratch/c/cgf/ssabet/WRF_CODE/WRF-4.3.2/run/wrfout_d01_2017-10-31_00:00:00","r")
;**************************************************************
 lat = wrf_user_getvar(a, "lat", 0)
 lon = wrf_user_getvar(a, "lon", 0)
;wks = gsn_open_wks("X11","wa on height")
 lat1d = lat(:,:)           ;convert lat & lon to 1 dimension
 lon1d = lon(:,:)
; print(dim_avg_n_Wrap(lat1d,(/1/)))
 ;print(dim_avg_n_Wrap(lon1d,(/0/)))
;**************************************************************


 lo = -115.279
 la = 50.631
 loc2  = wrf_user_ll_to_ij(a ,lo , la, True)   ; (a , longitude , latitude , True)
  print("i location is: " + loc2(0))
  print("j location is: " + loc2(1))


