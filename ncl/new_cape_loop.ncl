;***************************************************
; New CAPE file
; Usw pres_ccm_hybrid within script to handle pressure levs? Is what Gabe said? 
; Shay Magahey 03/09/2023
; **********************************************************

begin
do i = 2,15
FT = addfile("/glade/campaign/cesm/collections/cesmLE/CESM-CAM5-BGC-LE/atm/proc/tseries/monthly/T/b.e11.B20TRC5CNBDRD.f09_g16."+sprinti("%0.3i",i)+".cam.h0.T.192001-200512.nc","r")

FQ = addfile("/glade/campaign/cesm/collections/cesmLE/CESM-CAM5-BGC-LE/atm/proc/tseries/monthly/Q/b.e11.B20TRC5CNBDRD.f09_g16."+sprinti("%0.3i",i)+".cam.h0.Q.192001-200512.nc","r")
FZ = addfile("/glade/campaign/cesm/collections/cesmLE/CESM-CAM5-BGC-LE/atm/proc/tseries/monthly/Z3/b.e11.B20TRC5CNBDRD.f09_g16."+sprinti("%0.3i",i)+".cam.h0.Z3.192001-200512.nc","r")
FPS = addfile("/glade/campaign/cesm/collections/cesmLE/CESM-CAM5-BGC-LE/atm/proc/tseries/monthly/PS/b.e11.B20TRC5CNBDRD.f09_g16."+sprinti("%0.3i",i)+".cam.h0.PS.192001-200512.nc","r")
FTOP = addfile("/glade/campaign/cesm/collections/cesmLE/CESM-CAM5-BGC-LE/atm/proc/tseries/monthly/PHIS/b.e11.B20TRC5CNBDRD.f09_g16."+sprinti("%0.3i",i)+".cam.h0.PHIS.192001-200512.nc","r")

Fout = addfile("/glade/u/home/smagahey/workdir/jupyter/cape/b.e11.B20TRC5CNBDRD.f09_g16."+sprinti("%0.3i",i)+".cam.h0.CAPE3D.192001-200512.nc","c")


hyam = FQ->hyam ; read from a file the mid-layer coef
  hybm = FQ->hybm ; read from a file
  ps   = FPS->PS   ; surface pressure [Pa]
  p0   = 100000. ; since ps is in Pa or [ f->P0]
  pres = pres_hybrid_ccm(ps,p0,hyam,hybm)


    T=FT->T
    Q=FQ->Q
    Z=FZ->Z3
    topo = FTOP->PHIS
    PS=FPS->PS

    cape3d = wrf_cape_3d(pres,T,Q,Z,topo,PS,False)
    cape = cape3d(0,:,:,:,:)
    Fout->cape3d=cape3d
 ;   Fout->time=Fin->time
  ;  Fout->lat=Fin->lat
   ; Fout->lon=Fin->lon





end do
end
