%==========================================================================
% nc_put_var    ---   nc_toolbox
%   Put a variable in an existing NetCDF file
%
% input  :
%   fin        --- input NetCDF file path and name
%   var_name   --- varaible name
%   data       --- varaible data
%   start      --- (optional)
%   count      --- (optional)
%   stride     --- (optional)
%                     
%   * start matrix start from 0
% output :
%
% Siqi Li, SMAST
% 2022-04-06
%
% Updates:
% 2023-05-22  Siqi Li  Fixed the bug of one-dimension varaible 
%==========================================================================
function nc_put_var(fin, var_name, data, start, count, stride)


% % Check if the input is one-demension
% if numel(data) == length(data)
%     data = data(:);
% end

% Check if there is an unlimited dimension
dim_unlimited = [ncinfo(fin, var_name).Dimensions.Unlimited];
n = length(dim_unlimited);
nt = size(data, n);
if any(dim_unlimited) && ~exist('start', 'var')
    for i = 1 : nt
        str_start = ['[' repmat('0,',1,n-1) 'i-1]'];
        str_count = '[';
        for j = 1 : n-1
            str_count = [str_count num2str(size(data,j)) ','];
        end
        str_count = [str_count '1]'];
        cmd = ['nc_put_var(fin, var_name, data(' repmat(':,',1,n-1) 'i), ' str_start ', ' str_count ');'];
        eval(cmd);
    end
    return
end

ncid = nc_open(fin, 1);


% Get variable ID
varid = netcdf.inqVarID(ncid, var_name);

if exist('start', 'var')
    
    if exist('count', 'var')
        
        if exist('stride', 'var')
            netcdf.putVar(ncid, varid, start, count, stride, data);
        else
            netcdf.putVar(ncid, varid, start, count, data);
        end
        
    else
        netcdf.putVar(ncid, varid, start, data);
    end
    
else        
    netcdf.putVar(ncid, varid, data);
end

nc_close(ncid);