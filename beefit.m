function [f] = beefit(emp,onl)
%BEEFIT Summary of this function goes here
%   Detailed explanation goes here
f=0;
nature_change=rand;
if emp*nature_change<onl*nature_change
   f=1; 
end

end

