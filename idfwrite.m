function idfwrite(filename, data)
%IDFWRITE - Write EnergyPlus IDF file.
%
%   idfwrite(filename, data): write the array of EnergyPlus objects data
%   into the file filename.


fid = fopen(filename, 'wt');
N = length(data);
for n = 1 : N
   obj = data(n);
   fprintf(fid, strcat(obj.class, ', \n'));
   M = length(obj.fields);
   for m = 1 : M 
       fprintf(fid, obj.fields{m});
       if m == M
           fprintf(fid, '; \n');
       else
           fprintf(fid, ', \n');
       end
   end
end
fclose(fid);
end

