;+
;This is for exercise 2.24 of the IDL training packet.
;It requires badpar from the buie library
;
;INPUTS:
;   p - 2 element 1 d array for a point [x,y] can be integer, float or double.
;   q - 2 element 1 d array for a point [x,y] can be integer, float or double.
;
;OUTPUTS:
;   Returns a 2 element 1-d array that contains [slope,y-intercept]
;   Will return infinate slope and nan xy intercept for points with infinate 
;   slope.
;
;   Will return -1 on incorrect input or errors.
;
;Dave Borncamp - STScI - 20131002 
;-
function intslop,p,q
   self=' intslop '

   ;some error checking, I need a 2 element array before I can continue
   if badpar(p,[2,3,4,5],1,CALLER=self+'p ',npts=ppts) then return,-1
   if badpar(q,[2,3,4,5],1,CALLER=self+'q ',npts=qpts) then return,-1
   
   if ppts ne 2 then begin
      print,'need 2 element array in'+self+'p'
      return,-1
   endif   
   if qpts ne 2 then begin
      print,'need 2 element array in'+self+'q'
      return,-1
   endif   
   
   ;get the slope
   rise=p[1]-q[1]
   run=p[0]-q[0]
   
   ;infinate slope returns nothing
   if run eq 0 then return,[!VALUES.F_INFINITY,!VALUES.F_NAN]
   
   slope=rise/run
   
   ;get the y-intercept
   ;y=mx+b ;b=y-mx
   b=p[1]-(slope*p[0])
   
   return,[slope,b]

end
