;***************************************************
; New CAPE file: just test one file
; Usw pres_ccm_hybrid within script to handle pressure levs? Is what Gabe said? 
; Shay Magahey 03/09/2023
; **********************************************************

begin

FT = addfile("/glade/campaign/cesm/collections/cesmLE/CESM-CAM5-BGC-LE/atm/proc/tseries/monthly/T/b.e11.B20TRLENS_RCP85.f09_g16.xbmb.002.cam.h0.T.192001-202912.nc","r")

FQ = addfile("/glade/campaign/cesm/collections/cesmLE/CESM-CAM5-BGC-LE/atm/proc/tseries/monthly/Q/b.e11.B20TRLENS_RCP85.f09_g16.xbmb.002.cam.h0.Q.192001-202912.nc","r")
FZ = addfile("/glade/campaign/cesm/collections/cesmLE/CESM-CAM5-BGC-LE/atm/proc/tseries/monthly/Z3/b.e11.B20TRLENS_RCP85.f09_g16.xbmb.002.cam.h0.Z3.192001-202912.nc","r")
FPS = addfile("/glade/campaign/cesm/collections/cesmLE/CESM-CAM5-BGC-LE/atm/proc/tseries/monthly/PS/b.e11.B20TRLENS_RCP85.f09_g16.xbmb.002.cam.h0.PS.192001-202912.nc","r")
FTOP = addfile("/glade/campaign/cesm/collections/cesmLE/CESM-CAM5-BGC-LE/atm/proc/tseries/monthly/PHIS/b.e11.B20TRLENS_RCP85.f09_g16.xbmb.002.cam.h0.PHIS.192001-202912.nc","r")

Fout = addfile("b.e11.B20TRLENS_RCP85.f09_g16.xbmb.002.cam.h0.CAPE3D.192001-202912.nc","c")


hyam = FQ->hyam ; read from a file the mid-layer coef
  hybm = FQ->hybm ; read from a file
  ps   = FPS->PS   ; surface pressure [Pa]
  p0   = 100000 ; since ps is in Pa or [ f->P0]
  pres = pres_hybrid_ccm(ps,p0,hyam,hybm)
;print(dimsizes(ps))

    T=FT->T
    Q=FQ->Q
    Z=FZ->Z3
    topo = FTOP->PHIS
    PS=FPS->PS
;print(dimsizes(topo))
    cape3d = wrf_cape_3d(pres,T,Q,Z,topo,PS,False)
    cape = cape3d(0,:,:,:,:)
    Fout->cape=cape
  ;  Fout->time=FPS->time
  ;  Fout->lat=FPS->lat
   ; Fout->lon=FPS->lon






end

