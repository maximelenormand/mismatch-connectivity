# Compute the ratio between the sum of the tri-diagonal trace of a matrix and the sum of the matrix
phi=function(M){
 
   n=dim(M)[1]
   m=dim(M)[2]

   if(n!=m){
       print("YOUR MATRIX IS NOT SQUARE!!!")
   }else{

       phi=0
       for(i in 1:n){ 
           if(i==1){
              phi=phi+M[1,1]+M[1,2]
           }
           if(i==n){
              phi=phi+M[n,n]+M[n,(n-1)]
           }
           if(i>1 & i<n){
              phi=phi+M[i,i]+M[i,(i-1)]+M[i,(i+1)]
           }
       }

       phi=phi/sum(M)

       return(phi)
   }

}









