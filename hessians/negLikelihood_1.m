function [out] = negLikelihood_1(x, w, y, c, baseline, one,Xt, Yt)
out = -sum(-(baseline +w(1)*1/one *  1/(2*pi*(abs(c).^2))*exp(-(([Xt]-x(1)).^2 + ([Yt]-x(2)).^2)/(2*(c.^2))))+[y].* log(baseline +w(1)*1/one *  1/(2*pi*(abs(c).^2))*exp(-(([Xt]-x(1)).^2 + ([Yt]-x(2)).^2)/(2*(c.^2)))));
end