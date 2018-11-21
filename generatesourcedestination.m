function [s,d] = generatesourcedestination(identities)
%GENERATESOURCEDESTINATION Summary of this function goes here
%   Detailed explanation goes here
s=round(identities*rand);
d=round(identities*rand);
if s==0
   s=1; 
end
if d==0
   d=2; 
end

end

