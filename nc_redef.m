%==========================================================================
% nc_redef    ---   nc_toolbox
%   Set define mode of an opening NetCDF file
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
function nc_redef(ncid)

netcdf.reDef(ncid);