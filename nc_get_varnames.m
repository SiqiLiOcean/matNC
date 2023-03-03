%==========================================================================
% nc_get_varnames    ---   nc_toolbox
%   Get all the variables names of an existing NetCDF file.
%
% input  :
%   fin     --- input NetCDF file path and name
% 
% output :
%   varnames --- variable names
%
% Siqi Li, SMAST
% 2022-04-28
%
% Updates:
%
%==========================================================================
function varnames = nc_get_varnames(fin)



ncid = netcdf.open(fin);

[~, nvars] = netcdf.inq(ncid);

for i = 1 : nvars
    varnames(i) = convertCharsToStrings(netcdf.inqVar(ncid, i-1));
end

netcdf.close(ncid);
