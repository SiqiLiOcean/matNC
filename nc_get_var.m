%==========================================================================
% nc_get_var    ---   nc_toolbox
%   Read a variable in an existing NetCDF file
%
% input  :
%   fin        --- input NetCDF file path and name
%   var_name   --- varaible name
%   start      --- (optional)
%   count      --- (optional)
%   stride     --- (optional)
%                     
% output :
%   data       --- varaible data
%
% Siqi Li, SMAST
% 2022-04-06
%
% Updates:
%
%==========================================================================
function data = nc_get_var(fin, var_name, start, count, stride)

ncid = nc_open(fin);


% Get variable ID
varid = netcdf.inqVarID(ncid, var_name);

if exist('start', 'var')
    
    if exist('count', 'var')
        
        if exist('stride', 'var')
            data = netcdf.getVar(ncid, varid, start, count, stride);
        else
            data = netcdf.getVar(ncid, varid, start, count);
        end
        
    else
        data = netcdf.getVar(ncid, varid, start);
    end
    
else
    data = netcdf.getVar(ncid, varid);
end

nc_close(ncid);