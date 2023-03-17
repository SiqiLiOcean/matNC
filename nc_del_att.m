%==========================================================================
% nc_del_att    ---   nc_toolbox
%   Delete an attribute in an existing NetCDF file
%
% input  :
%   fin        --- input NetCDF file path and name
%   var_name   --- varaible name ([] for global)
%   att_name   --- attribute name
%                     
% output :
%
% Siqi Li, SMAST
% 2023-03-15
%
% Updates:
%
%==========================================================================
function nc_del_att(fin, var_name, att_name)

ncid = nc_open(fin, 1);

% Re-define mode
nc_redef(ncid);

% Get variable ID
if isempty(var_name)
    varid = netcdf.getConstant('GLOBAL');
else
    varid = netcdf.inqVarID(ncid, var_name);
end

netcdf.delAtt(ncid, varid, att_name)

% End define mode
nc_enddef(ncid);

nc_close(ncid);
