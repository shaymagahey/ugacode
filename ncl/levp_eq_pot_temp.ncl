begin


;do i = 1,15
;********************************************************
; Define input files for eq pot temp and lev_p
; **********************************************

;print("Starting loop"+sprinti("%0.3i",i))

FT = addfile("/glade/campaign/cesm/collections/cesmLE/CESM-CAM5-BGC-LE/atm/proc/tseries/monthly/T/b.e11.B20TRC5CNBDRD.f09_g16.001.cam.h0.T.185001-200512.nc","r")

FQ = addfile("/glade/campaign/cesm/collections/cesmLE/CESM-CAM5-BGC-LE/atm/proc/tseries/monthly/Q/b.e11.B20TRC5CNBDRD.f09_g16.001.cam.h0.Q.185001-200512.nc","r")


Fps = addfile("/glade/campaign/cesm/collections/cesmLE/CESM-CAM5-BGC-LE/atm/proc/tseries/monthly/PS/b.e11.B20TRC5CNBDRD.f09_g16.001.cam.h0.PS.185001-200512.nc","r")

print("Input files read in")
;*****************************************************

setfileoption("nc","Format","NetCDF4Classic")

 Fout = addfile("b.e11.B20TRC5CNBDRD.f09_g16.001.cam.h0.thetaE.185001-200512.nc.nc","c")
  
 print("Output Files Set")
  
; define files first, then get variables

; ****************************************************************
; Variables, functions
; ***************************************************************

    Tin=FT->T
    Qin=FQ->Q
    hyam=FT->hyam
    hybm=FT->hybm
    lev_p = fspan(1000,50,20)
    PS=Fps->PS

    print("Input Variables read")

    Tout = vinth2p(Tin,hyam,hybm,lev_p,PS,1,1000,1,False)
    Qout = vinth2p(Qin,hyam,hybm,lev_p,PS,1,1000,1,False)
    
    print("vinth2p function run")
    
; define the variables, create some, set to output file
; how to do levp then equivalent potential temperature
; ERR AT LINE 47
    theta_e = pot_temp_equiv(lev_p,Tout,Qout,1,"q")
    
   ; Fout->T=FT
   ; Fout->Q=FQ
    Fout->theta_e=theta_e
    Fout->lev_p=lev_p
    Fout->time=FT->time
    Fout->lat=FT->lat
    Fout->lon=FT->lon
    
;   print("End of loop"+sprinti("%0.3i",i))
;end do

end


