%==========================================================================
% nc_def_att    ---   nc_toolbox
%   Define an attribute in an existing NetCDF file
%
% input  :
%   fin        --- input NetCDF file path and name
%   var_name   --- varaible name ([] for global)
%   att_name   --- attribute name
%   att_value  --- attribute value
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
function nc_def_att(fin, var_name, att_name, att_value)

ncid = nc_open(fin, 1);

nc_redef(ncid);

% Get variable ID
if isempty(var_name)
    varid = netcdf.getConstant('GLOBAL');
else
    varid = netcdf.inqVarID(ncid, var_name);
end

netcdf.putAtt(ncid, varid, att_name, att_value);


nc_enddef(ncid);

nc_close(ncid);