%==========================================================================
% nc_get_vars    ---   nc_toolbox
%   Read all variables in an existing NetCDF file
%
% input  :
%   fin        --- input NetCDF file path and name
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
function data = nc_get_vars(fin)

ncid = nc_open(fin);

[~, nvars] = netcdf.inq(ncid);

for i = 1 : nvars
    varid = i - 1;
    data(i).name = netcdf.inqVar(ncid, varid);
    data(i).value = netcdf.getVar(ncid, varid);
    
    if isnumeric(data(i).value(1))
        data(i).min = min(data(i).value(:));
        data(i).max = max(data(i).value(:));
    else
        data(i).min = [];
        data(i).max = [];
    end
end

nc_close(ncid);

end

