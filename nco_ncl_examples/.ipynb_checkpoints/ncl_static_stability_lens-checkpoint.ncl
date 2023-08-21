begin

Fin = addfile("/glade/u/home/smagahey/workdir/LENS/BMB/b.e11.B20TRLENS_RCP85.f09_g16.001.cam.h0.xbmb.T.lev_p.192001-200512.nc","r")
setfileoption("nc","Format","NetCDF4Classic")
Fout = addfile("b.e11.B20TRC5CNBDRD.f09_g16.001.stab_factors.cam.h0.xbmb.T.lev_p.192001-202912.nc","c")

Tin=Fin->T
lev_p = fspan(100000,5000,20)

s1 = static_stability(lev_p,Tin,1,1)
Fout->T=s1
Fout->lev_p=lev_p
Fout->time=Fin->time
Fout->lat=Fin->lat
Fout->lon=Fin->lon

end
