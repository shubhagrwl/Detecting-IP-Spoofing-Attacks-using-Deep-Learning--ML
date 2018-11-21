dta=[];
cntrp=0;
for i=1:60
    dta{i,1}=i;
    dta{i,2}=strcat('180.23.32.',num2str(round(100*rand)));
    ks=randint(1);
    if ks==1
       dta{i,3}='UDP'; 
        
    else
        dta{i,3}='TCP';
    end
    cntrp=cntrp+1;
    if cntrp==5
       dta{i,3}='ICMP'; 
        
    end
    dta{i,4}=round(1000*rand);
    
end
xlsappend('kddcup.xlsx',dta);
msgbox('Done');