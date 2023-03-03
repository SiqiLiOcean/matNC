%==========================================================================
% nc_copy_data    ---   nc_toolbox
%   Copy data of one variable from one file to the other
%
% input  :
%   fin        --- input NetCDF file path and name
%   var_name1  --- varaible name in input
%   fout       --- output NetCDF file path and name
%   var_name2  --- varaible name in output
%                     
% output :
%   \
%
% Siqi Li, SMAST
% 2022-04-06
%
% Updates:
%
%==========================================================================
function nc_copy_data(fin, var_name1, fout, var_name2)

if ~exist('var_name2', 'var')
    var_name2 = var_name1;
end

data = nc_get_var(fin, var_name1);

nc_put_var(fout, var_name2, data);



