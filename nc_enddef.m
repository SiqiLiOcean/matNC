%==========================================================================
% nc_enddef    ---   nc_toolbox
%   End define mode of an opening NetCDF file
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
function nc_enddef(ncid)

netcdf.endDef(ncid);