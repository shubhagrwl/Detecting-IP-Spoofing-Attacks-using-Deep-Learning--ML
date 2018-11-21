clc; % this is to clear the previous screen 
clear all; %%% to clear reference variables
close all; %%% to close previous windows

%identites=input('Enter total number of desired nodes :'); %%%% input command is to take input from the user 
[s,t,data]=xlsread('kddcup.xlsx');
[r,c]=size(data);
identites=r;
save('kdddata','data');
nd=identites;
shubhamnet.width=1000;
throughput=[];
allpath=[];
pdr=[];
energyconsumption=[];
total_packets=1000;

shubhamnet.height=1000;
totalitr=10;
throughput=zeros(1,totalitr);
pdr=zeros(1,totalitr);
energyconsumption=zeros(1,totalitr);
tic;
for itr=1:totalitr
    
[residual_energy,econn,econd,pdropn,pdropd,x,y]=generatenodeprop(identites); 
econn=data{:,6};
[r,c]=size(data);
for i=1:r
   econn(i)=data{i,5}; 
end
figure(1);
cla;
title(strcat('ITR NO:',num2str(itr)));
plot(x,y,'bo');
hold on;
for i=1:identites
   hold on;
   text(x(i)+2,y(i)+2,strcat('N',num2str(i)));
   
end
pause(.25);
[s,d]=generatesourcedestination(nd);
hold on;
plot(x(s),y(s),'go','linewidth',2);
hold on;
text(x(s)+5,y(s)+5,'SOURCE');

plot(x(d),y(d),'go','linewidth',2);
hold on;
text(x(d)+5,y(d)+5,'DESTINATION');
shubhamnet.cov_set=find_cov_limit(x,y,identites,shubhamnet.width);
allcov=shubhamnet.cov_set;
s_cov=allcov(s,:);
for n=1:numel(s_cov)
figure(1);
hold on;
if s_cov(n)~=0
   plot(x(s_cov(n)),y(s_cov(n)),'go','linewidth',2);
   xx=[x(s) x(s_cov(n))];
   yy=[y(s) y(s_cov(n))];
     line(xx,yy,'Color','g');
pause(.025);    
end


end
findd=find(s_cov==d);
route=[];
route(1)=s;
count=2;

if isempty(findd)
   title('Routing is required'); 
   cleargraphs(x,y,s,d,itr)
   counter=0;
   dest_found=0;
   current_node=s;
   while counter<10 && dest_found==0
      current_cov=allcov(current_node,:);
      next_route_element=current_cov(1);
      ks=find(route==next_route_element);
      if isempty(ks)
          nxt_cov=allcov(next_route_element,:);
          gh=find(nxt_cov==d);
          if ~isempty(gh)
             route(numel(route)+1)=next_route_element;
             route(numel(route)+1)=d;
             dest_found=1;
          else
              route(numel(route)+1)=next_route_element;
              counter=counter+1;
              current_node=next_route_element;
              
          end
          
      else
          counter=counter+1;
      end
       
   end
   if dest_found==0
       
      route(numel(route)+1)=d; 
   end
   for bh=1:numel(route)-1
       figure(1)
       hold on;
      xx=[x(route(bh)) x(route(bh+1))];
      yy=[y(route(bh)) y(route(bh+1))];
      line(xx,yy,'Color','g');
      pause(.25)
       
   end
   
   %%%%%% implementing the attacker side %%%%%
  
for ty=1:numel(route)
   allpath(itr,ty)=route(ty); 
    
end
end
   attacker_x=1000*rand;
   attacker_y=1000*rand;
   for ki=1:10
      s=randint(1);
      if s==1
        for ui=1:10
           affected_node_pos=round(numel(route)*rand);
           if affected_node_pos==0
               try
              affected_node=route(2); 
               catch
                   affected_node=route(1)
               end
           else
               affected_node=route(affected_node_pos);
           end
           
           hold on;
           plot(attacker_x,attacker_y,'bo','linewidth',ki+7);
           xx1=[attacker_x x(affected_node)];
           yy1=[attacker_y y(affected_node)];

           line(xx1,yy1,'Color','r','linewidth',ki/2);
           title('SPOOFING')
           pause(.025);
           pdr(itr)=((pdr(itr)+(total_packets-(pdropd(affected_node)+pdropn(affected_node)))/total_packets)/ui)/itr;
           throughput(itr)=(throughput(itr)+(total_packets-(pdropd(affected_node)+pdropn(affected_node)))/toc)/ui;
           energyconsumption(itr)=energyconsumption(itr)+(econn(affected_node)+econd(affected_node));
        end
      else
      pdr(itr)=((pdr(itr)+(total_packets-sum(pdropn(route)))/total_packets))/itr;
           throughput(itr)=(throughput(itr)+(total_packets-sum(pdropn(route)))/toc);
           energyconsumption(itr)=energyconsumption(itr)+sum(econn(route));
      end
      
       
   end
   
   
end

save networkproperties
prevention;    

