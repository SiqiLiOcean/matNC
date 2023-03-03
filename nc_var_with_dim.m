%==========================================================================
% nc_var_with_dim    ---   nc_toolbox
%   Check if a variable has a certain dimension.
%
% input  :
%   fin     --- input NetCDF file path and name
%   varname --- variable name
%   dimname --- dimension name
% 
% output :
%   result --- 1 : the var has the dimension
%
% Siqi Li, SMAST
% 2022-04-28
%
% Updates:
%
%==========================================================================
function result = nc_var_with_dim(fin, varname, dimname)



ncid = netcdf.open(fin);
dimid = netcdf.inqDimID(ncid, dimname);

varid = netcdf.inqVarID(ncid,varname);
[~,~,dimids] = netcdf.inqVar(ncid, varid);

result = ismember(dimid, dimids);

netcdf.close(ncid);
