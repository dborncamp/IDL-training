;+
;chapter 4 scripts
;
;Requires buie library
;
;Dave Borncamp 20131003

dir='/Users/dborncamp/training/idl/'

;4.1
file='j8hm01xaq_flt.fits'
hdr0=headfits(dir+file,exten=0)
extensions=sxpar(hdr0,'NEXTEND')

hdr1=headfits(dir+file,exten=1)
sx=sxpar(hdr1,'NAXIS1')
sy=sxpar(hdr1,'NAXIS2')

print,'Exercise 4.1'
print,' Number of extensions: '+strn(extensions)
print,' Size of image: '+strn(sx)+' x '+strn(sy)


;4.2
created=sxpar(hdr0,'DATE')
pi_last=sxpar(hdr0,'PR_INV_L')
pi_first=sxpar(hdr0,'PR_INV_F')
exptime=sxpar(hdr0,'EXPTIME')
print,'Exercise 4.2'
print,' Created on: '+created
print,' PI is '+strn(pi_first)+' '+strn(pi_last)
print,' Exposure time is '+strn(exptime)


;4.3
img=mrdfits(dir+file,4,hdr,/silent)
sub=img[900:1399,800:1299]

avgfwhm=2 ;from tutorial
find,sub,xc,yc,flux,sharp,roundness,60,avgfwhm,[-1,1],[.2,1.],/silent
setwin,0,/show
showsrc,sub,win=0;,lowsig=1,hisig=40
oplot,xc,yc,psym=4,color=2000,symsize=2

;tvgrab,'photometry_02.jpg',0
;I could not get X to dump what was on the graphics window properly using tvrd. 
;I am talking with IT about it. 

;4.4
print,'Exercise 4.4'
print,' A flag is setting a variable to 0 or 1 in the call to the program.'
print,' If you ommit this then most programs will assume it is =0'


;4.5
;At firstI could not get aper to work wothout crashing and I did not 
;understand what the apr variable is so I used something else:
;findsrc,sub,results=results,/nodisplay,/silent,gap=5,sigthresh=10
;basphote,1.0,sub,exptime,xc,yc,avgfwhm*1.5,5,$
;   8,/nolog,xcen=newx,ycen=newy,flux=newflux,fwhm=newfwhm,/silent,$
;   mag=mag,err=magerr,boxmrad=5,flerr=flerr,calcfwhmsize=objrad,$
;   skymean=skymean,skyerr=skyerr

aper,sub,xc,yc,flux,fluxerr,sky,skyerr,1,3,[5,8],[0,0],/silent,/flux

print,'Exercise 4.5'
print,'           x          y         flux        magerr       skymean       skyerr'

forprint,xc,yc,flux,fluxerr,sky,skyerr


;4.6
setwin,1,xsize=700,ysize=700
plot,flux,fluxerr,/nodata,title='4.6',xtitle='Flux',ytitle='Flux Error',$
   charsize=2
oplot,flux,fluxerr,psym=8,color='ff0000'xl



end
