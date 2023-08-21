begin

Ft =  addfile("/glade/u/home/smagahey/workdir/LENS/levp_controls/b.e11.20TRC5CNBDRD.f09_g16.lev_p.001.cam.h0.T.185001-200512.nc","r")
Fq = addfile("/glade/u/home/smagahey/workdir/LENS/levp_controls/b.e11.20TRC5CNBDRD.f09_g16.lev_p.001.cam.h0.Q.185001-200512.nc","r")
Fps = addfile("/glade/u/home/smagahey/workdir/LENS/levp_controls/b.e11.B20TRC5CNBDRD.f09_g16.001.cam.h0.PS.185001-200512.nc","r")
setfileoption("nc","Format","NetCDF4Classic")
Fout = addfile("b.e11.20TRC5CNBDRD.f09_g16.lev_p.001.cam.h0.eq_pottemp.185001-200512.nc","c")

T=Ft->T
lev_p = fspan(1000,50,20)
PS=Fps->PS
Q=Fq->Q
dim = 1

theta_e = pot_temp_equiv(lev_p,T,Q,dim,"q")

Fout->T=theta_e
Fout->lev_p=lev_p
Fout->time=Ft->time
Fout->lat=Ft->lat
Fout->lon=Ft->lon

end
