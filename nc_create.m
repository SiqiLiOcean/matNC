%==========================================================================
% nc_create    ---   nc_toolbox
%   Create a new NetCDF file
%
% input  :
%   fin --- input NetCDF file path and name
%
% output :
%   ncid --- input file ID
%
% Siqi Li, SMAST
% 2022-04-06
%
% Updates:
%
%==========================================================================
function ncid = nc_create(fin)

ncid = netcdf.create(fin, 'CLOBBER');

