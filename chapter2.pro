;+
;NAME:
;  chapter2.pro
;
;DESCRIPTION:
; This script will complete all of the exercises for chapter 2
;
;PARAMETERS:
; It is a .r script
;
;EXAMPLE:
;
;
;COMPILED PROGRAMS:
;
;  Buie Library:
;    minmax
;    quote
;    strn
;    showsrc
;
;AUTHOR:
;
;  Dave Borncamp - Space Telescope Science Institute
;
;HISTORY:
; 20131002 - DMB Created
;
;-

;dir='/Users/dborncamp/training/idl/'
;dir = '/Users/lockwood/idl_training/submissions/dborncamp/IDL-training/trunk/'
dir = '/user/lubeda/idl_training/data/'

;2.1
a=findgen(14)*.1+.1
print,'Exercise 2.1:'
print,a


;2.2
a=findgen(12)*.2-3.2
print,'Exercise 2.2'
print,a


;2.3
a=make_array(2,3,/integer,value=10)
print,'Exercise 2.3'
print,a


;2.4
a=make_array(3,3,/float,value=5)
b=make_array(3,3,/float,value=12)
print,'Exercise 2.4'
print,' a+b: '
print,a+b
print,' a/b: '
print,a/b
print,' a*b: '
print,a*b


;2.5
inva=a^(-1)
print,'Exercise 2.5'
print,'a*inverse of a: '
print,a*inva

; That was the numerical inverse of each element.
; To get the inverse array, use the invert() function.  Unfortunately, your array a is singular, 
; and hence not invertible.  I'm adopting a different matrix below.
; Then, calculate the A * A^-1 using array multiplication (# in IDL).
a = [[ 5.0, -1.0, 3.0], $
     [ 2.0, 0.0, 1.0], $
     [ 3.0, 2.0, 1.0]]
print, 'Exercise 2.5 revised:'
print, a # invert(a, /double)
; This is roughly equal to the identity matrix.


;2.6
a=randomn(1,1000)
z=where(a lt .5 and a gt -.5)
b=a[z]
print,'Exercise 2.6'
print,' print the minmax of the elements of the '+quote('other')+' array: '
print,minmax(b)

; This was not the goal of the exercise.  Please retry.

; Also, you can get literal single quotes directly:
print, 'There is a single quote '' here.'


;2.7
str='j123415678_flt.fits'
root=strmid(str,0,strlen(str)-5)
print,'Exercise 2.7'
print,'the root name is: '+root

; This is a convention issue.  I think the rootname would not include '_flt'.


;2.8
a=[1,6,3,4,7,5,2]
b=sort(a)
print,'Exercise 2.8'
print,' original array:'
print,a
print,' sorted array:'
print,a[b]


;2.9
a=randomn(10,1000)
result=moment(a)
print,'Exercise 2.9'
print,'  mean: ' , result[0]
print,'  variance: ', result[1]
print,'  skewness: ', result[2]
print,'  kurtosis: ', result[3]


;2.10
; Please add this input file to your repository.
file='/Users/dborncamp/training/idl/obs.dat'
readcol,file,obscode,lat,lon,elev,name,format='i,f,f,f,a',/silent
print,'Exercise 2.10 and 2.11'
forprint,obscode,name,lat,lon,elev


;2.12
print,'Exercise 2.12. '
print,'Both frames are there but you have to slpit them to see them simultanously'
spawn,'ds9 -frame 1 -fits /Users/dborncamp/training/archive/stis/o8j502280_raw.fits -frame 2 /Users/dborncamp/training/archive/stis/o8j5022a0_raw.fits &'
ans=''
read,ans,prompt='press enter to continue script '


;2.13
print,'Exercise 2.13'
print,' Yes I can:'
spawn,'/Applications/ds9/ds9 -multiframe /user/lubeda/idl_training/data/j91c12biq_flt.fits -blink yes -scale zscale &'
read,ans,prompt='press enter to continue script '


;2.14
print,'Exercise 2.14'
a=mrdfits(dir+'n8ws10siq_ima.fits',1)
sz=size(a)
print,'size is: '+strn(sz[1])+' x '+strn(sz[2])
; What are the various extensions?


;2.15
file='ib6w71lxq_flt.fits'
a=mrdfits(dir+file,4)
suba=a[2000:2699,700:1399]
print,'Exercise 2.15'
showsrc,suba,win=0  ; I couldn't get this working with these inputs!
read,ans,prompt='press enter to continue script '


;2.16
file='j91c12biq_flt.fits'
hdr=headfits(dir+file,exten=0)
print,'Exercise 2.16'
print,' read it in'


;2.17
file='ib6w71lxq_flt.fits'
hdr=headfits(dir + file,exten=0)
filter=sxpar(hdr,'FILTER')
bias=sxpar(hdr,'BIASCORR')
darkfile=sxpar(hdr,'DARKFILE')
gaind=sxpar(hdr,'ATODGND')

print,'Exercise 2.17'
print,' filter: '+strn(filter)
print,' bias corrected?: '+strn(bias)
print,' darkfile: '+strn(darkfile)
print,' gain for amp D: '+strn(gaind)


;2.18
a=intarr(10)
for i=0,9 do a[i]=i*i
print,'Exercise 2.18'
print,a


;2.19
a=strarr(4)
year='2001-0'
month='-01'
for i=0,3 do a[i]=year+strn(i+1)+month
print,'Exercise 2.19'
print,a


;2.20
file='uba3010em_c0f.fits'
a=mrdfits(dir+file)
sz=size(a)
print,'Exercise 2.20'

for i=0,sz[3]-1 do begin
   showsrc,a[*,*,i] ;showsrc is much better at displaying images
   read,ans,prompt='   please press enter to see next image '
;   wait,3
endfor   
; Still not getting showsrc working. Which version are you using?


;2.21
files=['ib3p11p7q_flt.fits',$
       'ib3p11p8q_flt.fits',$
       'ib3p11phq_flt.fits',$
       'ib3p11q9q_flt.fits']
print,'Exercise 2.21'       
print,'root  filter  target  time  date'
for i=0,n_elements(files)-1 do begin
   hdr=headfits(files[i])  ; Files from MAST retrieval
   root=strmid(files[i],0,strlen(str)-5)
   filter=sxpar(hdr,'FILTER')
   target=sxpar(hdr,'TARGNAME')
   time=sxpar(hdr,'TIME-OBS')
   date=sxpar(hdr,'DATE-OBS')

   print,root+'      '+filter+'  '+strn(target)+'  '+time+'  '+date
endfor   


;2.22
root = ["j12345678","u12345678","n12345678","i12345678","l12345678"]
id=strmid(root,0,1)

print,'Exercise 2.22'

for i=0,n_elements(id)-1 do begin
   case id[i] of
      'j':$
        print,' j - Advanced Camera for Surveys'
      ;break
   
      'u':$
        print,' u -Wide Field/Planetary Camera-2'
      ;break
   
      'n':$
         print,' n - Near Infrared Camera and Multi-Object Spectrograph'
     ; break
   
      'i':$
         print,' i - Wide Fild camera 3'
      ;break
   
      'l':$
         print,' l - Cosmic Origins Spectrograph'
     ; break
   endcase
endfor


;2.23
print,'Exercise 2.23'
print,circle_area(5)
; Area is wrong.  !pi*r^2, not 2*!pi*r^2


;2.24
print,'Exercise 2.24'
print,'points: ',[1.,1.],[2.,2.]
print,intslop([1.,1.],[2.,2.])
; Test the vertical line case...
print,'points: ',[1.,1.],[1.,2.]
print,intslop([1.,1.],[1.,2.])

end
