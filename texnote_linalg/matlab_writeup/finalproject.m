% Part A: Computation
calc_cdi(100,0.05,5.5,2,1); %We can suppose there are 2 compounding periods per year, according to part C
calc_cci(100,0.05,5.5,1);

% Part B: Take in r, t as vectors. (Compute, for a given r and t the final value assuming initial value is 1)
% The output for final value for every interest rate against every timeperiod is suppresed

v_r = linspace(-5, 20, 26).*0.01;
v_t = linspace(1, 120).*0.5;
m = zeros(length(v_r), length(v_t));
for i = 1:length(v_r)
  for j = 1:length(v_t)
    calc_cdi(1, v_r(i), v_t(j), 2, 0); %to unsuppress output, just set the last parameter (0) to 1
    calc_cci(1, v_r(i), v_t(j),0); %to unsuppress output, just set the last parameter (0) to 1
    m(i,j) = calc_cci(1, v_r(i), v_t(j),0);
  end
end

%Part C: Produce a plot of the payoff of one dollar at 8% interest per year, with continuous and discrete compounding, for maturities of one to 35 years, in steps of 6 months.

%discrete time
grid on
hold all
m_int = 2;
dcr_t = linspace(0,35, 1000);
dcr_val = (1.+0.08/m_int).^(m_int.*floor(2*dcr_t)./2); %flooring the twice the value is like rounding down to a half. it's not super elegant but it works.
plot(dcr_t, dcr_val, 'r-');
%continuous time
syms cont_t
fplot(1*exp(0.08*cont_t),[0 35])

xlabel ('Time [Years]')
ylabel('Value of Investment over Time [$]')
legend ('Discretely Updating Compound Interest', 'Continously Updating Compound Interest')
title('Discretly vs Continously Evaluated Compound Interest')
% axis([0,35,0,100])






%todo
% - might want a two 3d plots of T, R and CDI/CCI
% - input
%function declarations
%print compounded discrete interest
function cdi = calc_cdi(vi, r,t,m, b_print) %bprint gives
    cdi = vi*(1+r/m)^(m*t);
    if(b_print == 1) %print iff specified by final param
      sprintf('Compounded discrete interest \nwith rate %f pct \n with %d periods per year \n for %f years \n with initial investment %f is \n %f',  r*100, m, t, vi, cdi)
    end
end

%print compounded continuous interest
function cci = calc_cci(vi, r, t, b_print)
   cci = vi * exp(r*t);
   if(b_print == 1)
      sprintf('Compounded continuous interest \nwith rate %f pct \nfor %f years\nwith initial investment %f \nis %f',  r*100, t, vi, cci)
  end
end
