function [i_r_energy,i_e_c_n,i_e_c_d,i_p_d_n,i_p_d_d,x,y] = generatenodeprop(i_count)
%GENERATEIDENTITYPROP Summary of this function goes here
%   Detailed explanation goes here
for i=1:i_count
i_r_energy(i)=200*rand;
i_e_c_n(i)=20*rand;
i_e_c_d(i)=50*rand;
i_p_d_n(i)=30*rand;
i_p_d_d(i)=100*rand;
x(i)=1000*rand;
y(i)=1000*rand;

end
end

