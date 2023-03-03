%==========================================================================
% nc_copy_dim    ---   nc_toolbox
%   Copy attributes of global/an attribute from one file to the other
%
% input  :
%   fin        --- input NetCDF file path and name
%   dim_name1  --- dimension name ([] for All)
%   fout       --- output NetCDF file path and name
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
function nc_copy_dim(fin, dim_name, fout)

% if ~exist('var_name2', 'var')
%     var_name2 = var_name1;
% end
    
ncid1 = nc_open(fin);
ncid2 = nc_open(fout, 1);


nc_redef(ncid2);

info = ncinfo(fin);
if isempty(dim_name)
    dim_name = {info.Dimensions.Name};
else
    if ischar(dim_name)
        dim_name = convertCharsToStrings(dim_name);
    end
end

% Copy the dimensions
for id = 1 : length(dim_name)
    dimid = netcdf.inqDimID(ncid1, dim_name{id});
    [~, dim_length] = netcdf.inqDim(ncid1, dimid);
    netcdf.defDim(ncid2, dim_name{id}, dim_length);
end

nc_enddef(ncid2);


nc_close(ncid1);
nc_close(ncid2);
