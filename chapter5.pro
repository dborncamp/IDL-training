;Chapter 5 script
;
;
;Dave Borncamp 100413


;dir='/Users/dborncamp/training/idl/'
dir = '/user/lubeda/idl_training/data/'

;5.1
file='ngc4151_hband.fits'
hdr=headfits(dir+file)
exten=sxpar(hdr,'EXTEND')
cube=readfits(dir+file,hdr1,exten=exten)

print,'Exercise 5.1'
print,' This file has 2 extenstions with dimensions:'
help,cube
; Actually, it has three dimensions.


;5.2
crpix1 = sxpar(hdr1, "CRPIX1")
cdelt1 = sxpar(hdr1, "CDELT1")
crval1 = sxpar(hdr1, "CRVAL1")
cunit1 = sxpar(hdr1, "CUNIT1")
crpix2 = sxpar(hdr1, "CRPIX2")
cdelt2 = sxpar(hdr1, "CDELT2")
crval2 = sxpar(hdr1, "CRVAL2")
cunit2 = sxpar(hdr1, "CUNIT2")
crpix3 = sxpar(hdr1, "CRPIX3")
cdelt3 = sxpar(hdr1, "CDELT3")
crval3 = sxpar(hdr1, "CRVAL3")
cunit3 = sxpar(hdr1, "CUNIT3")
pscale = sxpar(hdr1, "PIXSCALE")

;dimen 1 & 2 - spatial deminsions
sz=size(cube,/dimen)
xpixel=findgen(sz[0])
ypixel=findgen(sz[1])
x=crval1+(xpixel-crpix1)*cdelt1   ;location of ra in degrees
y=crval2+(ypixel-crpix2)*cdelt2   ;location of dec in degrees


;dimen3 - wavelength space
pixel=findgen(sz[2])+1   ;"one for each wavelength"
lamda=crval3+(pixel-crpix3)*cdelt3  ;in A   (Lambda)

print,'Exercise 5.2'
print,' The units are given in degrees'


;5.3
;Im not sure if I'm expected to make the ps plots, so I will just show 1 of them
plot,lamda[100:2000],cube[30,30,70:2000],/nodata,xtitle='wavelength in A',$
   ytitle='counts',title='NGC4151 IR Spectra',xrange=minmax(lamda[100:2000])
oplot,lamda[100:2000],cube[30,30,70:2000],color='0000ff'xl
; What wavelength are you plotting?

print,'Exercise 5.3'
print,' The wavelength range of this cube is '+strn(minmax(lamda))+' microns as calculated from the header'


end
