% This code was generated using ADiGator version 1.3
% ©2010-2014 Matthew J. Weinstein and Anil V. Rao
% ADiGator may be obtained at https://sourceforge.net/projects/adigator/ 
% Contact: mweinstein@ufl.edu
% Bugs/suggestions may be reported to the sourceforge forums
%                    DISCLAIMER
% ADiGator is a general-purpose software distributed under the GNU General
% Public License version 3.0. While the software is distributed with the
% hope that it will be useful, both the software and generated code are
% provided 'AS IS' with NO WARRANTIES OF ANY KIND and no merchantability
% or fitness for any purpose or application.

function out = negLikelihood_2_ADiGatorGrd(x,w,y,c,baseline,one,Xt,Yt)
global ADiGator_negLikelihood_2_ADiGatorGrd
if isempty(ADiGator_negLikelihood_2_ADiGatorGrd); ADiGator_LoadData(); end
Gator1Data = ADiGator_negLikelihood_2_ADiGatorGrd.negLikelihood_2_ADiGatorGrd.Gator1Data;
% ADiGator Start Derivative Computations
cada1f1 = w(1);
cada1f2 = cada1f1*1;
cada1f3 = cada1f2/one;
cada1f4 = cada1f3*1;
cada1f5 = abs(c);
cada1f6 = cada1f5^2;
cada1f7 = 6.283185307179586*cada1f6;
cada1f8 = cada1f4/cada1f7;
cada1f9dx = x.dx(1);
cada1f9 = x.f(1);
cada1tempdx = cada1f9dx(Gator1Data.Index1);
cada1f10dx = -cada1tempdx;
cada1f10 = Xt - cada1f9;
cada1f11dx = 2.*cada1f10(:).^(2-1).*cada1f10dx;
cada1f11 = cada1f10.^2;
cada1f12dx = x.dx(3);
cada1f12 = x.f(3);
cada1tempdx = cada1f12dx(Gator1Data.Index2);
cada1f13dx = -cada1tempdx;
cada1f13 = Yt - cada1f12;
cada1f14dx = 2.*cada1f13(:).^(2-1).*cada1f13dx;
cada1f14 = cada1f13.^2;
cada1td1 = zeros(2048,1);
cada1td1(Gator1Data.Index3) = cada1f11dx;
cada1td1(Gator1Data.Index4) = cada1td1(Gator1Data.Index4) + cada1f14dx;
cada1f15dx = cada1td1;
cada1f15 = cada1f11 + cada1f14;
cada1f16dx = -cada1f15dx;
cada1f16 = uminus(cada1f15);
cada1f17 = c^2;
cada1f18 = 2*cada1f17;
cada1f19dx = cada1f16dx./cada1f18;
cada1f19 = cada1f16/cada1f18;
cada1tf1 = cada1f19(Gator1Data.Index5);
cada1f20dx = exp(cada1tf1(:)).*cada1f19dx;
cada1f20 = exp(cada1f19);
cada1f21dx = cada1f8.*cada1f20dx;
cada1f21 = cada1f8*cada1f20;
cada1f22dx = cada1f21dx;
cada1f22 = baseline + cada1f21;
cada1f23 = w(2);
cada1f24 = cada1f23*1;
cada1f25 = cada1f24/one;
cada1f26 = cada1f25*1;
cada1f27 = abs(c);
cada1f28 = cada1f27^2;
cada1f29 = 6.283185307179586*cada1f28;
cada1f30 = cada1f26/cada1f29;
cada1f31dx = x.dx(2);
cada1f31 = x.f(2);
cada1tempdx = cada1f31dx(Gator1Data.Index6);
cada1f32dx = -cada1tempdx;
cada1f32 = Xt - cada1f31;
cada1f33dx = 2.*cada1f32(:).^(2-1).*cada1f32dx;
cada1f33 = cada1f32.^2;
cada1f34dx = x.dx(4);
cada1f34 = x.f(4);
cada1tempdx = cada1f34dx(Gator1Data.Index7);
cada1f35dx = -cada1tempdx;
cada1f35 = Yt - cada1f34;
cada1f36dx = 2.*cada1f35(:).^(2-1).*cada1f35dx;
cada1f36 = cada1f35.^2;
cada1td1 = zeros(2048,1);
cada1td1(Gator1Data.Index8) = cada1f33dx;
cada1td1(Gator1Data.Index9) = cada1td1(Gator1Data.Index9) + cada1f36dx;
cada1f37dx = cada1td1;
cada1f37 = cada1f33 + cada1f36;
cada1f38dx = -cada1f37dx;
cada1f38 = uminus(cada1f37);
cada1f39 = c^2;
cada1f40 = 2*cada1f39;
cada1f41dx = cada1f38dx./cada1f40;
cada1f41 = cada1f38/cada1f40;
cada1tf1 = cada1f41(Gator1Data.Index10);
cada1f42dx = exp(cada1tf1(:)).*cada1f41dx;
cada1f42 = exp(cada1f41);
cada1f43dx = cada1f30.*cada1f42dx;
cada1f43 = cada1f30*cada1f42;
cada1td1 = zeros(4096,1);
cada1td1(Gator1Data.Index11) = cada1f22dx;
cada1td1(Gator1Data.Index12) = cada1td1(Gator1Data.Index12) + cada1f43dx;
cada1f44dx = cada1td1;
cada1f44 = cada1f22 + cada1f43;
cada1f45dx = -cada1f44dx;
cada1f45 = uminus(cada1f44);
cada1f46 = w(1);
cada1f47 = cada1f46*1;
cada1f48 = cada1f47/one;
cada1f49 = cada1f48*1;
cada1f50 = abs(c);
cada1f51 = cada1f50^2;
cada1f52 = 6.283185307179586*cada1f51;
cada1f53 = cada1f49/cada1f52;
cada1f54dx = x.dx(1);
cada1f54 = x.f(1);
cada1tempdx = cada1f54dx(Gator1Data.Index13);
cada1f55dx = -cada1tempdx;
cada1f55 = Xt - cada1f54;
cada1f56dx = 2.*cada1f55(:).^(2-1).*cada1f55dx;
cada1f56 = cada1f55.^2;
cada1f57dx = x.dx(3);
cada1f57 = x.f(3);
cada1tempdx = cada1f57dx(Gator1Data.Index14);
cada1f58dx = -cada1tempdx;
cada1f58 = Yt - cada1f57;
cada1f59dx = 2.*cada1f58(:).^(2-1).*cada1f58dx;
cada1f59 = cada1f58.^2;
cada1td1 = zeros(2048,1);
cada1td1(Gator1Data.Index15) = cada1f56dx;
cada1td1(Gator1Data.Index16) = cada1td1(Gator1Data.Index16) + cada1f59dx;
cada1f60dx = cada1td1;
cada1f60 = cada1f56 + cada1f59;
cada1f61dx = -cada1f60dx;
cada1f61 = uminus(cada1f60);
cada1f62 = c^2;
cada1f63 = 2*cada1f62;
cada1f64dx = cada1f61dx./cada1f63;
cada1f64 = cada1f61/cada1f63;
cada1tf1 = cada1f64(Gator1Data.Index17);
cada1f65dx = exp(cada1tf1(:)).*cada1f64dx;
cada1f65 = exp(cada1f64);
cada1f66dx = cada1f53.*cada1f65dx;
cada1f66 = cada1f53*cada1f65;
cada1f67dx = cada1f66dx;
cada1f67 = baseline + cada1f66;
cada1f68 = w(2);
cada1f69 = cada1f68*1;
cada1f70 = cada1f69/one;
cada1f71 = cada1f70*1;
cada1f72 = abs(c);
cada1f73 = cada1f72^2;
cada1f74 = 6.283185307179586*cada1f73;
cada1f75 = cada1f71/cada1f74;
cada1f76dx = x.dx(2);
cada1f76 = x.f(2);
cada1tempdx = cada1f76dx(Gator1Data.Index18);
cada1f77dx = -cada1tempdx;
cada1f77 = Xt - cada1f76;
cada1f78dx = 2.*cada1f77(:).^(2-1).*cada1f77dx;
cada1f78 = cada1f77.^2;
cada1f79dx = x.dx(4);
cada1f79 = x.f(4);
cada1tempdx = cada1f79dx(Gator1Data.Index19);
cada1f80dx = -cada1tempdx;
cada1f80 = Yt - cada1f79;
cada1f81dx = 2.*cada1f80(:).^(2-1).*cada1f80dx;
cada1f81 = cada1f80.^2;
cada1td1 = zeros(2048,1);
cada1td1(Gator1Data.Index20) = cada1f78dx;
cada1td1(Gator1Data.Index21) = cada1td1(Gator1Data.Index21) + cada1f81dx;
cada1f82dx = cada1td1;
cada1f82 = cada1f78 + cada1f81;
cada1f83dx = -cada1f82dx;
cada1f83 = uminus(cada1f82);
cada1f84 = c^2;
cada1f85 = 2*cada1f84;
cada1f86dx = cada1f83dx./cada1f85;
cada1f86 = cada1f83/cada1f85;
cada1tf1 = cada1f86(Gator1Data.Index22);
cada1f87dx = exp(cada1tf1(:)).*cada1f86dx;
cada1f87 = exp(cada1f86);
cada1f88dx = cada1f75.*cada1f87dx;
cada1f88 = cada1f75*cada1f87;
cada1td1 = zeros(4096,1);
cada1td1(Gator1Data.Index23) = cada1f67dx;
cada1td1(Gator1Data.Index24) = cada1td1(Gator1Data.Index24) + cada1f88dx;
cada1f89dx = cada1td1;
cada1f89 = cada1f67 + cada1f88;
cada1tf1 = cada1f89(Gator1Data.Index25);
cada1f90dx = 1./cada1tf1(:).*cada1f89dx;
cada1f90 = log(cada1f89);
cada1tf1 = y(Gator1Data.Index26);
cada1f91dx = cada1tf1(:).*cada1f90dx;
cada1f91 = y.*cada1f90;
cada1td1 = cada1f45dx;
cada1td1 = cada1td1 + cada1f91dx;
cada1f92dx = cada1td1;
cada1f92 = cada1f45 + cada1f91;
cada1td1 = zeros(1024,4);
cada1td1(Gator1Data.Index27) = cada1f92dx;
cada1td1 = sum(cada1td1,1);
cada1f93dx = cada1td1(:);
cada1f93 = sum(cada1f92);
out.dx = -cada1f93dx;
out.f = uminus(cada1f93);
%User Line: out = -sum(-(baseline +w(1)*1/one *  1/(2*pi*(abs(c).^2))*exp(-(([Xt]-x(1)).^2 + ([Yt]-x(3)).^2)/(2*(c.^2)))+w(2)*1/one *  1/(2*pi*(abs(c).^2))*exp(-(([Xt]-x(2)).^2 + ([Yt]-x(4)).^2)/(2*(c.^2))))+[y].* log(baseline +w(1)*1/one *  1/(2*pi*(abs(c).^2))*exp(-(([Xt]-x(1)).^2 + ([Yt]-x(3)).^2)/(2*(c.^2)))+w(2)*1/one *  1/(2*pi*(abs(c).^2))*exp(-(([Xt]-x(2)).^2 + ([Yt]-x(4)).^2)/(2*(c.^2)))));
out.dx_size = 4;
out.dx_location = Gator1Data.Index28;
end


function ADiGator_LoadData()
global ADiGator_negLikelihood_2_ADiGatorGrd
ADiGator_negLikelihood_2_ADiGatorGrd = load('negLikelihood_2_ADiGatorGrd.mat');
return
end