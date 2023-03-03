%==========================================================================
% nc_get_var_dim    ---   nc_toolbox
%   Read dimensions of a variable in an existing NetCDF file
%
% input  :
%   fin        --- input NetCDF file path and name
%   var_name   --- variable name
%
% output :
%   dim_length --- dimension length
%   dimdid     --- dimension ID
%
% Siqi Li, SMAST
% 2022-04-06
%
% Updates:
%
%==========================================================================
function [dimid, dim_name, dim_length] = nc_get_var_dim(fin, var_name)

ncid =nc_open(fin);

% Get variable ID
varid = netcdf.inqVarID(ncid, var_name);


[~,~,dimid] = netcdf.inqVar(ncid,varid);

for i = 1 : length(dimid)
    [name, dim_length(i)] = netcdf.inqDim(ncid, dimid(i));
    dim_name(i) = convertCharsToStrings(name); 
end

nc_close(ncid);