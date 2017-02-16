function y = floor(x)
% CADA overloaded FLOOR function: calls cadaunarymath - derivative set to
% zero
global ADIGATOR
NUMvod  = ADIGATOR.NVAROFDIFF;
% Remove derivatives of x
x.deriv = struct('name',cell(NUMvod,1),'nzlocs',cell(NUMvod,1));
y = cadaunarymath(x,1,'floor');
if ~ADIGATOR.RUNFLAG
  numvars = find(ADIGATOR.VARINFO.NAMELOCS(:,1),1,'last');
  cadaCancelDerivs(y.id,numvars);
end