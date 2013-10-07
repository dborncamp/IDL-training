;Dave Borncamp
;everything for chapter 3 is here
;
;requires buie library
;

;dir='/Users/dborncamp/training/idl/'
dir = '/user/lubeda/idl_training/data/'

goto, skip

;3.1
x=findgen(80)
y=exp(x)*x^(-2)

set_plot,'ps'
device,filename='3_1.ps',/portrait,decompose=1,color=1
plot,x,y,/ylog,xtitle='x',ytitle='exp(x)*x^(-2)  in log',charsize=2,$
   title='3.1',/nodata
oplot,x,y,color='0000ff'xl
device,/close
cgps2pdf,'3_1.ps'


;3.2

set_plot,'x'
x=findgen(100)/10
plot,x,x,xr=[0,10],/nodata,xtitle='x',ytitl='y',title='3.2',charsize=2
oplot,x,x,psym=4
oplot,x,x^2-x+1,psym=5
oplot,x,x^3-x^2+1,psym=8  ; Must use usersym first for psym=8
xyouts,6,1.75,'Diamond = x',charsize=2
xyouts,6,1.5,'Triangle = x^2-x+1',charsize=2
xyouts,6,1.25,'Circle = x^3-x^2+1',charsize=2
xyouts,6,1,'Intercept at 1,1',charsize=2
; Check out psym=cgsymcat(...)


;3.3
file='ngc4214_336.dat'
readcol,dir+file,mag,dummy,dummy,format='f,f,f',/silent
setwin,1,xsize=700,ysize=700
stats,mag,/silent,nbins=200,window=1
; How would you directly set the histogram bin size?


;3.4
file='m101_blue.fits'
img=mrdfits(dir+file,0,hdr)
sz=size(img,/dimen)

print,'Yes I can'
window,2,xsize=sz[0],ysize=sz[1]
contour,img,c_colors=['ff0000'xl,'00ff00'xl,'0000ff'xl],title='3.4'



end
