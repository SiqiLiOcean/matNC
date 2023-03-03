%==========================================================================
% nc_get_dim    ---   nc_toolbox
%   Read a dimension length of an opening NetCDF file
%
% input  :
%   fin        --- input NetCDF file path and name
%   dim_name   --- dimension name
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
function [dim_length, dimid] = nc_get_dim(fin, dim_name)

ncid =nc_open(fin);

dimid = netcdf.inqDimID(ncid, dim_name);

[~, dim_length] = netcdf.inqDim(ncid, dimid);

nc_close(ncid);