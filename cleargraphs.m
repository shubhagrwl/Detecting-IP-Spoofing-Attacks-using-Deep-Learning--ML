function [] = cleargraphs(x,y,s,d,itr)
%CLEARGRAPHS Summary of this function goes here
%   Detailed explanation goes here
figure(1);
identites=numel(x);
cla;
title(strcat('ITR NO:',num2str(itr)));
plot(x,y,'bo');
for i=1:identites
   hold on;
   text(x(i)+2,y(i)+2,strcat('I',num2str(i)));
   
end

%[s,d]=generatesourcedestination(nd);
hold on;
plot(x(s),y(s),'go','linewidth',2);
hold on;
text(x(s)+5,y(s)+5,'SOURCE');


plot(x(d),y(d),'go','linewidth',2);
hold on;
text(x(d)+5,y(d)+5,'DESTINATION');

end

