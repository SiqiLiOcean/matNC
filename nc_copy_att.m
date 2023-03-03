%==========================================================================
% nc_copy_att    ---   nc_toolbox
%   Copy attributes of global/an attribute from one file to the other
%
% input  :
%   fin        --- input NetCDF file path and name
%   var_name1  --- variable name ([] for global)
%   fout       --- output NetCDF file path and name
%   var_name2  --- variable name ([] for global) (if missing, then same as var_name1)
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
function nc_copy_att(fin, var_name1, fout, var_name2)

if ~exist('var_name2', 'var')
    var_name2 = var_name1;
end
    
ncid1 = nc_open(fin);
ncid2 = nc_open(fout, 1);

if isempty(var_name1)
    varid1 = netcdf.getConstant('NC_GLOBAL');
    [~, ~, natt] = netcdf.inq(ncid1);
else
    varid1 = netcdf.inqVarID(ncid1, var_name1);
    [~, ~, ~, natt] = netcdf.inqVar(ncid1, varid1);
end

if isempty(var_name2)
    varid2 = netcdf.getConstant('NC_GLOBAL');
else
    varid2 = netcdf.inqVarID(ncid2, var_name2);
end

nc_redef(ncid2);



for i = 0 : natt-1
    att_name = netcdf.inqAttName(ncid1, varid1, i);
    netcdf.copyAtt(ncid1, varid1, att_name, ncid2, varid2);
end

nc_enddef(ncid2);


nc_close(ncid1);
nc_close(ncid2);
