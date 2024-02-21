%==========================================================================
% nc_def_var    ---   nc_toolbox
%   Define a variable in an opening NetCDF file
%
% input  :
%   fin        --- input NetCDF file path and name
%   dim_name   --- dimension name
%   xtype      --- variable type: int, float, double, char
%                     
% output :
%   varid      --- variable ID
% Siqi Li, SMAST
% 2022-04-06
%
% Updates:
%
%==========================================================================
function varid = nc_def_var(fin, var_name, xtype, dim_names)


% Set xtype
switch lower(xtype)
    case {'int', 'int32'}
        xtype = 'NC_INT';
    case {'float', 'single'}
        xtype = 'NC_FLOAT';
    case 'double'
        xtype = 'NC_DOUBLE';
    case 'char'
        xtype = 'NC_CHAR';
    otherwise
        error('Unknown type. Choose from: int, float, double, char.')
end

% Set dimids
if ischar(dim_names)
    dim_names = convertCharsToStrings(dim_names);
end
n = length(dim_names);
dimids = nan(n, 1);
for i = 1 : n
    [dim_lengths(i), dimids(i)] = nc_get_dim(fin, dim_names{i});
end

if prod(dim_lengths)>1e8
    disp(dim_names)
    disp(dim_lengths)
    error('Your variable size is too large. Check it.')
end
    
ncid =nc_open(fin, 1);

nc_redef(ncid);

varid = netcdf.defVar(ncid, var_name, xtype, dimids);

nc_enddef(ncid);

nc_close(ncid);