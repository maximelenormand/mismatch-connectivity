# thot takes as input a distribution of value and returns the LouBar value (intersection between the tangent of the Lorentz curve at point (1,1) and the x-axis)
thot=function(p){ 

  # Sort the distribution
  p=sort(p)
  n=length(p)

  # Lorentz curve
  x=(1:n)/n
  y=cumsum(p)/sum(p)

  # Intersection between the tangent of the Lorentz curve at point (1,1) and the x-axis
  thx=1-1/((y[n] - y[n-1]) / (x[n] - x[n-1]))

  # Associated value
  thy=p[which(x>=thx)[1]]

  return(thy)

}



# hthot apply iteratively maxh time the function thot defined above on a distribution of value 
hthot=function(p,maxh){

  th=thot(p)
  p=p[p<th]
  nb=1
  while(nb<maxh){
  
    th=c(th,thot(p))
    p=p[p<th[length(th)]]
    nb=nb+1  

  }

  return(th)

}

