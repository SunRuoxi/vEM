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

function out = negLikelihood_1_ADiGatorGrd(x,w,y,c,baseline,one,Xt,Yt)
global ADiGator_negLikelihood_1_ADiGatorGrd
if isempty(ADiGator_negLikelihood_1_ADiGatorGrd); ADiGator_LoadData(); end
Gator1Data = ADiGator_negLikelihood_1_ADiGatorGrd.negLikelihood_1_ADiGatorGrd.Gator1Data;
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
cada1f12dx = x.dx(2);
cada1f12 = x.f(2);
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
cada1f23dx = -cada1f22dx;
cada1f23 = uminus(cada1f22);
cada1f24 = w(1);
cada1f25 = cada1f24*1;
cada1f26 = cada1f25/one;
cada1f27 = cada1f26*1;
cada1f28 = abs(c);
cada1f29 = cada1f28^2;
cada1f30 = 6.283185307179586*cada1f29;
cada1f31 = cada1f27/cada1f30;
cada1f32dx = x.dx(1);
cada1f32 = x.f(1);
cada1tempdx = cada1f32dx(Gator1Data.Index6);
cada1f33dx = -cada1tempdx;
cada1f33 = Xt - cada1f32;
cada1f34dx = 2.*cada1f33(:).^(2-1).*cada1f33dx;
cada1f34 = cada1f33.^2;
cada1f35dx = x.dx(2);
cada1f35 = x.f(2);
cada1tempdx = cada1f35dx(Gator1Data.Index7);
cada1f36dx = -cada1tempdx;
cada1f36 = Yt - cada1f35;
cada1f37dx = 2.*cada1f36(:).^(2-1).*cada1f36dx;
cada1f37 = cada1f36.^2;
cada1td1 = zeros(2048,1);
cada1td1(Gator1Data.Index8) = cada1f34dx;
cada1td1(Gator1Data.Index9) = cada1td1(Gator1Data.Index9) + cada1f37dx;
cada1f38dx = cada1td1;
cada1f38 = cada1f34 + cada1f37;
cada1f39dx = -cada1f38dx;
cada1f39 = uminus(cada1f38);
cada1f40 = c^2;
cada1f41 = 2*cada1f40;
cada1f42dx = cada1f39dx./cada1f41;
cada1f42 = cada1f39/cada1f41;
cada1tf1 = cada1f42(Gator1Data.Index10);
cada1f43dx = exp(cada1tf1(:)).*cada1f42dx;
cada1f43 = exp(cada1f42);
cada1f44dx = cada1f31.*cada1f43dx;
cada1f44 = cada1f31*cada1f43;
cada1f45dx = cada1f44dx;
cada1f45 = baseline + cada1f44;
cada1tf1 = cada1f45(Gator1Data.Index11);
cada1f46dx = 1./cada1tf1(:).*cada1f45dx;
cada1f46 = log(cada1f45);
cada1tf1 = y(Gator1Data.Index12);
cada1f47dx = cada1tf1(:).*cada1f46dx;
cada1f47 = y.*cada1f46;
cada1td1 = cada1f23dx;
cada1td1 = cada1td1 + cada1f47dx;
cada1f48dx = cada1td1;
cada1f48 = cada1f23 + cada1f47;
cada1td1 = zeros(1024,2);
cada1td1(Gator1Data.Index13) = cada1f48dx;
cada1td1 = sum(cada1td1,1);
cada1f49dx = cada1td1(:);
cada1f49 = sum(cada1f48);
out.dx = -cada1f49dx;
out.f = uminus(cada1f49);
%User Line: out = -sum(-(baseline +w(1)*1/one *  1/(2*pi*(abs(c).^2))*exp(-(([Xt]-x(1)).^2 + ([Yt]-x(2)).^2)/(2*(c.^2))))+[y].* log(baseline +w(1)*1/one *  1/(2*pi*(abs(c).^2))*exp(-(([Xt]-x(1)).^2 + ([Yt]-x(2)).^2)/(2*(c.^2)))));
out.dx_size = 2;
out.dx_location = Gator1Data.Index14;
end


function ADiGator_LoadData()
global ADiGator_negLikelihood_1_ADiGatorGrd
ADiGator_negLikelihood_1_ADiGatorGrd = load('negLikelihood_1_ADiGatorGrd.mat');
return
end