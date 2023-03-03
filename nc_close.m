%==========================================================================
% nc_close    ---   nc_toolbox
%   Close an opening NetCDF file
%
% input  :
%   ncid --- input NetCDF file ID
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
function nc_close(ncid)

netcdf.close(ncid);