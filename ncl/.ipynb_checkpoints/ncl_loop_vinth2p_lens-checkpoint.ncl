begin

do i = 2,15
;    Fin = addfile("/glade/campaign/cesm/collections/cesmLE/CESM-CAM5-BGC-LE/atm/proc/tseries/monthly/VQ/b.e11.B20TRC5CNBDRD.f09_g16."+sprinti("%0.3i",i)+".cam.h0.VQ.192001-200512.nc","r")
    
      Fin = addfile("/glade/campaign/cesm/collections/cesmLE/CESM-CAM5-BGC-LE/atm/proc/tseries/monthly/UQ/b.e11.B20TRLENS_RCP85.f09_g16.xbmb."+sprinti("%0.3i",i)+".cam.h0.UQ.192001-202912.nc","r")
     
;    Fps = addfile("/glade/campaign/cesm/collections/cesmLE/CESM-CAM5-BGC-LE/atm/proc/tseries/monthly/PS/b.e11.B20TRC5CNBDRD.f09_g16."+sprinti("%0.3i",i)+".cam.h0.PS.192001-200512.nc","r")
   
 Fps = addfile("/glade/campaign/cesm/collections/cesmLE/CESM-CAM5-BGC-LE/atm/proc/tseries/monthly/PS/b.e11.B20TRLENS_RCP85.f09_g16.xbmb."+sprinti("%0.3i",i)+".cam.h0.PS.192001-202912.nc","r")  
 
    setfileoption("nc","Format","NetCDF4Classic")
    
;  Fout = addfile("/glade/scratch/smagahey/UQVQ_files/b.e11.B20TRC5CNBDRD.f09_g16.lev_p."+sprinti("%0.3i",i)+".cam.h0.VQ.192001-200512.nc","c")
   
   Fout = addfile("/glade/scratch/smagahey/UQVQ_files/b.e11.B20TRLENS_RCP85.f09_g16.xbmb.lev_p."+sprinti("%0.3i",i)+".cam.h0.UQ.192001-202912.nc","c")

    Tin=Fin->UQ
    hyam=Fin->hyam
    hybm=Fin->hybm
    lev_p = fspan(1000,50,20)
    PS=Fps->PS

    Cout = vinth2p(Tin,hyam,hybm,lev_p,PS,1,1000,1,False)

    Fout->UQ=Cout
    Fout->lev_p=lev_p
    Fout->time=Fin->time
    Fout->lat=Fin->lat
    Fout->lon=Fin->lon
end do

end
