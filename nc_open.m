%==========================================================================
% nc_open    ---   nc_toolbox
%   Open an existing NetCDF file
%
% input  :
%   fin --- input NetCDF file path and name
%
% output :
%   ncid --- input file ID
%
% Siqi Li, SMAST
% 2022-04-06
%
% Updates:
%
%==========================================================================
function ncid = nc_open(fin, write_flag)

if ~isfile(fin)
    ncid = nc_create(fin);
    nc_close(ncid);
end

if exist('write_flag', 'var')
    if write_flag
        ncid = netcdf.open(fin, 'WRITE');
        return
    end
end
ncid = netcdf.open(fin, 'NOWRITE');



