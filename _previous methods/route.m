function xy = route(mat, source, dest)

xy = source;

for row=1:r
     col=list(1 + floor(rand() * length(list)));
     l1=col-1;
     l2=col+1;
     if l1<1
         l1=1;
     end
     if l2>c
         l2=c;
     end
     list=l1:l2;
       mat(row,col)
  end