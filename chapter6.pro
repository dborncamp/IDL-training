;Chapter 6 scripts
;
;
;Dave Borncamp 131004

;dir='/Users/dborncamp/training/idl/'
dir = '/user/lubeda/idl_training/data/'

;6.1 & 6.2
file='hubble.dat'
readcol,dir+file,dist,vel,format='f,f'

fit=linfit(dist,vel,sigma=sig,chisq=chisq,prob=prob,yfit=yfit)
setwin,0,xsize=700,ysize=500
plot,dist,vel,/nodata,xtitle='Distance in Mpc',ytitle='Velocity in km/sec',$
   title='hubbles law',charsize=1.5
oplot,dist,vel,psym=4,color='ff0000'xl
oplot,dist,yfit,color='0000ff'xl

print,'Exercise 6.1'
print,' Hubble constant: '+strn(fit[0])+' km/(sec*Mpc)'
; What's the error in the slope?  Take a look at your sig variable...


;6.3
file='o5bn02010_x1d.fits'
spc=mrdfits(dir+file,1,hdr)
wave=spc.wavelength
flux=spc.flux

i=sort(wave)
swave=wave[i]
sflux=flux[i]

;to whoever is reading this, this is an interesting way to look at the spectrum:
;setwin,0,xsize=1200,ysize=1000
;plot,swave,sflux,yrange=[-1e-13,1e-13],psym=3

; Yep. This is a photon-counting detector (STIS FUVMAMA), so you are seeing quantized levels
; of photons within each wavelength bin.  The reason the quantized levels change shape is due
; to our calibrations attempting to flatten-out the detection sensitivity as a function of
; wavelength.  Take a look at the .net spectrum to remove this calibration.

scl_flux=sflux/1e-13
wline=swave[34610:34900]
fline=scl_flux[34610:34900]
fit=gaussfit(wline,fline,coeff,nterms=3)

print,'fwhm is:',2*SQRT(2*ALOG(2))*coeff[2]

setwin,1,xsize=700,ysize=500
plot,wline,fline,title='Gaussian fit',xtitle='Wavelength in A',ytitle='flux'
oplot,wline,fit,color='0000ff'xl
; Vertical line, like Fig 3.5?


end
