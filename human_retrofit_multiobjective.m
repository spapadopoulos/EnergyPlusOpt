function y = human_retrofit_multiobjective(x)

path = '..\models\comm\MD_BALTIMORE.idf';
pathOut = '..\models\comm\MD_BALTIMORE_out.idf';
weatherFile = 'USA_MD_Baltimore-Washington.Intl.AP.724060_TMY3';

IDF = idfread(path);

temp = IDF;
N = length(temp);

for n = 1:N
    object = IDF(n);
    
    if strcmp('Schedule:Compact', object.class)
        if strcmp('CLGSETP_SCH', object.fields{1})
            temp(n).fields{8} = num2str(x(1));
            temp(n).fields{15} = num2str(x(1));
            temp(n).fields{6} = num2str(x(3));
            temp(n).fields{10} = num2str(x(3));
            temp(n).fields{13} = num2str(x(3));
            temp(n).fields{17} = num2str(x(3));
            temp(n).fields{20} = num2str(x(3));
            temp(n).fields{23} = num2str(x(3));
        end
        
        if strcmp('HTGSETP_SCH', object.fields{1})
            temp(n).fields{8} = num2str(x(2));
            temp(n).fields{18} = num2str(x(2));
            temp(n).fields{23} = num2str(x(2));
            temp(n).fields{6} = num2str(x(4));
            temp(n).fields{10} = num2str(x(4));
            temp(n).fields{13} = num2str(x(4));
            temp(n).fields{16} = num2str(x(4));
            temp(n).fields{20} = num2str(x(4));
            temp(n).fields{26} = num2str(x(4));
        end
    end
end

idfwrite(pathOut, temp);
try 
    OUT = runep(pathOut, weatherFile);
    y(1) = mean(mean(OUT(OUT(:,2)>0, 18:33))); % Avg annual PPD
    y(2) = (sum(sum(OUT(:,37:42))))*2.77778e-10;    % TotEnergy: (sum(sum(OUT(:,35:36))))*2.77778e-10; % Transformation to MWh
catch
    % Baltimore
    y(1) = 12.5619;
    y(2) = 1.0361e+13*2.7778e-10; 

end

end
