%==========================================================================
% nc_get_att    ---   nc_toolbox
%   Define an attribute in an existing NetCDF file
%
% input  :
%   fin        --- input NetCDF file path and name
%   var_name   --- varaible name ([] for global)
%   att_name   --- attribute name
%                     
% output :
%   att_value  --- attribute value
%
% Siqi Li, SMAST
% 2022-04-06
%
% Updates:
%
%==========================================================================
function att_value = nc_get_att(fin, var_name, att_name)

ncid = nc_open(fin);


% Get variable ID
if isempty(var_name)
    varid = netcdf.getConstant('GLOBAL');
else
    varid = netcdf.inqVarID(ncid, var_name);
end

att_value = netcdf.getAtt(ncid, varid, att_name);


nc_close(ncid);