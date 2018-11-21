tic;
load networkproperties.mat
allaffected_nodes=[];
allcount=1;
for i=1:totalitr
   target(i)=i; 
end
training_data_phase1=energyconsumption;
%%%%%% initializing neural network %%%%%
net=newff(energyconsumption,target,25);
net.trainparam.epochs=50;
net=train(net,energyconsumption,target);
testdata=training_data_phase1;
resultroute=round(sim(net,testdata));
diff=resultroute-target;
counter=1;
for i=1:numel(diff)
   if diff(i)~=0
      affected_path(counter)=target(i); 
      counter=counter+1;
   end
    
end
[r,c]=size(allpath);
for i=1:numel(affected_path)
   currentpath=allpath(affected_path(i),1:c);
   cpath=[];
   ccount=1;
   for j=1:numel(currentpath)
      if currentpath(j)~=0
          
         cpath(ccount)=currentpath(j);
         ccount=ccount+1;
      end
       
   end
   trainingcpath=[];
   trainingcpath=econn(cpath)+econd(cpath);
   targetcpath=[];
   targetcpath=cpath;
   net1=newff(trainingcpath,targetcpath,10);
   net1.trainparam.epochs=50;
   net1=train(net1,trainingcpath,targetcpath);
   resa=round(sim(net1,trainingcpath));
   beepop=numel(resa);
   beefoodsource=resa;
   for ksa=1:beepop
      employed_bee=resa(ksa);
      employed_bee_food=trainingcpath(ksa);
      onlooker_bee_food=mean(trainingcpath);
      beefitv=beefit(employed_bee_food,onlooker_bee_food);
      if beefitv==1
         resa(ksa)=targetcpath(ksa);; 
      end
   end
   figure(3)
   plotroc(targetcpath,resa);
   title(strcat('Affected Validation for path no :',num2str(affected_path(i))));
   diff1=resa-targetcpath;
   for n=1:numel(diff1)
      if diff1(n)~=0
         allaffected_nodes(allcount)=targetcpath(n);
         allcount=allcount+1;
      end
       
   end
   
    
end
allcount=[];

for i=1:identites
   s=find(allaffected_nodes==i);
   if ~isempty(s)
       allcount(i)=numel(s);
   else
       allcount(i)=0;
   end
    
end
    
[maxval,pos]=max(allcount);
final_affected=pos;
pdri=[];
throughputi=[];
energyconsumptioni=[];
for itr=1:totalitr
           pdri(itr)=(pdr(itr)+(((total_packets-(pdropn(final_affected)))/total_packets)/10)/itr);
           throughputi(itr)=throughput(itr)+((total_packets-(pdropn(final_affected)))/toc)/10;
           energyconsumptioni(itr)=energyconsumption(itr)-(econn(affected_node)+econd(final_affected));

end
allcount1=[];
allcount1=zeros(1,numel(allcount));
datamal=[];
load kdddata;
for i=1:numel(allcount)
    if allcount(i)>0
       allcount1(i)=1; 
    end
    datamal(i)=data{i,6};
end

figure(2);

subplot(131);
hold on;
plot(1:itr,pdr(1:itr),'k*-','linewidth',1);
hold on;
plot(1:itr,pdri(1:itr),'m*-','linewidth',1);
xlabel('Number of Iterations');
ylabel('PDR');
legend('With SPOOFING','After Prevention')


figure(2);

subplot(132)
plot(1:itr,throughput(1:itr),'r*-','linewidth',1);
hold on;
plot(1:itr,throughputi(1:itr),'m*-','linewidth',1);
xlabel('Number of Iterations');
ylabel('Throughput in Packets/timeframe');
legend('With Spoofing','After Prevention')

figure(2);

subplot(133)
plot(1:itr,energyconsumption(1:itr),'g*-','linewidth',1);
hold on;
plot(1:itr,energyconsumptioni(1:itr),'m*-','linewidth',1);
xlabel('Number of Iterations');
ylabel('Energy Consumption in mj');
legend('With Spoofing','After Prevention')
    
figure,
plotroc(datamal,allcount1);
title('KDD CUP DATA MALICIOUS VS NN PREDICTION');


