function writefunc(FuncName, FuncVar, FuncBody)
% Write a function .m file 
% Usage  writefunc('myadd', 'x,y', 'x+y') 
% Author: Ruoxi Sun 

HesFileName = FuncName;
InputStr1 = FuncVar;
Hfid = fopen([HesFileName,'.m'],'w+');
Hfuncstr = ['function [out] = ',HesFileName,'(',InputStr1,')\n'];
fprintf(Hfid,Hfuncstr);
fprintf(Hfid,['out = ', FuncBody, ';\n']);
fprintf(Hfid,'end');
fclose(Hfid);
rehash
end