function [cov_set] = find_cov_limit(x,y,ident,width)
%FIND_COV_LIMIT Summary of this function goes here
%   Detailed explanation goes here
lamda=width*28/100;
for i=1:ident
    count=1;
   for j=1:ident
      if i~=j
          dist=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
          if dist<lamda
            cov_set(i,count)=j;
            count=count+1;
          end
      end
       
   end
    
end

end

