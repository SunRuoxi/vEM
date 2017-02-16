function writefunc(FuncName, FuncVar, FuncBody)
%Usage  writefunc('myadd', 'x,y', 'x+y') 
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