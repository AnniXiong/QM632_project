% gausspotential.m%% Script to solve the shrodinger equations of motion, % implenting eigen Energy solver is under construction%%    Vx = -A*exp((-x^2)/(w^2));%    Dxpsi = psi_prime;%    Dxpsi_prime = (2*m/(h_bar^2)) *(Vx - E)*psi;%  declare some variables as 'global', because the derivative function %  will need to access them, but there isn't another graceful way%  to pass themglobal w m A h_bar E% global parameter definitionw = 2*pi; % angular frequencym = 1; % massA =  10;h_bar = 1;E = 1;x0 = 0;xfinal = 3;% For even statespsi = 1;psi_prime = 0;% For odd states%psi = 0;%psi_prime = 1;function Vx = potential(x)Vx = -A*exp((-x^2)/(w^2));endfunction% Solving time independent Shrodinger equfunction ydot = hosc_func(x, y, Vx)  % unpack input vector  psi = y(1);  psi_prime = y(2);  % compute derivatives  Dxpsi = psi_prime;  Dxpsi_prime = (2*m/(h_bar^2)) *(Vx - E)*psi;  % pack output derivative vector  ydot = [Dxpsi; Dxpsi_prime];  endfunction% for the integrator, you need a function to evaluate the derivative% (i.e., the right-hand side) of the differential equation.function Dxpsi_prime_out = shrodinger_solver( )  global w m A h_bar E% pack initial conditionsy0 = [psi; psi_prime];% now use ode45 (fourth and fifth order Runge Kutta method)% to solve differential equation.[xout, yout] = ode45('hosc_func', [x0, xfinal], y0);% unpack solutionspsi_out = yout(:,1);Dxpsi_prime_out = yout(:,2);% get final valuexfinal = xout(length(xout));printf("final position: x = %f\n", xfinal);% plot the resultplot(xout, psi_out);xlabel('x');ylabel('Psi(x)');title('Schrodinger equation finder');endfunction% The above plot only uses time points used in the integration; for a %   smoother plot you will have to define a high-resolution time grid%   and interpolate ode45's solution.  Something like:% tarr = (t0:(tfinal/1000):tfinal)';% plot(tarr, interp1 (tout, xout, tarr, "spline"));% To save your plot to a pdf file, do something like:% print("myplot.pdf")% bisect.m%% Simple demonstration of bisection root-finding method.% parametersa = 0; b = 4;  % initial bracketing of roottol = 1.e-8;   % error tolerance of root estimatevx = 10;%print ("%f",Dxpsi_prime_out);% find the eigenvalue after getting Dxpsi_prime%{function y = rootfunc(E, Dxpsi_prime_out )  psi = Dxpsi_prime_out /((2*m/(h_bar^2))*(Vx - E))endfunction% pre-evaluate function at ends of bracketing intervalfa = rootfunc(a); fb = rootfunc(b);printf(fa, fb);%}