%==========================================================================
% nc_def_dim    ---   nc_toolbox
%   Define a dimension in an opening NetCDF file
%
% input  :
%   fin        --- input NetCDF file path and name
%   dim_name   --- dimension name
%   dim_length --- dimension length (non-positive for unlimited)
%
% output :
%   dimid      --- dimension ID
%
% Siqi Li, SMAST
% 2022-04-06
%
% Updates:
%
%==========================================================================
function dimid = nc_def_dim(fin, dim_name, dim_length)

% Set dim_length
if dim_length<1
    dim_length = netcdf.getConstant('NC_UNLIMITED');
end

ncid =nc_open(fin, 1);

nc_redef(ncid);

dimid = netcdf.defDim(ncid, dim_name, dim_length);

nc_enddef(ncid);

nc_close(ncid);